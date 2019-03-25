#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"
#import "YosKeepAccountsOrderTool.h"
@implementation YosKeepAccountsOrderEntity (YosKeepAccountsService)
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders sumWealth:(double * _Nullable)sumWealth {
    NSArray *orderTypes = [YosKeepAccountsOrderTool allOrderTypes];
    NSMutableArray *tempArray = [NSMutableArray array];
    __block double tempSum;
    [orderTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YosKeepAccountsOrderEntity *model = [YosKeepAccountsOrderEntity new];
        model.yka_type_id = [obj stringValue];
        model.yka_type_name = [YosKeepAccountsOrderTool typeNameWithIndex:[obj integerValue]];
        [tempArray addObject:model];
    }];
    [orders enumerateObjectsUsingBlock:^(YosKeepAccountsOrderEntity * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [model.yka_type_id integerValue];
        if (index >= tempArray.count) {
            return ;
        }
        YosKeepAccountsOrderEntity *sumEntity = tempArray[index];
        sumEntity.yka_wealth = [NSString stringWithFormat:@"%.2f", ([sumEntity.yka_wealth floatValue] + [model.yka_wealth floatValue])];
        tempSum += [model.yka_wealth doubleValue];
    }];
    *sumWealth = tempSum;
    return tempArray;
}
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders {
    __unused double temp;
    return [self templateOrderArrayWithOrders:orders sumWealth:&temp];
}
@end
