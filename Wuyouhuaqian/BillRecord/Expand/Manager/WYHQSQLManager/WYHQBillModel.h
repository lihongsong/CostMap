//
//  WYHQBillModel.h
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/28.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYHQBillModel: NSObject

/// 唯一id
@property (nonatomic, copy) NSString *s_id;

/// 账单花费时间戳
@property (nonatomic, copy) NSString *s_time;

/// 类型名字，教育，医疗
@property (nonatomic, copy) NSString *s_type_name;

/// 消费金额
@property (nonatomic, copy) NSString *s_money;

/// 账单类型 id
@property (nonatomic, copy) NSString *s_type_id;

/// 备注
@property (nonatomic, copy) NSString *s_desc;

/// 年份
@property (nonatomic, copy) NSString *s_year;

/// 月份
@property (nonatomic, copy) NSString *s_month;

/// 日
@property (nonatomic, copy) NSString *s_day;

/// 城市
@property (nonatomic, retain) NSString *s_city;

- (NSString *)description;

#pragma mark 生成 typeid 用于 sTypeID
- (NSString *)getTypeID:(NSString*)type;

@end
