#import "LNRiskDeviceHelp.h"
#import "LNRiskNetReachability.h"
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
@implementation LNRiskDeviceHelp
#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ? @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] : @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ];
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        if ([self isValidatIP:address]) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}
+ (NSDictionary *)getIPAddresses {
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
+ (NSString *)readKeyBoardInputType {
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
+ (NSString *)currentDeviceName {
    return [UIDevice currentDevice].name;
}
+ (BOOL)isJailBreak {
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
+ (NSString *)getcurrentDeviceTelephoneInformation {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mobile;
    if (!carrier.isoCountryCode) {
        mobile = @"无运营商";
    } else {
        mobile = [carrier carrierName];
    }
    return mobile.length > 0 ? mobile : @"";
}
+ (NSString *)GetWifiName {
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
+ (NSString *)locationStr {
    return UserDefaultGetObj(@"LocationLatitudeLongitude") ? UserDefaultGetObj(@"LocationLatitudeLongitude") : @"";
}
+ (CGFloat)screenLight {
    return [[UIScreen mainScreen] brightness];
}
+ (double)getLaunchSystemTime {
    NSTimeInterval timer_ = [NSProcessInfo processInfo].systemUptime;
    NSDate *currentDate   = [NSDate new];
    NSDate *startTime                       = [currentDate dateByAddingTimeInterval:(-timer_)];
    NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];
    return convertStartTimeToSecond;
}
+ (float)batteryLevel {
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
+ (NSDictionary *)getDeviceSound {
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithCapacity:10];
    CGFloat systemCurrent           = [[AVAudioSession sharedInstance] outputVolume];
    [mutableDic setObject:[NSNumber numberWithFloat:systemCurrent] forKey:@"systemCurrent"]; 
    [mutableDic setObject:@(1) forKey:@"systemMax"]; 
    return mutableDic;
}
+ (NSString *)appBundleId {
    return [[NSBundle mainBundle] bundleIdentifier];
}
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)buildNumber {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSString *)sdkVersion{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"LNRiskBunldle" ofType:@"bundle"];
    NSString *plistPath =  [path stringByAppendingPathComponent:@"Root.plist"];
    NSDictionary *deviceListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *sdkVesrion = [deviceListDic valueForKey:@"sdkVersion"];
    return sdkVesrion;
}
@end
