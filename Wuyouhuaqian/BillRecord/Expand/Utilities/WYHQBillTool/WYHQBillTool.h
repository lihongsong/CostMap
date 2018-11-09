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

+ (WYHQBillType)indexWithClassify:(NSString *)classify;

+ (NSString *)classifyWithIndex:(WYHQBillType)index;

+ (NSString *)getTypeImage:(NSString *)billType;

+ (NSString *)getTypePressedImage:(NSString *)type;

+ (NSArray *)allBillTypes;

+ (NSArray *)allBillTypesName;

@end

NS_ASSUME_NONNULL_END
