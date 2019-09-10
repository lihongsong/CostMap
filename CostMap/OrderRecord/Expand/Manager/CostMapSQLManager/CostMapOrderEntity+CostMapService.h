#import "CostMapOrderEntity.h"
NS_ASSUME_NONNULL_BEGIN
@interface CostMapOrderEntity (CostMapService)
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders;
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders sumWealth:(double * _Nullable)sumWealth;
@end
NS_ASSUME_NONNULL_END
