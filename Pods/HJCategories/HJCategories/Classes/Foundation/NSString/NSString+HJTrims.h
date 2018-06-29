//
//  NSString+HJTrims.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSString (HJTrims)

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)hj_stringByStrippingHTML;

/**
 *  @brief  清除js脚本
 *
 *  @return 清除js后的结果
 */
- (NSString *)hj_stringByRemovingScriptsAndStrippingHTML;

/**
 *  @brief  去除空格 首尾
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)hj_trimmingWhitespace;

/**
 *  @brief  去掉字符串中所有的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)hj_trimmingAllSpace;

/**
 *  @brief  去除空字符串与空行
 *
 *  @return 去除空字符串与空行的字符串
 */
- (NSString *)hj_trimmingWhitespaceAndNewlines;

@end
