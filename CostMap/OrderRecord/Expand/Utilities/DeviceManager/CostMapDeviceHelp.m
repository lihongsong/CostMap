#import "CostMapDeviceHelp.h"
#import "CostMapDeviceTypes.h"
#import "UIDevice+YKAHardware.h"

#import "CostMapNetReachability.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <AdSupport/ASIdentifierManager.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <objc/runtime.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AVFoundation/AVFoundation.h>
#define IOS_CELLULAR @"pdp_ip0"
#define IOS_WIFI @"en0"
#define IOS_VPN @"utun0"
#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"

@implementation CostMapDeviceHelp
+ (BOOL)yka_isAppFirstInstall {
    static NSInteger isUpdate = -1; 
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
+(NSString *)yka_getStoredyka_appVersionInfo{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastVersion"];
}
+(void)yka_storeAppVesrionInfo:(NSString *)appVesrionInfo{
    [[NSUserDefaults standardUserDefaults] setObject:appVesrionInfo forKey:@"lastVersion"];
}
+(NSString *)yka_getCurrentVersionInfo{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+(NSString *)yka_getCurrentBundleName {
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"];
}
+ (NSDictionary *)yka_collectDeviceInfo {
    NSString *screen = [NSString stringWithFormat:@"%.f*%.f", [UIScreen mainScreen].currentMode.size.width, [UIScreen mainScreen].currentMode.size.height];
    NSString *originEntity = [[UIDevice currentDevice] hardwareString];
    NSString *memory = [NSString stringWithFormat:@"%luByte", (unsigned long)[UIDevice totalMemoryBytes]]; 
    NSString *ip = [CostMapDeviceHelp yka_getIPAddress:YES];
    NSString *deviceNo = [UIDevice hj_devicePersistenceUUID];
    NSString *deviceToken = [UIDevice hj_devicePersistenceUUID];
    NSString *availableCapacity = [NSString stringWithFormat:@"%lldByte", [UIDevice freeDiskSpaceBytes]]; 
    NSString *capacity = [NSString stringWithFormat:@"%lldByte", [UIDevice totalDiskSpaceBytes]]; 
    UIWebView *webScene = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webScene stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]; 
    NSString *sdk = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]; 
    NSString *macAddress = [UIDevice hj_macAddress];
    NSString *idfa = [UIDevice hj_deviceIDFA]; 
    NSString *platform = [UIDevice getDeviceType]; 
    NSString *networkenv = UserDefaultGetObj(@"networkEnvironment"); 
    NSString *jailbreak = [NSString stringWithFormat:@"%d", [CostMapDeviceHelp yka_isJailBreak]];
    NSString *devicename = [CostMapDeviceHelp yka_currentDeviceName];
    NSString *operatorinfo = [CostMapDeviceHelp yka_getcurrentDeviceTelephoneInformation];
    NSString *inputtype = [CostMapDeviceHelp yka_readKeyBoardInputType];
    NSString *location = [CostMapDeviceHelp yka_locationStr];
    NSString *battery = [NSString stringWithFormat:@"%f", [CostMapDeviceHelp yka_batteryLevel]];
    NSString *cpuType = [UIDevice cpuType]; 
    NSDictionary *volume = [CostMapDeviceHelp yka_getDeviceSound];
    NSString *yka_screenLight = [NSString stringWithFormat:@"%f", [CostMapDeviceHelp yka_screenLight]];
    NSString *launchSystemTime = [NSString stringWithFormat:@"%f", [CostMapDeviceHelp yka_getLaunchSystemTime]];
    NSLog(@"______%@",launchSystemTime);
    NSString *yka_appVersion       = [CostMapDeviceHelp yka_appVersion];
    NSString *yka_appBundleId      = [CostMapDeviceHelp yka_appBundleId];
    NSString *appBuildNum      = [CostMapDeviceHelp yka_buildNumber];
    NSDictionary *deviceInfo = @{ @"screen" : LNAOPSAFESTRING(screen),
                                  @"originEntity" : LNAOPSAFESTRING(originEntity),
                                  @"imei" : @"",
                                  @"manfacture" : @"Apple",
                                  @"cpu" : LNAOPSAFESTRING(cpuType),
                                  @"mac" : LNAOPSAFESTRING(macAddress),
                                  @"memory" : LNAOPSAFESTRING(memory),
                                  @"ip" : LNAOPSAFESTRING(ip),
                                  @"deviceNo":LNAOPSAFESTRING(deviceNo), 
                                  @"deviceToken" : LNAOPSAFESTRING(deviceToken),
                                  @"deviceType" : @1,
                                  @"availableCapacity" : LNAOPSAFESTRING(availableCapacity),
                                  @"ua" : LNAOPSAFESTRING(userAgent),
                                  @"capacity" : LNAOPSAFESTRING(capacity),
                                  @"sdk" : LNAOPSAFESTRING(sdk),
                                  @"appChannel" : APP_ChannelId,
                                  @"idfa" : LNAOPSAFESTRING(idfa),
                                  @"platform" : LNAOPSAFESTRING(platform),
                                  @"networkEnv" : LNAOPSAFESTRING(networkenv), 
                                  @"root" : LNAOPSAFESTRING(jailbreak), 
                                  @"devicename" : LNAOPSAFESTRING(devicename), 
                                  @"operatorinfo" : LNAOPSAFESTRING(operatorinfo), 
                                  @"inputtype" : LNAOPSAFESTRING(inputtype), 
                                  @"location" : LNAOPSAFESTRING(location), 
                                  @"volume" : volume, 
                                  @"battery" : LNAOPSAFESTRING(battery),
                                  @"yka_appVersion" : LNAOPSAFESTRING(yka_appVersion),
                                  @"yka_appBundleId" : LNAOPSAFESTRING(yka_appBundleId),
                                  @"appBuildNum" : LNAOPSAFESTRING(appBuildNum),
                                  @"yka_screenLight" : LNAOPSAFESTRING(yka_screenLight),
                                  @"launchSystemTime" : LNAOPSAFESTRING(launchSystemTime),
                                  };
    return deviceInfo;
}

