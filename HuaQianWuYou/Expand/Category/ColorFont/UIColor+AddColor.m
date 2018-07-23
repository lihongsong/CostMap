//
//  UIColor+AddColor.m
//
//  Created by zhangyazhou on 5/3/13.
//  Copyright (c) 2013 zhangyazhou. All rights reserved.
//

#import "UIColor+AddColor.h"
#import "PlistManager.h"

@implementation UIColor (AddColor)

#pragma mark 将NSString 转为UIColor
+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) skinColor
{
    return [UIColor colorFromHexCode:[PlistManager getColor:0]];
}

+ (UIColor *) testSelectColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:1]];
}

+ (UIColor *) testNormalColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:2]];
}

+ (UIColor *) sepreateColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:3]];
}

+ (UIColor *) navigationColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:4]];
}
+ (UIColor *) bigTitleBlackColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:5]];
}
+ (UIColor *) titleBlackColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:6]];
}
+ (UIColor *) stateLittleGrayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:7]];
}
// 999999
+ (UIColor *) stateGrayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:8]];
}
+ (UIColor *) homeBGColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:9]];
}
+ (UIColor *) backgroundGrayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:10]];
}

+ (UIColor *) grayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:11]];
}

+ (UIColor *) loginGrayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:12]];
}

+ (UIColor *) buttonGrayColor{
    return [UIColor colorFromHexCode:[PlistManager getColor:13]];
}

+ (UIColor *) whiteButtonTitleColor{ // FFFFFF
    return [UIColor colorFromHexCode:[PlistManager getColor:14]];
}
@end
