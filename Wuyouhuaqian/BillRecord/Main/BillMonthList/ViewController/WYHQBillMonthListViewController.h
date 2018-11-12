//
//  WYHQBillMonthListViewController.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/12.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYHQBillMonthListViewController : WYHQBaseViewController

/**
 年份
 */
@property (copy, nonatomic) NSString *year;

/**
 月份
 */
@property (copy, nonatomic) NSString *month;

/**
 类型
 */
@property (copy, nonatomic) NSString *bill_type_id;

@end

NS_ASSUME_NONNULL_END
