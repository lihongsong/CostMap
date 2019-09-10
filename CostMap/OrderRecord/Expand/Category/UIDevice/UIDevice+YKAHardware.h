#import <UIKit/UIKit.h>
@interface UIDevice (YKAHardware)
- (NSString *)hardwareString;
+ (NSUInteger)cpuFrequency;
+ (NSUInteger)busFrequency;
+ (NSUInteger)ramSize;
+ (NSUInteger)cpuNumber;
+ (NSString *)cpuType;
+ (BOOL)hasCamera;
+ (NSUInteger)totalMemoryBytes;
+ (NSUInteger)freeMemoryBytes;
+ (long long)freeDiskSpaceBytes;
+ (long long)totalDiskSpaceBytes;
+ (NSString *)getDeviceType;
@end
