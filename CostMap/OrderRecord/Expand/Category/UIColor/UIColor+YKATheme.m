//
//  UIColor+YKATheme.m
//  CostMap
//
//

#import "UIColor+YKATheme.h"

@implementation UIColor (YKATheme)

+ (UIColor *)yka_mainColor {
    return CostMapThemeColor;
}

+ (UIColor *)yka_unselected {
    return HJHexColor(0x999999);
}

@end
