//
//  NSString+LabelKit.h
//  mybuilding
//
//  Created by AsiaZhang on 15/8/4.
//  Copyright (c) 2015年 AsiaZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString的分类，封装了与UILabel相关的内容
 */
@interface NSString (LabelKit)

/**
 *  通过NSString计算label自适应后的结果，计算将label的size自适应，在一行的情况下该label最小的宽和高的情况
 *
 *  @param font 字体
 *
 *  @return 适应完之后的bounds
 */
- (CGRect)autosizeWithFont:(UIFont*)font;

/**
 *  通过NSString计算label自适应后的结果，计算将label的size自适应，宽度固定为maxWidth且高度不限的情况
 *
 *  @param font     字体
 *  @param maxWidth 最大宽度，如果填0则等价于autosizeWithFont:方法
 *
 *  @return 适应完之后的bounds
 */
- (CGRect)autosizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;

/**
 *  通过NSString计算label自适应后的结果，计算将label的size自适应，宽度固定为maxWidth的情况
 *
 *  @param font      字体
 *  @param maxWidth 最大宽度
 *  @param maxHeight 最大高度，返回的高度不超过maxHeight，如果填0则等价于autosizeWithFont:maxWidth:方法
 *
 *  @return 适应完之后的bounds
 */
- (CGRect)autosizeWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
@end
