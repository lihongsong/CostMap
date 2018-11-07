//
//  CLCustomDatePickerView.h
//  CarAsia
//
//  Created by jasonzhang on 2018/5/2.
//  Copyright © 2018年 linjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+CLAdd.h"
#import "CLCustomDatePickerBaseView.h"
// 打印错误日志
#define CLCustomErrorLog(...) NSLog(@"reason: %@", [NSString stringWithFormat:__VA_ARGS__])

/// 弹出日期类型
typedef NS_ENUM(NSInteger, CLCustomDatePickerMode) {
    // --- 以下4种是系统自带的样式 ---
    // UIDatePickerModeTime
            CLCustomDatePickerModeTime,              // HH:mm
    // UIDatePickerModeDate
            CLCustomDatePickerModeDate,              // yyyy-MM-dd
    // UIDatePickerModeDateAndTime
            CLCustomDatePickerModeDateAndTime,       // yyyy-MM-dd HH:mm
    // UIDatePickerModeCountDownTimer
            CLCustomDatePickerModeCountDownTimer,    // HH:mm
    // --- 以下7种是自定义样式 ---
    // 年月日时分
            CLCustomDatePickerModeYMDHM,      // yyyy-MM-dd HH:mm
    // 月日时分
            CLCustomDatePickerModeMDHM,       // MM-dd HH:mm
    // 年月日
            CLCustomDatePickerModeYMD,        // yyyy-MM-dd
    // 年月
            CLCustomDatePickerModeYM,         // yyyy-MM
    // 年
            CLCustomDatePickerModeY,          // yyyy
    // 月日
            CLCustomDatePickerModeMD,         // MM-dd
    // 时分
            CLCustomDatePickerModeHM          // HH:mm
};

typedef void(^CLCustomDateResultBlock)(NSString *selectValue);

typedef void(^CLCustomDateCancelBlock)(void);

@interface CLCustomDatePickerView : CLCustomDatePickerBaseView
/**
 *  1.显示时间选择器
 *
 *  @param title            标题
 *  @param type             显示类型
 *  @param defaultSelValue  默认选中的时间（值为空/值格式错误时，默认就选中现在的时间）
 *  @param resultBlock      选择结果的回调
 *
 */
+ (CLCustomDatePickerView *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CLCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                        resultBlock:(CLCustomDateResultBlock)resultBlock;

/**
 *  2.显示时间选择器（支持 设置自动选择 和 自定义主题颜色）
 *
 *  @param title            标题
 *  @param type             显示类型
 *  @param defaultSelValue  默认选中的时间（值为空/值格式错误时，默认就选中现在的时间）
 *  @param minDate          最小时间，可为空（请使用 NSDate+BRAdd 分类中和显示类型格式对应的方法创建 minDate）
 *  @param maxDate          最大时间，可为空（请使用 NSDate+BRAdd 分类中和显示类型格式对应的方法创建 maxDate）
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param themeColor       自定义主题颜色
 *  @param resultBlock      选择结果的回调
 *
 */
+ (CLCustomDatePickerView *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CLCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(CLCustomDateResultBlock)resultBlock;

/**
 *  3.显示时间选择器（支持 设置自动选择、自定义主题颜色、取消选择的回调）
 *
 *  @param title            标题
 *  @param type             显示类型
 *  @param defaultSelValue  默认选中的时间（值为空/值格式错误时，默认就选中现在的时间）
 *  @param minDate          最小时间，可为空（请使用 NSDate+BRAdd 分类中和显示类型格式对应的方法创建 minDate）
 *  @param maxDate          最大时间，可为空（请使用 NSDate+BRAdd 分类中和显示类型格式对应的方法创建 maxDate）
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param themeColor       自定义主题颜色
 *  @param resultBlock      选择结果的回调
 *  @param cancelBlock      取消选择的回调
 *
 */
+ (CLCustomDatePickerView *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(CLCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(CLCustomDateResultBlock)resultBlock
                                        cancelBlock:(CLCustomDateCancelBlock)cancelBlock;

@end
