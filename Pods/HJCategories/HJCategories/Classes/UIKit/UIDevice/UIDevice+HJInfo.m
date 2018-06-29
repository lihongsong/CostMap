//
//  UIDevice+HJInfo.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "UIDevice+HJInfo.h"
#import "SvUDIDTools.h"

#import <Security/Security.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <AdSupport/ASIdentifierManager.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/utsname.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "UIDevice+HJHardware.h"

#define DEVICE_TYPE_NUMBER 0

#define HJ_KUDIDDefaultNumber 40

#define HJ_ASCII_A_Number 65

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (HJInfo)

+ (BOOL)hj_isIPAddress:(NSString *)ip {
    
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:ip];
    
    if (rc) {
        NSArray *componds = [ip componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)hj_IPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self hj_IPAddress];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self hj_isIPAddress:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)hj_IPAddress
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark - 获取app是否第一次安装或者更新
+ (BOOL)hj_isFirstInstallInNewVersion {
    static NSInteger isUpdate = -1; //-1代表未做过判断
    if (isUpdate == -1) {
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString* defaultVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastVersion"];
        
        if(![currentVersion isEqualToString:defaultVersion]){
            
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"lastVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            isUpdate = 1;
        } else {
            isUpdate = 0;
        }
    }
    return isUpdate;
}

+ (NSString *)hj_deviceIDFA{
    NSUUID *idfaUUID = [ASIdentifierManager sharedManager].advertisingIdentifier;
    return idfaUUID.UUIDString;
}

+ (NSString *)hj_deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithString:deviceString];
}

+ (NSString *)hj_appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)hj_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+(NSString *)getStoredAppVersionInfo{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastVersion"];
}

+(void)storeAppVesrionInfo:(NSString *)appVesrionInfo{
    [[NSUserDefaults standardUserDefaults] setObject:appVesrionInfo forKey:@"lastVersion"];
}

