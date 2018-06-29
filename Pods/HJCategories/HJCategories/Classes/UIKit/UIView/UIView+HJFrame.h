//
//  UIView+HJFrame.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

/**
 UIView 关于frame的分类，属性对于 Get & Set 均有效！！！
 */
@interface UIView (HJFrame)

/**
 origin 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic, assign) CGPoint hj_origin;
/**
 size 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic, assign) CGSize hj_size;
/**
 centerX 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_centerX;
/**
 centerY 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_centerY;
/**
 minY 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_x;
/**
 maxY 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_y;
/**
 width 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_width;
/**
 height 属性对于 Get & Set 均有效！！！
 */
@property (nonatomic) CGFloat hj_height;

@end
