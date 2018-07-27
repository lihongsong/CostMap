//
//  DeviceHelp.m
//  EasyLoan
//
//  Created by liyanbo on 15/2/2.
//  Copyright (c) 2015年 hyron. All rights reserved.
//
//#import "LNRiskControlManager.h"

//#import "LNRiskGPSService.h"

#import "LNRiskDeviceHelp.h"

//#import "UIDevice+LNRiksHardware.h"
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
        //筛选出IP地址格式
        if ([self isValidatIP:address]) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses {

    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];

    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if (!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */) {
                continue; // deeply nested code harder to read
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
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)readKeyBoardInputType {
//    消除警告
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

// 当前的设备名称
+ (NSString *)currentDeviceName {

    return [UIDevice currentDevice].name;
}

// 判断手机是否越狱
+ (BOOL)isJailBreak {
    // 方式1.判断是否存在越狱文件
    for (int i = 0; i < 5; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:LNRiskexamineBreak_Tool_pathes[0]]]) {
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

// 获取设备运营商的信息
+ (NSString *)getcurrentDeviceTelephoneInformation {

    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

    CTCarrier *carrier = [info subscriberCellularProvider];

    //当前手机所属运营商名称

    NSString *mobile;

    //先判断有没有SIM卡，如果没有则不获取本机运营商

    if (!carrier.isoCountryCode) {

        mobile = @"无运营商";
    } else {

        mobile = [carrier carrierName];
    }

    return mobile.length > 0 ? mobile : @"";
}

// 网络环境
+ (NSString *)networkEnvironment {

    LNRiskReachabilityStatus status = [LNRiskNetReachability sharedManager].networkReachabilityStatus;
    NSString *networkENV        = nil;
    switch (status) {
        case LNRiskReachabilityStatusUnknown:
            networkENV = @"UNKNOWN";
            break;
        case LNRiskReachabilityStatusReachableVia2G:
            networkENV = @"2G";
            break;
        case LNRiskReachabilityStatusReachableVia3G:
            networkENV = @"3G";
            break;
        case LNRiskReachabilityStatusReachableViaWiFi:
            networkENV = [LNRiskDeviceHelp GetWifiName];
            break;

        default:
            break;
    }

    return nil;
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
    }
    return wifiName.length > 0 ? wifiName : @"";
}

+ (NSString *)locationStr {

//    LNRiskManageLocationModel *locationModel = [LNRiskGPSService instance].currentLocation;
//    NSString *locationStr                    = [NSString stringWithFormat:@"%f,%f", locationModel.latitude, locationModel.longitude];
    return GetUserDefault(@"LocationLatitudeLongitude") ? GetUserDefault(@"LocationLatitudeLongitude") : @"";
}

// 屏幕亮度
+ (CGFloat)screenLight {

    return [[UIScreen mainScreen] brightness];
}

// 获取系统的启动时间
+ (double)getLaunchSystemTime {

    NSTimeInterval timer_ = [NSProcessInfo processInfo].systemUptime;
    NSDate *currentDate   = [NSDate new];

    NSDate *startTime                       = [currentDate dateByAddingTimeInterval:(-timer_)];
    NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];

    return convertStartTimeToSecond;
}
// 手机的电量
+ (float)batteryLevel {

    UIDevice *device                = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    return [device batteryLevel];
}

// 判断是否是有效的ip地址
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
            //输出结果
            NSLog(@"%@", result);
            return YES;
        }
    }
    return NO;
}

/**
 获取设备的音量信息
 iOS 只可以获取系统音量，如果在设置中设置了，可以通过监听的的方法获取铃声相关的信息
 @return
 */
+ (NSDictionary *)getDeviceSound {

    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithCapacity:10];
    CGFloat systemCurrent           = [[AVAudioSession sharedInstance] outputVolume];
    [mutableDic setObject:[NSNumber numberWithFloat:systemCurrent] forKey:@"systemCurrent"]; //系统的视频累类的书籍信息
    [mutableDic setObject:@(1) forKey:@"systemMax"]; //系统的视频累类的书籍信息

    return mutableDic;
}
//buildID
+ (NSString *)appBundleId {

    return [[NSBundle mainBundle] bundleIdentifier];
}

// app Version号
+ (NSString *)appVersion {

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

// buildNumb 号
+ (NSString *)buildNumber {

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

// SDK 的version
+(NSString *)sdkVersion{
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"LNRiskBunldle" ofType:@"bundle"];
    
    NSString *plistPath =  [path stringByAppendingPathComponent:@"Root.plist"];
    
    NSDictionary *deviceListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *sdkVesrion = [deviceListDic valueForKey:@"sdkVersion"];
    return sdkVesrion;
}

@end
