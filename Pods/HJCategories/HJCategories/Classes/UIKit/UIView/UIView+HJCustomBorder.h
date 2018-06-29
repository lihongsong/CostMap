//
//  UIView+HJCustomBorder.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EdgeType) {
    TopBorder = 10000,
    LeftBorder = 20000,
    BottomBorder = 30000,
    RightBorder = 40000
};

typedef NS_OPTIONS(NSUInteger, HJExcludePoint) {
    HJExcludeStartPoint = 1 << 0,
    HJExcludeEndPoint = 1 << 1,
    HJExcludeAllPoint = ~0UL
};


/**
 以添加UIView的方式，添加边框------很遗憾不能和圆角一起用,如果要使用原始的边框添加方式，请转到HJNormalBorder
 */
@interface UIView (HJCustomBorder)

/**
 添加顶边部分的 border

 @param color 颜色
 @param borderWidth 宽度
 */
- (void)hj_addTopBorderWithColor:(UIColor *)color
                           width:(CGFloat) borderWidth;

/**
 添加左边部分的 border

 @param color 颜色
 @param borderWidth 宽度
 */
- (void)hj_addLeftBorderWithColor: (UIColor *) color
                            width:(CGFloat) borderWidth;

/**
 添加底边部分的 border

 @param color 颜色
 @param borderWidth 宽度
 */
- (void)hj_addBottomBorderWithColor:(UIColor *)color
                              width:(CGFloat) borderWidth;

/**
 添加右边部分的 border

 @param color 颜色
 @param borderWidth 宽度
 */
- (void)hj_addRightBorderWithColor:(UIColor *)color
                             width:(CGFloat) borderWidth;

/**
 移除顶部 border
 */
- (void)hj_removeTopBorder;

/**
 移除左部 border
 */
- (void)hj_removeLeftBorder;

/**
 移除底部 border
 */
- (void)hj_removeBottomBorder;

/**
 移除右部 border
 */
- (void)hj_removeRightBorder;

/**
 添加顶边部分的 border
 
 @param color 颜色
 @param borderWidth 宽度
 @param point 左右缩进宽度
 @param edge 缩进方向 left / right / all
 */
- (void)hj_addTopBorderWithColor:(UIColor *)color
                           width:(CGFloat) borderWidth
                    excludePoint:(CGFloat)point
                        edgeType:(HJExcludePoint)edge;

/**
 添加左边部分的 border
 
 @param color 颜色
 @param borderWidth 宽度
 @param point 左右缩进宽度
 @param edge 缩进方向 left / right / all
 */
- (void)hj_addLeftBorderWithColor: (UIColor *) color
                            width:(CGFloat) borderWidth
                     excludePoint:(CGFloat)point
                         edgeType:(HJExcludePoint)edge;

/**
 添加底边部分的 border
 
 @param color 颜色
 @param borderWidth 宽度
 @param point 左右缩进宽度
 @param edge 缩进方向 left / right / all
 */
- (void)hj_addBottomBorderWithColor:(UIColor *)color
                              width:(CGFloat) borderWidth
                       excludePoint:(CGFloat)point
                           edgeType:(HJExcludePoint)edge;

/**
 添加右边边部分的 border
 
 @param color 颜色
 @param borderWidth 宽度
 @param point 左右缩进宽度
 @param edge 缩进方向 left / right / all
 */
- (void)hj_addRightBorderWithColor:(UIColor *)color
                             width:(CGFloat) borderWidth
                      excludePoint:(CGFloat)point
                          edgeType:(HJExcludePoint)edge;


@end
