//
//  UIColor+HJHex.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

#define HJRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define HJRGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1)

#define HJHexColor(hex) [UIColor hj_colorWithHex:hex]

#define HJHexStringColor(hexString) [UIColor hj_colorWithHexString:hexString]

@interface UIColor (HJHex)

/**
 根据十六进制生成颜色

 @param hex 十六进制数 UInt32
 @return 颜色
 */
+ (UIColor *)hj_colorWithHex:(UInt32)hex;

/**
 根据十六进制生成颜色
 
 @param hex 十六进制数 UInt32
 @param alpha 透明度 0 ~ 1
 @return 颜色
 */
+ (UIColor *)hj_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 根据十六进制生成颜色
 
 @param hexString 十六进制数 string
 @return 颜色
 */
+ (UIColor *)hj_colorWithHexString:(NSString *)hexString;

/**
 转成十六进制字符串
 */
- (NSString *)hj_HexString;

@end
