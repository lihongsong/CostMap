#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^CostMapLocationResult) (NSString *city);
@interface CostMapLocation : NSObject
+ (instancetype)sharedInstance;
- (void)location:(CostMapLocationResult)result;
@end
NS_ASSUME_NONNULL_END
