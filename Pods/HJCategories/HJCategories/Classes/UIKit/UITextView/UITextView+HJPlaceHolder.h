//
//  UITextView+HJPlaceHolder.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UITextView (HJPlaceHolder)

/**
 给 UITextView 添加的 placeHolderView 可以用来配置样式
 */
@property (nonatomic, strong) UITextView *hj_placeHolderTextView;

/**
 通过 String 给 UITextView 添加 placeHolder

 @param placeHolder placeHolder 上显示的 string
 */
- (void)hj_addPlaceHolder:(NSString *)placeHolder;

@end
