//
//  UIButton+HJTouch.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

#pragma mark - 默认点击时间间隔
#define defaultInterval 0.5f  //默认时间间隔

@interface UIButton (HJTouch)

/**
 *  手动初始化 UIButton (touch)
 *  注意：在app启动时，必须手动调用该方法，进行方法替换，
 才能正常使用 UIButton防止连续点击
 */
+ (void)UIButtonTouch_load;

/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval hj_timeInterval;

// 是否开启防止连续点击，默认不开启
@property (nonatomic, assign) BOOL hj_isOpenTT;

@end