+ (NSString *)yka_getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ? @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] : @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ];
    NSDictionary *addresses = [self yka_getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        if ([self isValidatIP:address]) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}
+ (NSDictionary *)yka_getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    struct ifaddrs *interfaces;
    if (!getifaddrs(&interfaces)) {
        struct ifaddrs *interface;
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (!(interface->ifa_flags & IFF_UP) ) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in *)interface->ifa_addr;
            char addrBuf[MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN)];
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if (addr->sin_family == AF_INET) {
                    if (inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6 *)interface->ifa_addr;
                    if (inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if (type) {
                    NSString *key  = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
+ (NSString *)yka_readKeyBoardInputType {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UITextInputMode *model = [UITextInputMode currentInputMode];
#pragma clang diagnostic pop
    NSMutableArray *array = [NSMutableArray array];
    unsigned int outCount = 0;
    Ivar *ivars           = class_copyIvarList([model class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Ivar ivar        = ivars[i];
        const char *name = ivar_getName(ivar);
        [array addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
    }
    NSString *inputTypeStr = nil;
    if ([array containsObject:@"identifier"]) {
        inputTypeStr = [model valueForKey:@"identifier"];
    }
    return inputTypeStr.length > 0 ? inputTypeStr : @"";
}
+ (NSString *)yka_currentDeviceName {
    return [UIDevice currentDevice].name;
}
+ (BOOL)yka_isJailBreak {
    for (int i = 0; i < 5; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:LNRiskexamineBreak_Tool_pathes[0]]]) {
            return YES;
        }
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]) {
        return YES;
    }
    if (LNRiskPrintEnv()) {
        return YES;
    }
    return NO;
}
const char *LNRiskexamineBreak_Tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"};
char *LNRiskPrintEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}
+ (NSString *)yka_getcurrentDeviceTelephoneInformation {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mobile;
    if (!carrier.isoCountryCode) {
        mobile = @"no operator";
    } else {
        mobile = [carrier carrierName];
    }
    return mobile.length > 0 ? mobile : @"";
}
+ (NSString *)getWifiName {
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary *)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
        CFRelease(myArray);
    }
    return wifiName.length > 0 ? wifiName : @"";
}
+ (NSString *)yka_locationStr {
    return UserDefaultGetObj(@"LocationLatitudeLongitude") ? UserDefaultGetObj(@"LocationLatitudeLongitude") : @"";
}
+ (CGFloat)yka_screenLight {
    return [[UIScreen mainScreen] brightness];
}
+ (double)yka_getLaunchSystemTime {
    NSTimeInterval timer_ = [NSProcessInfo processInfo].systemUptime;
    NSDate *currentDate   = [NSDate new];
    NSDate *startTime                       = [currentDate dateByAddingTimeInterval:(-timer_)];
    NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];
    return convertStartTimeToSecond;
}
+ (float)yka_batteryLevel {
    UIDevice *device                = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    return [device batteryLevel];
}
+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result    = [ipAddress substringWithRange:resultRange];
            NSLog(@"%@", result);
            return YES;
        }
    }
    return NO;
}
+ (NSDictionary *)yka_getDeviceSound {
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithCapacity:10];
    CGFloat systemCurrent           = [[AVAudioSession sharedInstance] outputVolume];
    [mutableDic setObject:[NSNumber numberWithFloat:systemCurrent] forKey:@"systemCurrent"];
    [mutableDic setObject:@(1) forKey:@"systemMax"];
    return mutableDic;
}
+ (NSString *)yka_appBundleId {
    return [[NSBundle mainBundle] bundleIdentifier];
}
+ (NSString *)yka_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)yka_buildNumber {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSString *)yka_sdkVersion{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"LNRiskBunldle" ofType:@"bundle"];
    NSString *plistPath =  [path stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *deviceListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *sdkVesrion = [deviceListDic valueForKey:@"yka_sdkVersion"];
    return sdkVesrion;
}

/**
 判断是否设置代理
 
 @return YES连接了代理，NO没有连接代理
 */
+(BOOL)isNetProxy {
    return NO;
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.yypt.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = nil;
    if (proxies && proxies.count > 0) {
        settings = proxies[0];
        if (settings) {
            if(![@"kCFProxyTypeNone"isEqualToString:[settings objectForKey:(NSString *)kCFProxyTypeKey]]){
                return YES;
            }
        }
    }
    return NO;
}

@end
