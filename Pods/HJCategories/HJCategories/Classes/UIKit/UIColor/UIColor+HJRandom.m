//
//  UIColor+HJRandom.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIColor+HJRandom.h"

@implementation UIColor (HJRandom)

+ (UIColor *)hj_randomColor{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

@end
