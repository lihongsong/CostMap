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

+ (UIColor *) wetAsphaltColor;//灰绿
+ (UIColor *) midnightBlueColor;//蓝灰
+ (UIColor *) sunflowerColor;//亮黄
+ (UIColor *) tangerineColor;//橘黄
+ (UIColor *) carrotColor;//橘红
+ (UIColor *) pumpkinColor;//暗黄
+ (UIColor *) alizarinColor;//深红
+ (UIColor *) pomegranateColor;//深红
+ (UIColor *) cloudsColor;//白
+ (UIColor *) silverColor;//银色
+ (UIColor *) concreteColor;
+ (UIColor *) asbestosColor;
+ (UIColor *) ngaBackColor;
+ (UIColor *) ngaDarkColor;
+ (UIColor *) huiseColor;//浅灰色
+ (UIColor *) shenhuiseColor;//深灰色
+ (UIColor *) tiankonglan;//天空蓝
+ (UIColor *) hongse;//红色
+ (UIColor *) anheiColor;//暗黑
+ (UIColor *) qing;//青色

@end
