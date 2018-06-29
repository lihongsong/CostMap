//
//  UIView+HJFind.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UIView (HJFind)

/**
 *  @brief  找到指定类名的SubView对象--递归查找只会返回第一次找到的
 *
 *  @param _class SubVie类名
 *
 *  @return view对象
 */
- (nullable UIView *)hj_subViewClass:(nonnull Class)_class;

/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param _class SuperView类名
 *
 *  @return view对象
 */
- (nullable UIView *)hj_superViewClass:(nonnull Class)_class;

/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)hj_resignFirstResponder;

/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (nullable UIView *)hj_firstResponder;

/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (nullable UIViewController *)hj_viewController;

@end
