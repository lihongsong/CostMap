#import "YosKeepAccountsOrderEntity.h"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsOrderEntity (YosKeepAccountsService)
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders;
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders sumWealth:(double * _Nullable)sumWealth;
@end
NS_ASSUME_NONNULL_END
