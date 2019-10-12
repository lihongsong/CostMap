//
//  ASCustomView.h
//  CostMap
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kNotificationChangeThemeColor = @"kNotificationChangeThemeColor";

@interface ASThemeManager : NSObject

+ (UIColor *)themeColor;

+ (void)changeThemeColor:(NSString *)colorStr;

+ (BOOL)isConfigTheme;

+ (void)skipChooseThemeIfNeedFromVC:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
