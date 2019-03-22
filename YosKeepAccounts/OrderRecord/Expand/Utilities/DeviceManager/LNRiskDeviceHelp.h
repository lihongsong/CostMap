#import <Foundation/Foundation.h>
@interface LNRiskDeviceHelp : NSObject
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddresses;
+ (NSString *)locationStr;
+ (NSString *)readKeyBoardInputType;
+ (NSString *)currentDeviceName;
+ (BOOL)isJailBreak;
+ (NSString *)getcurrentDeviceTelephoneInformation;
+ (CGFloat)screenLight;
+ (double)getLaunchSystemTime;
+ (float)batteryLevel;
+ (NSDictionary *)getDeviceSound;
+(NSString *)appBundleId;
+(NSString *)appVersion;
+(NSString * )buildNumber;
+(NSString *)sdkVersion;
@end