+(NSString *)hj_bundleName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+(NSString *)hj_bundleIdentifier{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

//手机设备信息
+ (NSDictionary *)hj_deviceInfo {
    
    NSString *screen = [NSString stringWithFormat:@"%.f*%.f", [UIScreen mainScreen].currentMode.size.width, [UIScreen mainScreen].currentMode.size.height];
    NSString *model = [UIDevice hj_deviceModel];
    NSString *memory = [NSString stringWithFormat:@"%luByte",(unsigned long)[UIDevice hj_totalMemoryBytes]];
    NSString *ip = [UIDevice hj_IPAddress:YES];
    
    // 跟安卓统一，deviceNo和deviceToken同时传，均为uid
    NSString *deviceNo = [UIDevice hj_deviceUDID];
    NSString *deviceToken = [UIDevice hj_deviceUDID];
    NSString *availableCapacity = [NSString stringWithFormat:@"%luByte", (unsigned long)[UIDevice hj_freeMemoryBytes]];
    NSString *capacity = [NSString stringWithFormat:@"%luByte", (unsigned long)[UIDevice hj_totalMemoryBytes]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *sdk = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    NSString *idfa = [UIDevice hj_deviceIDFA];
    NSString *platform = [UIDevice hj_deviceTypeString];
    NSString *appBundleId      = [UIDevice hj_bundleIdentifier];
    
    NSDictionary *deviceInfo = @{@"screen":screen,
                                 @"model":model,
                                 @"imei":@"",
                                 @"manfacture":@"Apple",
                                 @"cpu":@"",
                                 @"mac":@"",
                                 @"memory":memory,
                                 @"ip":ip,
                                 @"deviceNo":deviceNo,
                                 @"deviceToken":deviceToken,
                                 @"deviceType":@1,
                                 @"availableCapacity":availableCapacity,
                                 @"ua":userAgent,
                                 @"capacity":capacity,
                                 @"sdk":sdk,
                                 @"idfa":idfa,
                                 @"platform":platform,
                                 @"appBundleId":appBundleId
                                 };
    
    return deviceInfo;
}

// 获取通讯录信息
+ (NSDictionary *)hj_addressBookInfo {
    //取得本地通信录名柄
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //取得本地所有联系人记录
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSArray* tmpPeoples = (__bridge NSArray*)results;
    NSMutableArray *dicArray = [[NSMutableArray alloc] initWithCapacity:tmpPeoples.count];
    for(int i = 0; i < tmpPeoples.count; i++)
    {
        
        ABRecordRef tmpPerson = CFArrayGetValueAtIndex(results, i);
        NSMutableDictionary *dicPerson = [[NSMutableDictionary alloc] init];
        
        NSString *firstName = (__bridge NSString *)ABRecordCopyValue(tmpPerson, kABPersonFirstNameProperty);
        NSString *lastName = (__bridge NSString *)ABRecordCopyValue(tmpPerson, kABPersonLastNameProperty);
        NSString *name = [NSString stringWithFormat:@"%@%@", lastName ? lastName : @"", firstName ? firstName : @""];
        dicPerson[@"name"] = name;
        
        //获取的联系人单一属性:Company name
        NSString* tmpCompanyname = (__bridge NSString*)ABRecordCopyValue(tmpPerson, kABPersonOrganizationProperty);
        dicPerson[@"company"] = tmpCompanyname ? tmpCompanyname : @"";
        
        //获取的联系人单一属性:Email(s)
        ABMultiValueRef tmpEmails = ABRecordCopyValue(tmpPerson, kABPersonEmailProperty);
        if (ABMultiValueGetCount(tmpEmails) > 0) {
            NSString* tmpEmail = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, 0);
            dicPerson[@"mail"] = tmpEmail;
        } else {
            dicPerson[@"mail"] = @"";
        }
        CFRelease(tmpEmails);
        
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue(tmpPerson, kABPersonPhoneProperty);
        NSMutableArray *arrPhone = [[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(tmpPhones)];
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            NSString* tmpPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            if (tmpPhone) {
                tmpPhone = [[tmpPhone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
                arrPhone[j] = tmpPhone;
            } else {
                arrPhone[j] = @"";
            }
        }
        dicPerson[@"numbers"] = [arrPhone copy];
        CFRelease(tmpPhones);
        
        dicArray[i] = [dicPerson copy];
        
        CFRelease(tmpPerson);
    }
    //释放内存
    CFRelease(results);
    
    NSDictionary *contactInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[dicArray copy], @"contactPersons",
                                 @[], @"contactActions",
                                 nil];
    
    return contactInfo;
}

/*
 * Simply does the same thing which
 * [[UIDevice currentDevice] model] does.
 */
+ (NSString *)hj_deviceTypeString {
    NSString *deviceName = [UIDevice hj_deviceModelName];
    if ([deviceName hasPrefix:@"iPhone"]) {
        return @"iPhone";
    } else if ([deviceName hasPrefix:@"iPod"]) {
        return @"iPod";
    } else if ([deviceName hasPrefix:@"iPad"]) {
        return @"iPad";
    } else {
        return [[UIDevice currentDevice] model];
    }
    
    return @"UNKNOWN";
}

+ (UIDeviceType)hj_deviceType {
    NSString *deviceName = [UIDevice hj_deviceModelName];
    if ([deviceName hasPrefix:@"iPhone"]) {
        return UIDeviceIPhone;
    } else if ([deviceName hasPrefix:@"iPod"]) {
        return UIDeviceIPod;
    } else if ([deviceName hasPrefix:@"iPad"]) {
        return UIDeviceIPad;
    }
    
    return UIDeviceUnKnow;
}

/*
 * Retrieves back the device name or if not the machine name.
 */
+ (NSString*)hj_deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //MARK: More official list is at
    //http://theiphonewiki.com/wiki/Models
    //MARK: You may just return machineName. Following is for convenience
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"i386 Simulator",
      @"x86_64":   @"x86_64 Simulator",
      
      // iPhone http://theiphonewiki.com/wiki/IPhone
      
      @"iPhone1,1":    @"iPhone 1G",
      @"iPhone1,2":    @"iPhone 3G",
      
      @"iPhone2,1":    @"iPhone 3GS",
      
      @"iPhone3,1":    @"iPhone 4(GSM)",
      @"iPhone3,2":    @"iPhone 4(GSM Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      
      @"iPhone4,1":    @"iPhone 4S",
      
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(Global)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(Global)",
      
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(Global)",
      
      @"iPhone7,1":    @"iPhone 6Plus",
      @"iPhone7,2":    @"iPhone 6",
      
      @"iPhone8,1":    @"iPhone 6S",
      @"iPhone8,2":    @"iPhone 6SPlus",
      @"iPhone8,4":    @"iPhone SE",
      
      @"iPhone9,1":    @"iPhone 7",
      @"iPhone9,3":    @"iPhone 7",
      @"iPhone9,2":    @"iPhone 7Plus",
      @"iPhone9,4":    @"iPhone 7Plus",
      
      @"iPhone10,1":   @"iPhone 8",
      @"iPhone10,4":   @"iPhone 8",
      @"iPhone10,2":   @"iPhone 8Plus",
      @"iPhone10,5":   @"iPhone 8Plus",
      
      @"iPhone10,3":   @"iPhone X",
      @"iPhone10,6":   @"iPhone X",
      
      // iPad http://theiphonewiki.com/wiki/IPad
      
      @"iPad1,1":  @"iPad",
      
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad mini 1G (Wi-Fi)",
      @"iPad2,6":  @"iPad mini 1G (GSM)",
      @"iPad2,7":  @"iPad mini 1G (Global)",
      
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(Global)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(Global)",
      
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(Cellular)",
      @"iPad4,4":  @"iPad mini 2G (Wi-Fi)",
      @"iPad4,5":  @"iPad mini 2G (Cellular)",
      @"iPad4,6":  @"iPad mini 2G (Cellular)",
      @"iPad4,7":  @"iPad mini 3G (Wi-Fi)",
      @"iPad4,8":  @"iPad mini 3G (Cellular+Wi-Fi)",
      @"iPad4,9":  @"iPad mini 3G (Cellular)",
      
      @"iPad5,1":  @"iPad mini 4G (Wi-Fi)",
      @"iPad5,2":  @"iPad mini 4G (Cellular)",
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (Cellular)",
      
      @"iPad6,3":  @"iPad Pro (9.7 inch) 1G (Wi-Fi)",
      @"iPad6,4":  @"iPad Pro (9.7 inch) 1G (Cellular)",
      @"iPad6,7":  @"iPad Pro (12.9 inch) 1G (Wi-Fi)",
      @"iPad6,8":  @"iPad Pro (12.9 inch) 1G (Cellular)",
      @"iPad6,11": @"iPad 5 (WiFi)",
      @"iPad6,12": @"iPad 5 (Cellular)",
      @"iPad7,1":  @"iPad Pro (12.9 inch) 2(WiFi)",
      @"iPad7,2":  @"iPad Pro (12.9 inch) 2(Cellular)",
      @"iPad7,3":  @"iPad Pro (10.5 inch) (WiFi)",
      @"iPad7,4":  @"iPad Pro (10.5 inch) (Cellular)",
      
      // iPod http://theiphonewiki.com/wiki/IPod
      
      @"iPod1,1":  @"iPod touch 1G",
      @"iPod2,1":  @"iPod touch 2G",
      @"iPod3,1":  @"iPod touch 3G",
      @"iPod4,1":  @"iPod touch 4G",
      @"iPod5,1":  @"iPod touch 5G",
      @"iPod7,1":  @"iPod touch 6G",
      };
    
    NSString *deviceName = commonNamesDictionary[machineName];
    
    if (deviceName == nil) {
        deviceName = machineName;
    }
    
    return deviceName;
}

