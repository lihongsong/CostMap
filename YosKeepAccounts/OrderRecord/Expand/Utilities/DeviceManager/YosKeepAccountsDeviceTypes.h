#import <Foundation/Foundation.h>
#define DEVICE_TYPE_NUMBER 0
@interface YosKeepAccountsDeviceTypes : NSObject
+ (NSString*)deviceEntityName;
+ (BOOL)isIPhone5SizedDevice;
+ (BOOL)isIPhone6SizedDevice;
+ (BOOL)isIPhone6PlusSizedDevice;
+ (BOOL)isIPhoneXSizedDevice;
+ (BOOL)isIPad;
+ (NSString *)getDeviceType;
@end
