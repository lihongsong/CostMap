//
//  WYHQBillTool.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WYHQBillTypeFoodName   @"餐饮"

#define WYHQBillTypeBuyName    @"购物"

#define WYHQBillTypeFriendName @"交友"

#define WYHQBillTypePlayName   @"游玩"

#define WYHQBillTypeHomeName   @"居家"

#define WYHQBillTypeEducaName  @"教育"

#define WYHQBillTypeMedicName  @"医疗"

#define WYHQBillTypeOtherName  @"其他"

NS_ASSUME_NONNULL_BEGIN

@interface WYHQBillTool : NSObject

+ (UIColor *)colorWithType:(WYHQBillType)billType;

+ (WYHQBillType)typeWithTypeName:(NSString *)typeName;

+ (NSString *)typeNameWithIndex:(WYHQBillType)index;

+ (NSString *)typeImage:(WYHQBillType)billType;

+ (NSString *)typePressedImage:(WYHQBillType)type;

+ (NSArray *)allBillTypes;

+ (NSArray *)allBillTypesName;

+ (NSString *)billTimeStringWithBillTime:(NSDate *)billTime;
+ (NSDate *)billTimeWithBillTimeString:(NSString *)billTime;

@end

NS_ASSUME_NONNULL_END
