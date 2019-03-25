//
//  UIColor+YKATheme.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "UIColor+YKATheme.h"

@implementation UIColor (YKATheme)

+ (UIColor *)yka_mainColor {
    return YosKeepAccountsThemeColor;
}

+ (UIColor *)yka_unselected {
    return HJHexColor(0x999999);
}

@end
