//
//  DeviceHelp.m
//  Easy
//
//  Created by liyanbo on 15/2/2.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import "DeviceHelp.h"
#import "DeviceTypes.h"
#import "UIDevice+LNRiksHardware.h"
#import "LNRiskDeviceHelp.h"
#import <RCMobClick/RCBaseCommon.h>
@implementation DeviceHelp

#pragma mark - 获取app是否第一次安装或者更新
+ (BOOL)isAppFirstInstall{
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
+(NSString *)getStoredAppVersionInfo{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastVersion"];
}
+(void)storeAppVesrionInfo:(NSString *)appVesrionInfo{
    [[NSUserDefaults standardUserDefaults] setObject:appVesrionInfo forKey:@"lastVersion"];
}
+(NSString *)getCurrentVersionInfo{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)getCurrentBundleName {
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"];
}


////手机设备信息
+ (NSDictionary *)collectDeviceInfo {
    
    NSString *screen = [NSString stringWithFormat:@"%.f*%.f", [UIScreen mainScreen].currentMode.size.width, [UIScreen mainScreen].currentMode.size.height];
    
    NSString *originModel = [[UIDevice currentDevice] hardwareString];
    
    NSString *memory = [NSString stringWithFormat:@"%luByte", (unsigned long)[UIDevice totalMemoryBytes]]; // 总内存的大小
    
    NSString *ip = [LNRiskDeviceHelp getIPAddress:YES];
    
    NSString *deviceNo = [RCBaseCommon getUIDString];   // 跟安卓统一，deviceNo和deviceToken同时传，均为uid
    
    NSString *deviceToken = [RCBaseCommon getUIDString]; // 设备的唯一标示符
    
    NSString *availableCapacity = [NSString stringWithFormat:@"%lldByte", [UIDevice freeDiskSpaceBytes]]; // 可用磁盘的大小
    
    NSString *capacity = [NSString stringWithFormat:@"%lldByte", [UIDevice totalDiskSpaceBytes]]; // 总磁盘的大小
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]; //userAgent
    
    NSString *sdk = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]; // 当前系统名称及版本号
    
    NSString *macAddress = [UIDevice hj_macAddress];
    
    NSString *idfa = [RCBaseCommon getIdfaString]; // idfa
    
    NSString *platform = [UIDevice getDeviceType]; // 设备的类型 iPhone 或者iPad
    
//    NSString *channelId = LNSharedRiskConfiguration.channelId; // 渠道号
    
    NSString *networkenv = [LNRiskDeviceHelp networkEnvironment]; // 网络环境 3G Wi-Fi
    
    NSString *jailbreak = [NSString stringWithFormat:@"%d", [LNRiskDeviceHelp isJailBreak]]; // 0表示没有越狱，1表示越狱
    
    NSString *devicename = [LNRiskDeviceHelp currentDeviceName]; // 设备的名称
    
    NSString *operatorinfo = [LNRiskDeviceHelp getcurrentDeviceTelephoneInformation]; // 设备的运营商信息
    
    NSString *inputtype = [LNRiskDeviceHelp readKeyBoardInputType]; // 键盘的输入类型
    
    NSString *location = [LNRiskDeviceHelp locationStr]; // 经纬度
    
    NSString *battery = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp batteryLevel]]; // 设备的电量
    
    NSString *cpuType = [UIDevice cpuType]; // CPU类型 ARM ，ARM64
    
    NSDictionary *volume = [LNRiskDeviceHelp getDeviceSound]; //设备的声音信息
    
    NSString *screenLight = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp screenLight]]; //屏幕亮度
    
    NSString *launchSystemTime = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp getLaunchSystemTime]]; //系统启动时间
    
    NSString *lnRiskSdkVersion = [LNRiskDeviceHelp sdkVersion]; // SDK 的版本号
    NSString *appVersion       = [LNRiskDeviceHelp appVersion]; //App的版本号
    NSString *appBundleId      = [LNRiskDeviceHelp appBundleId]; // App的bundleID
    NSString *appBuildNum      = [LNRiskDeviceHelp buildNumber]; //App的build号
    
    NSDictionary *deviceInfo = @{ @"screen" : LNAOPSAFESTRING(screen),
                                  
                                  @"originModel" : LNAOPSAFESTRING(originModel),
                                  
                                  @"imei" : @"",
                                  
                                  @"manfacture" : @"Apple",
                                  
                                  @"cpu" : LNAOPSAFESTRING(cpuType),
                                  
                                  @"mac" : LNAOPSAFESTRING(macAddress),
                                  
                                  @"memory" : LNAOPSAFESTRING(memory),
                                  
                                  @"ip" : LNAOPSAFESTRING(ip),
                                  
                                  @"deviceNo":LNAOPSAFESTRING(deviceNo), //跟安卓统一，deviceNo和deviceToken同时传，均为uid
                                  
                                  @"deviceToken" : LNAOPSAFESTRING(deviceToken),
                                  
                                  @"deviceType" : @1,
                                  
                                  @"availableCapacity" : LNAOPSAFESTRING(availableCapacity),
                                  
                                  @"ua" : LNAOPSAFESTRING(userAgent),
                                  
                                  @"capacity" : LNAOPSAFESTRING(capacity),
                                  
                                  @"sdk" : LNAOPSAFESTRING(sdk),
                                  
                                  @"appChannel" : APP_ChannelId,
                                  
                                  @"idfa" : LNAOPSAFESTRING(idfa),
                                  
                                  @"platform" : LNAOPSAFESTRING(platform),
                                  
                                  @"networkEnv" : LNAOPSAFESTRING(networkenv), // 网络环境
                                  
                                  @"root" : LNAOPSAFESTRING(jailbreak), // 是否越狱
                                  
                                  @"devicename" : LNAOPSAFESTRING(devicename), // iPhone的用户名称
                                  
                                  @"operatorinfo" : LNAOPSAFESTRING(operatorinfo), //运营商的信息
                                  
                                  @"inputtype" : LNAOPSAFESTRING(inputtype), // 输入法的类型
                                  
                                  @"location" : LNAOPSAFESTRING(location), // 位置信息
                                  
                                  @"volume" : volume, // 设备的声音信息
                                  
                                  @"battery" : LNAOPSAFESTRING(battery),
                                  
                                  @"appVersion" : LNAOPSAFESTRING(appVersion),
                                  
                                  @"appBundleId" : LNAOPSAFESTRING(appBundleId),
                                  
                                  @"appBuildNum" : LNAOPSAFESTRING(appBuildNum),
                                  
                                  @"screenLight" : LNAOPSAFESTRING(screenLight),
                                  
                                  @"launchSystemTime" : LNAOPSAFESTRING(launchSystemTime),
                                  };
    
    return deviceInfo;
}

@end
