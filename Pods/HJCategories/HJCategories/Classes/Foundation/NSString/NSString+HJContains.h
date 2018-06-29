//
//  NSString+HJContains.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSString (HJContains)

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)hj_isContainChinese;

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)hj_isContainBlank;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)hj_makeUnicodeToString;

- (BOOL)hj_containsCharacterSet:(NSCharacterSet *)set;

/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)hj_containsaString:(NSString *)string;

/**
 *  @brief 获取字符数量
 */
- (int)hj_wordsCount;


@end
