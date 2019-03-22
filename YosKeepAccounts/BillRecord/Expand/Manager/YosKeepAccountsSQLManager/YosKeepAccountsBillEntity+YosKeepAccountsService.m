#import "YosKeepAccountsBillEntity+YosKeepAccountsService.h"
#import "YosKeepAccountsBillTool.h"
@implementation YosKeepAccountsBillEntity (YosKeepAccountsService)
+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills sumMoney:(double * _Nullable)sumMoney {
    NSArray *billTypes = [YosKeepAccountsBillTool allBillTypes];
    NSMutableArray *tempArray = [NSMutableArray array];
    __block double tempSum;
    [billTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YosKeepAccountsBillEntity *model = [YosKeepAccountsBillEntity new];
        model.s_type_id = [obj stringValue];
        model.s_type_name = [YosKeepAccountsBillTool typeNameWithIndex:[obj integerValue]];
        [tempArray addObject:model];
    }];
    [bills enumerateObjectsUsingBlock:^(YosKeepAccountsBillEntity * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [model.s_type_id integerValue];
        if (index >= tempArray.count) {
            return ;
        }
        YosKeepAccountsBillEntity *sumEntity = tempArray[index];
        sumEntity.s_money = [NSString stringWithFormat:@"%.2f", ([sumEntity.s_money floatValue] + [model.s_money floatValue])];
        tempSum += [model.s_money doubleValue];
    }];
    *sumMoney = tempSum;
    return tempArray;
}
+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills {
    __unused double temp;
    return [self templateBillArrayWithBills:bills sumMoney:&temp];
}
@end
