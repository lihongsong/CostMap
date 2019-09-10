#import <Foundation/Foundation.h>
@interface CostMapDeviceHelp : NSObject

+ (BOOL)yka_isAppFirstInstall;
+(NSString *)yka_getCurrentVersionInfo;
+(NSString *)yka_getStoredyka_appVersionInfo;
+(void)yka_storeAppVesrionInfo:(NSString *)appVesrionInfo;
+(NSString *)yka_getCurrentBundleName;
+ (NSDictionary *)yka_collectDeviceInfo;


+ (NSString *)yka_getIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)yka_getIPAddresses;
+ (NSString *)yka_locationStr;
+ (NSString *)yka_readKeyBoardInputType;
+ (NSString *)yka_currentDeviceName;
+ (BOOL)yka_isJailBreak;
+ (NSString *)yka_getcurrentDeviceTelephoneInformation;
+ (CGFloat)yka_screenLight;
+ (double)yka_getLaunchSystemTime;
+ (float)yka_batteryLevel;
+ (NSDictionary *)yka_getDeviceSound;
+(NSString *)yka_appBundleId;
+(NSString *)yka_appVersion;
+(NSString * )yka_buildNumber;
+(NSString *)yka_sdkVersion;

@end
