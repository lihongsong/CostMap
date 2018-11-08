//
//  WYHQBillTool.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHQBillTool : NSObject

+ (UIColor *)colorWithType:(WYHQBillType)billType;

+ (WYHQBillType)indexWithClassify:(NSString *)classify;

+ (NSString *)classifyWithIndex:(WYHQBillType)index;

+ (NSString *)getTypeImage:(NSString *)billType;

+ (NSString *)getTypePressedImage:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
