//
//  NSString+HJSpecialRegex.h
//  HJCategories
//
//  Created by yoser on 2018/1/9.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HJCharacterSetType) {
    HJCharacterSetTypeAlphaNum_ = 0,  //ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_
    HJCharacterSetTypeAlphaNum = 1,   //ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
    HJCharacterSetTypeAlpha = 2,      //ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
    HJCharacterSetTypeNumPeriod = 3, //0123456789.
    HJCharacterSetTypeNumHeng = 4,    //0123456789-
    HJCharacterSetTypeNumxX = 5,      //0123456789xX
    HJCharacterSetTypeNum = 6,        //0123456789
};

@interface NSString (HJSpecialRegex)

/**
 *  @author Jack
 *
 *  判断输入的字符串是否是限制性输入内容
 *
 *  @param type 限制de类型
 *
 *  @return bool
 */
- (BOOL)hj_chenkCharacterWithType:(HJCharacterSetType)type;

@end
