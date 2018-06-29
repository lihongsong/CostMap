//
//  UIButton+HJCountDown.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

typedef NSAttributedString * (^HJWaitTitleBlock) (NSInteger timeIndex);

@interface UIButton (HJCountDown)

/**
 给按钮添加一个倒计时定时器
 
 @param timeout 倒计时总时间
 @param title 倒计时完成时的 title
 @param waitTitleBlock 倒计时中 按钮应该显示的 titleBlock 需要返回一个 NSAttributedString 可以自定义
 @param enableTitleColor 可以点击状态下的 Title 颜色
 @param disableTitleColor 不可点击状态下 Title 颜色
 @param enableBackColor 不可点击状态下的背景色
 @param disableBackColor 可点击状态下的背景色
 @param blockTime block回调的时间限制
 @param completion 到达 blockTime 时候进行回调
 */
- (void)hj_startTime:(NSInteger)timeout
               title:(NSString *)title
      waitTitleBlock:(HJWaitTitleBlock)waitTitleBlock
    enableTitleColor:(UIColor *)enableTitleColor
   disableTitleColor:(UIColor *)disableTitleColor
     enableBackColor:(UIColor *)enableBackColor
    disableBackColor:(UIColor *)disableBackColor
           blockTime:(NSInteger)blockTime
          completion:(void (^)(void))completion;

/**
 给按钮添加一个倒计时定时器

 @param timeout 倒计时时间
 */
- (void)hj_startTime:(NSInteger)timeout;

/**
 给按钮添加一个倒计时定时器

 @param timeout 倒计时时间
 @param title 倒计时过后的 title
 @param enableTitleColor 可点击状态下的 title颜色
 @param disableTitleColor 不可点击状态下的 title颜色
 */
- (void)hj_startTime:(NSInteger)timeout
               title:(NSString *)title
    enableTitleColor:(UIColor *)enableTitleColor
   disableTitleColor:(UIColor *)disableTitleColor;


@end

