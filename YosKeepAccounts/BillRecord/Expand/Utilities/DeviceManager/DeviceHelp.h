#import <Foundation/Foundation.h>
@interface DeviceHelp : NSObject
+ (BOOL)isAppFirstInstall;
+(NSString *)getCurrentVersionInfo;
+(NSString *)getStoredAppVersionInfo;
+(void)storeAppVesrionInfo:(NSString *)appVesrionInfo;
+(NSString *)getCurrentBundleName;
+ (NSDictionary *)collectDeviceInfo;
@end
