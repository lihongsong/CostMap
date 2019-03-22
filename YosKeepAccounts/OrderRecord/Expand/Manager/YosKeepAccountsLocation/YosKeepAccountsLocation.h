#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^YosKeepAccountsLocationResult) (NSString *city);
@interface YosKeepAccountsLocation : NSObject
+ (instancetype)sharedInstance;
- (void)location:(YosKeepAccountsLocationResult)result;
@end
NS_ASSUME_NONNULL_END