/*
 * Following method identifies and categorizes the devices with the same screen size of iPhone5.
 * 1136 x 640 (727,040 total) resolution at 326 ppi, and 4 (3.48 × 1.96) inches.
 * Ex:- iPhone5, iPhone5S, iPhone5C, iPhone SE
 */
+ (BOOL)hj_isIPhone5SizedDevice {
    if (DEVICE_TYPE_NUMBER == 1) {
        return YES;
    }
    if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5(GSM)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5(Global)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5c(GSM)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5c(Global)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5s(GSM)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 5s(Global)"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone SE"]) {
        return YES;
    } else if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone5,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone5,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone5,3"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone5,4"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone6,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone6,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone8,4"]) {
        return YES;
    } else {
        return NO;
    }
}

/*
 * Following method identifies the device based on the devices categorized under the same size of iPhone6.
 * 1334 x 750 (1,000,500 total) at 326 ppi, and 4.7 (4.1 × 2.3) inches
 * Ex:- iPhone6, iPhone6S, iPhone7, iPhone8
 */
+ (BOOL)hj_isIPhone6SizedDevice {
    if (DEVICE_TYPE_NUMBER == 2) {
        return YES;
    }
    if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 6"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 6S"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 7"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 8"]) {
        return YES;
    } else if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone7,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone8,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone9,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone9,3"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,4"]) {
        return YES;
    } else {
        return NO;
    }
}

/*
 * Following method identifies the device based on the devices categorized under the same size of iPhone6+.
 * 1920 x 1080 (2,073,600 total) resolution at 401 ppi, 5.5 (4.79 × 2.7) inches.
 * Ex:- iPhone 6Plus, iPhone 6SPlus,iPhone 7Plus, iPhone8Plus
 */
+ (BOOL)hj_isIPhone6PlusSizedDevice {
    if (DEVICE_TYPE_NUMBER == 3) {
        return YES;
    }
    if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 6Plus"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 6SPlus"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 7Plus"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone 8Plus"]) {
        return YES;
    } else if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone7,1"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone8,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone9,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone9,4"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,2"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,5"]) {
        return YES;
    } else {
        return NO;
    }
}


