//
//  WYHQBillModel+WYHQService.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/9.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYHQBillModel (WYHQService)

+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills;

+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills sumMoney:(double * _Nullable)sumMoney;

@end

NS_ASSUME_NONNULL_END
