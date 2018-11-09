//
//  WYHQBillModel+WYHQService.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/9.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillModel+WYHQService.h"
#import "WYHQBillTool.h"

@implementation WYHQBillModel (WYHQService)

+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills sumMoney:(double * _Nullable)sumMoney {
    
    NSArray *billTypes = [WYHQBillTool allBillTypes];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    __block double tempSum;
    
    [billTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WYHQBillModel *model = [WYHQBillModel new];
        model.s_type_id = [obj stringValue];
        model.s_type_name = [WYHQBillTool classifyWithIndex:[obj integerValue]];
        [tempArray addObject:model];
    }];
    
    [bills enumerateObjectsUsingBlock:^(WYHQBillModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [model.s_type_id integerValue];
        
        if (index >= tempArray.count) {
            return ;
        }
        
        WYHQBillModel *sumModel = tempArray[index];
        sumModel.s_money = [NSString stringWithFormat:@"%.2f", ([sumModel.s_money floatValue] + [model.s_money floatValue])];
        
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
