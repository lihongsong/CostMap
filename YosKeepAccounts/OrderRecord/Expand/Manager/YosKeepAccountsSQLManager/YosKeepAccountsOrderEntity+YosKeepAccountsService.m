#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"
#import "YosKeepAccountsOrderTool.h"
@implementation YosKeepAccountsOrderEntity (YosKeepAccountsService)
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders sumWealth:(double * _Nullable)sumWealth {
    NSArray *orderTypes = [YosKeepAccountsOrderTool allOrderTypes];
    NSMutableArray *tempArray = [NSMutableArray array];
    __block double tempSum;
    [orderTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YosKeepAccountsOrderEntity *model = [YosKeepAccountsOrderEntity new];
        model.s_type_id = [obj stringValue];
        model.s_type_name = [YosKeepAccountsOrderTool typeNameWithIndex:[obj integerValue]];
        [tempArray addObject:model];
    }];
    [orders enumerateObjectsUsingBlock:^(YosKeepAccountsOrderEntity * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [model.s_type_id integerValue];
        if (index >= tempArray.count) {
            return ;
        }
        YosKeepAccountsOrderEntity *sumEntity = tempArray[index];
        sumEntity.s_wealth = [NSString stringWithFormat:@"%.2f", ([sumEntity.s_wealth floatValue] + [model.s_wealth floatValue])];
        tempSum += [model.s_wealth doubleValue];
    }];
    *sumWealth = tempSum;
    return tempArray;
}
+ (NSArray *)templateOrderArrayWithOrders:(NSArray *)orders {
    __unused double temp;
    return [self templateOrderArrayWithOrders:orders sumWealth:&temp];
}
@end
