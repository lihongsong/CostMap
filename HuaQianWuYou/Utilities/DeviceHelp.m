//
//  DeviceHelp.m
//  Easy
//
//  Created by liyanbo on 15/2/2.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import "DeviceHelp.h"
#import "DeviceTypes.h"

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

/*
//手机设备信息
+ (NSDictionary *)collectDeviceInfo {
    
    NSString *screen = [NSString stringWithFormat:@"%.f*%.f", [UIScreen mainScreen].currentMode.size.width, [UIScreen mainScreen].currentMode.size.height];
    NSString *model = [DeviceTypes deviceModelName];
    NSString *memory = [NSString stringWithFormat:@"%luByte",(unsigned long)[UIDevice hj_totalMemoryBytes]];
    NSString *ip = [DeviceHelp getIPAddress:YES];
    NSString *deviceNo = [RCBaseCommon getUIDString];  // 跟安卓统一，deviceNo和deviceToken同时传，均为uid
    NSString *deviceToken = [RCBaseCommon getUIDString];
    NSString *availableCapacity = [NSString stringWithFormat:@"%lldByte", [UIDevice hj_freeDiskSpaceBytes]];
    NSString *capacity = [NSString stringWithFormat:@"%lldByte", [UIDevice hj_totalDiskSpaceBytes]];
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent=[webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *sdk = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    NSString *idfa = [RCBaseCommon getIdfaString];
    NSString *platform = [DeviceTypes getDeviceType];
    
    NSString *appBundleId      = [RCBaseCommon getBundleIdentifier]; // App的bundleID

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
                                 @"appChannel":AppChannel,
                                 @"idfa":idfa,
                                 @"platform":platform,
                                 @"appBundleId":appBundleId
                                 };
    
    return deviceInfo;
}
 */

@end
