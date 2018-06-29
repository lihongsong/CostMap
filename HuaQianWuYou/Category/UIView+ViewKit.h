//
//  UIView+ViewKit.h
//  RKKit
//
//  Created by AsiaZhang on 15/7/29.
//  Copyright (c) 2015年 AsiaZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView的分类，集成各种常用及麻烦的方法进行封装
 */
@interface UIView (ViewKit)

/**
 *  最左的x值
 */
@property(nonatomic, readonly) CGFloat minX;

/**
 *  中间的x值
 */
@property(nonatomic, readonly) CGFloat midX;

/**
 *  最右的x值
 */
@property(nonatomic, readonly) CGFloat maxX;

/**
 *  最高的y值
 */
@property(nonatomic, readonly) CGFloat minY;

/**
 *  中间的y值
 */
@property(nonatomic, readonly) CGFloat midY;

/**
 *  最低的y值
 */
@property(nonatomic, readonly) CGFloat maxY;

/**
 *  宽度
 */
@property(nonatomic, readonly) CGFloat width;

/**
 *  高度
 */
@property(nonatomic, readonly) CGFloat height;

/**
 *  一半的宽度
 */
@property(nonatomic, readonly) CGFloat halfWidth;

/**
 *  一半的高度
 */
@property(nonatomic, readonly) CGFloat halfHeight;

/**
 *  视图内部的center
 */
@property(nonatomic, readonly) CGPoint internalCenter;

/**
 *  等价于frame.size，但是可以直接赋值
 */
@property(nonatomic, assign) CGSize size;

/**
 *  等价于frame.origin，但是可以直接赋值
 */
@property(nonatomic, assign) CGPoint origin;

/**
 *  设置heifht
 *  @return 设置完之后的view.frame
 */
- (CGRect)setHeight:(CGFloat)height;

/**
 *  设置最左的x
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX;

/**
 *  设置中间的x
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMidX:(CGFloat)midX;

/**
 *  设置最右的x
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMaxX:(CGFloat)maxX;

/**
 *  设置最高的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinY:(CGFloat)minY;

/**
 *  设置最低的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMaxY:(CGFloat)maxY;

/**
 *  设置中间的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMidY:(CGFloat)midY;

/**
 *  设置宽度
 *  @return 设置完之后的view.frame
 */
- (CGRect)setWidth:(CGFloat)width;

/**
 *  设置最左的x和最高的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX minY:(CGFloat)minY;

/**
 *  设置最左的x和中间的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX midY:(CGFloat)midY;

/**
 *  设置最左的x和最低的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX maxY:(CGFloat)maxY;

/**
 *  设置最左的x和最右的x
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX maxX:(CGFloat)maxX;

/**
 *  设置最左的x和宽度
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinX:(CGFloat)minX width:(CGFloat)width;

/**
 *  设置中间的x和最高的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMidX:(CGFloat)midX minY:(CGFloat)minY;

/**
 *  设置中间的x和最低的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMidX:(CGFloat)midX maxY:(CGFloat)maxY;

/**
 *  设置最右的x和最高的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMaxX:(CGFloat)maxX minY:(CGFloat)minY;

/**
 *  设置最右的x和中间的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMaxX:(CGFloat)maxX midY:(CGFloat)midY;

/**
 *  设置最右的x和最低的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMaxX:(CGFloat)maxX maxY:(CGFloat)maxY;

/**
 *  设置最高的y和最低的y
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinY:(CGFloat)minY maxY:(CGFloat)maxY;

/**
 *  设置最高的y和高度
 *  @return 设置完之后的view.frame
 */
- (CGRect)setMinY:(CGFloat)minY height:(CGFloat)height;

/**
 *  排列的对齐方向
 */
typedef enum {
    RKViewArrangeAlignmentLeft,
    RKViewArrangeAlignmentRight,
    RKViewArrangeAlignmentTop,
    RKViewArrangeAlignmentBottom,
    RKViewArrangeAlignmentMid //可用
} RKViewArrangeAlignment;

/**
 *  排列的方向
 */
typedef enum {
    RKViewArrangeDirectionRight, //可用
    RKViewArrangeDirectionLeft,
    RKViewArrangeDirectionBottom, //可用
    RKViewArrangeDirectionTop
} RKViewArrangeDirection;

/**
 *  水平排列所有view，distances传递他们之间的距离，第一个distance为第一个view到左边的距离
 */
+ (void)horizontalArrangeViews:(NSArray*)/*UIView*/views distances:(NSArray*)/*NSString*/distances alignmentType:(RKViewArrangeAlignment)alignment direction:(RKViewArrangeDirection)direction;

/**
 在底部加入一个bottomView，self的高度会变化
 */
- (void)addBottomView:(UIView *)bottomView;

/**
 在底部加入一个分割线，self的高度会变化
 */
- (UIView *)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height;

/**
 在底部加入一个分割线，self的高度不会变化
 */
- (UIView *)addBottomLineInViewWithColor:(UIColor *)color height:(CGFloat)height;

/**
 在顶部加入一个分割线，self的高度不会变化
 */
- (UIView *)addTopLineInViewWithColor:(UIColor *)color height:(CGFloat)height;

/**
 在顶部加入一个topView，self的高度会变化
 */
- (void)addTopView:(UIView *)topView;

/**
 在内部加入一个垂直分割线，分割线的中心在self的中心
 */
- (UIView *)addVerticalCenterLineInViewWithColor:(UIColor *)color size:(CGSize)size;

/**
 显示提示框
 */
- (void)showAlertWithContent:(NSString *)content;

/**
 *  添加边框，并在下方有阴影
 */
- (void)addBorderLineAndShadow;

@end

//向四周扩散
extern CGRect CGRectMakeLargeByRect(CGRect, UIEdgeInsets);

//向四周扩散
extern CGRect CGRectMakeLargeByPoint(CGPoint, UIEdgeInsets);

extern UIEdgeInsets UIEdgeInsetsMakeAll(CGFloat);
