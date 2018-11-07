//
//  UILabel+LabelKit.h
//  mybuilding
//
//  Created by AsiaZhang on 15/8/4.
//  Copyright (c) 2015年 AsiaZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UILabel的分类，集成各种常用及麻烦的方法进行封装
 */
@interface UILabel (LabelKit)

/**
 *  将一个label进行自适应，设置成在一行的情况下该label最小的宽和高
 *
 *  @return 适应完之后的frame
 */
- (CGRect)autosize;

/**
 *  将一个label进行自适应，宽度固定为maxWidth，高度不限
 *
 *  @param maxWidth 最大宽度，如果填0则等价于autosize方法
 *
 *  @return 适应完之后的frame
 */
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth;

/**
 *  将label的size自适应，宽度固定为maxWidth
 *
 *  @param maxWidth 最大宽度
 *  @param maxHeight 最大高度，返回的高度不超过maxHeight，如果填0则等价于autosizeWithMaxWidth:方法
 *
 *  @return 适应完之后的frame
 */
- (CGRect)autosizeWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

//添加删除线
- (void)addStrikeThrough;//适用于不改变且不删除删除线的情况
- (void)addStrikeThroughWithTag:(NSInteger)tag;//可删除删除线
- (void)addStrikethroughWithColor:(UIColor *)color midHeight:(CGFloat)midHeight tag:(NSInteger)tag;//可删除删除线
//删除删除线
- (void)removeStrikeThroughWithTag:(NSInteger)tag;

@end