/*
 * Following method identifies the device based on the devices categorized under the same size of iPhoneX.
 * 2436 x 1125 (2,740,500 total) resolution at 458 ppi, 5.8 inches.
 * Ex:- iPhone X
 */
+ (BOOL)hj_isIPhoneXSizedDevice{
    if (DEVICE_TYPE_NUMBER == 5) {
        return YES;
    }
    if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone X"] ||
        [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone X"]) {
        return YES;
    } else if ([[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,3"] ||
               [[UIDevice hj_deviceModelName] isEqualToString:@"iPhone10,6"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)hj_isIPad {
    if (DEVICE_TYPE_NUMBER == 4) {
        return YES;
    }
    NSArray *arrMachineNames = @[@"iPad1,1", @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4", @"iPad2,5", @"iPad2,6", @"iPad2,7", @"iPad3,1", @"iPad3,2", @"iPad3,3", @"iPad3,4", @"iPad3,5", @"iPad3,6", @"iPad4,1", @"iPad4,2", @"iPad4,3", @"iPad5,3", @"iPad5,4", @"iPad4,4", @"iPad4,5", @"iPad4,6", @"iPad4,7", @"iPad4,8", @"iPad4,9", @"iPad5,1", @"iPad5,2", @"iPad5,3", @"iPad5,4", @"iPad6,3", @"iPad6,4", @"iPad6,7", @"iPad6,8"];
    
    NSArray *arrDeviceNames = @[@"iPad", @"iPad 2(WiFi)", @"iPad 2(GSM)", @"iPad 2(CDMA)", @"iPad 2(WiFi Rev A)", @"iPad Mini 1G (WiFi)", @"iPad Mini 1G (GSM)", @"iPad Mini 1G (Global)", @"iPad 3(WiFi)", @"iPad 3(Global)", @"iPad 3(GSM)", @"iPad 4(WiFi)", @"iPad 4(GSM)", @"iPad 4(Global)", @"iPad Air(WiFi)", @"iPad Air(GSM)", @"iPad Air(Cellular)", @"iPad mini 2G (Wi-Fi)", @"iPad mini 2G (Cellular)", @"iPad mini 3G (Wi-Fi)", @"iPad mini 3G (Cellular)", @"iPad mini 4G (Wi-Fi)", @"iPad mini 4G (Cellular)", @"iPad Air 2 (WiFi)", @"iPad Air 2 (Cellular)", @"iPad Pro (9.7 inch) 1G (Wi-Fi)", @"iPad Pro (9.7 inch) 1G (Cellular)", @"iPad Pro (12.9 inch) 1G (Wi-Fi)", @"iPad Pro (12.9 inch) 1G (Cellular)"];
    
    BOOL result = NO;
    if ([arrDeviceNames containsObject:[UIDevice hj_deviceModelName]]) {
        result = YES;
    } else if ([arrMachineNames containsObject:[UIDevice hj_deviceModelName]]) {
        result = YES;
    }
    
    return result;
}

const char *hj_examineBreak_Tool_pathes[] = {
    
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

char *hj_Env(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}

+ (BOOL)hj_isJailBreak {
    // 方式1.判断是否存在越狱文件
    for (int i = 0; i < 5; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:hj_examineBreak_Tool_pathes[0]]]) {
            return YES;
        }
    }
    // 方式2.判断是否存在cydia应用
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    // 方式3.读取系统所有的应用名称
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]) {
        return YES;
    }
    // 方式4.读取环境变量
    if (hj_Env()) {
        return YES;
    }
    return NO;
}

+ (NSString *)hj_deviceUDID{
    
    NSString *udid = [SvUDIDTools UDID];
    
    if(!udid){
        udid = [self hj_deviceIDFA];
    }
    
    if(!udid){
        udid = [self randomStringByCount:HJ_KUDIDDefaultNumber];
        [SvUDIDTools updateUDIDInKeyChain:udid];
    }
    
    return udid;
}

+ (NSString *)randomStringByCount:(NSInteger)count{
    NSMutableString *tempString = [NSMutableString string];
    for (int i = 0; i < count ; i++) {
        [tempString appendString:[self randomChar]];
    }
    return [tempString copy];
}

+ (NSString *)randomChar{
    
    NSInteger randomNumber = arc4random_uniform(36);
    
    if(randomNumber < 10){
        return [NSString stringWithFormat:@"%ld",(long)randomNumber];
    }else{
        
        NSInteger randomCharNumber = HJ_ASCII_A_Number + randomNumber - 10;
        
        char randomChar = (char)randomCharNumber;
        
        NSString *_char = [NSString stringWithFormat:@"%c",randomChar];
        
        return _char;
        
    }
}

@end
