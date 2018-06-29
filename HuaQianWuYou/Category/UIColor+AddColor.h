//
//  UIColor+AddColor.h
//
//  Created by zhangyazhou on 5/3/13.
//  Copyright (c) 2013 zhangyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AddColor)
#pragma mark 将NSString 转为UIColor
+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (UIColor *) skinColor;
+ (UIColor *) testSelectColor;
+ (UIColor *) testNormalColor;
+ (UIColor *) sepreateColor;//分割线

+ (UIColor *) navigationColor;
+ (UIColor *) bigTitleBlackColor;
+ (UIColor *) titleBlackColor;//
+ (UIColor *) stateLittleGrayColor;//
+ (UIColor *) stateGrayColor;
+ (UIColor *) homeBGColor;//
+ (UIColor *) backgroundGrayColor;//

@end
