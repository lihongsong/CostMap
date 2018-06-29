//
//  UINavigationController+HJStackManager.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HJStackManager)


/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (UIViewController *)hj_findViewController:(NSString *)className;

/**
 *  @brief  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)hj_isOnlyContainRootViewController;

/**
 *  @brief  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)hj_rootViewController;

/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)hj_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 *  @brief 将控制器栈顶到index之间的控制器进行pop操作
 *
 *  @param index  标记层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)hj_popToViewControllerFromIndex:(NSInteger)index animated:(BOOL)animated;

/**
 *  @brief 将控制器栈底到index之后的控制器进行pop操作
 *
 *  @param index  标记层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)hj_popToViewControllerToIndex:(NSInteger)index Animated:(BOOL)animated;

#pragma mark - Loan & JKLoan相关


/**
 push某个界面的同时，插入某个界面

 @param destinationController 目的控制器（用户可见的页面）
 @param index 目的控制器在栈中的序号
 @param transitionController 过渡控制器（插入的页面）
 */
- (void)hj_pushViewController:(UIViewController *)destinationController ofIndex:(NSUInteger)index afterViewController:(UIViewController *)transitionController;

/**
 替换栈中某个位置的控制器

 @param index 栈中的序号
 @param viewController 用来替换的控制器
 */
- (void)replaceViewControllerAtIndex:(NSUInteger)index withController:(UIViewController *)viewController;


/**
 设置最后一个控制器

 @param viewController 最后一个控制器
 @param index 最后一个控制器的序号
 */
- (void)setLastViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;

@end
