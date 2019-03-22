#import "DeviceHelp.h"
#import "DeviceTypes.h"
#import "UIDevice+LNRiksHardware.h"
#import "LNRiskDeviceHelp.h"
#import <RCMobClick/RCBaseCommon.h>
@implementation DeviceHelp
#pragma mark - 获取app是否第一次安装或者更新
+ (BOOL)isAppFirstInstall{
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
+ (NSDictionary *)collectDeviceInfo {
    NSString *screen = [NSString stringWithFormat:@"%.f*%.f", [UIScreen mainScreen].currentMode.size.width, [UIScreen mainScreen].currentMode.size.height];
    NSString *originEntity = [[UIDevice currentDevice] hardwareString];
    NSString *memory = [NSString stringWithFormat:@"%luByte", (unsigned long)[UIDevice totalMemoryBytes]]; 
    NSString *ip = [LNRiskDeviceHelp getIPAddress:YES];
    NSString *deviceNo = [RCBaseCommon getUIDString];   
    NSString *deviceToken = [RCBaseCommon getUIDString]; 
    NSString *availableCapacity = [NSString stringWithFormat:@"%lldByte", [UIDevice freeDiskSpaceBytes]]; 
    NSString *capacity = [NSString stringWithFormat:@"%lldByte", [UIDevice totalDiskSpaceBytes]]; 
    UIWebView *webScene = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webScene stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]; 
    NSString *sdk = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]; 
    NSString *macAddress = [UIDevice hj_macAddress];
    NSString *idfa = [RCBaseCommon getIdfaString]; 
    NSString *platform = [UIDevice getDeviceType]; 
    NSString *networkenv = UserDefaultGetObj(@"networkEnvironment"); 
    NSString *jailbreak = [NSString stringWithFormat:@"%d", [LNRiskDeviceHelp isJailBreak]]; 
    NSString *devicename = [LNRiskDeviceHelp currentDeviceName]; 
    NSString *operatorinfo = [LNRiskDeviceHelp getcurrentDeviceTelephoneInformation]; 
    NSString *inputtype = [LNRiskDeviceHelp readKeyBoardInputType]; 
    NSString *location = [LNRiskDeviceHelp locationStr]; 
    NSString *battery = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp batteryLevel]]; 
    NSString *cpuType = [UIDevice cpuType]; 
    NSDictionary *volume = [LNRiskDeviceHelp getDeviceSound]; 
    NSString *screenLight = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp screenLight]]; 
    NSString *launchSystemTime = [NSString stringWithFormat:@"%f", [LNRiskDeviceHelp getLaunchSystemTime]]; 
    NSLog(@"______%@",launchSystemTime);
    NSString *appVersion       = [LNRiskDeviceHelp appVersion]; 
    NSString *appBundleId      = [LNRiskDeviceHelp appBundleId]; 
    NSString *appBuildNum      = [LNRiskDeviceHelp buildNumber]; 
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
                                  @"appVersion" : LNAOPSAFESTRING(appVersion),
                                  @"appBundleId" : LNAOPSAFESTRING(appBundleId),
                                  @"appBuildNum" : LNAOPSAFESTRING(appBuildNum),
                                  @"screenLight" : LNAOPSAFESTRING(screenLight),
                                  @"launchSystemTime" : LNAOPSAFESTRING(launchSystemTime),
                                  };
    return deviceInfo;
}
@end
