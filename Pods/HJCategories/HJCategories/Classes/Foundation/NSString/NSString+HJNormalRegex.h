//
//  NSString+HJNormalRegex.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSString (HJNormalRegex)

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)hj_isMobileNumberClassification;

/**
 *  手机号有效性
 */
- (BOOL)hj_isMobileNumber;

/**
 座机--带分机号
 */
- (BOOL)hj_isTelphoneNumber;

/**
 座机--不带分机号
 */
- (BOOL)hj_isTelphoneNumberWithoutExtension;

/**
 *  邮箱的有效性
 */
- (BOOL)hj_isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)hj_simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)hj_accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)hj_isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)hj_bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)hj_isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)hj_isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)hj_isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)hj_isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)hj_isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)hj_isValidTaxNo;

//#define REG_PASSWORD_SAME_WORDS @"(.)\\1{%d}"//同一字符

/**
 分机号
 */
- (BOOL)hj_isValidMobileExtension;

/**
 非法字符
 */
- (BOOL)hj_isUnValidWord;

/**
 区号
 */
- (BOOL)hj_isValidMobileAreaCode;

/**
 至少包含一个汉字
 */
- (BOOL)hj_isValidChineseOneMore;

/**
 纯汉字
 */
- (BOOL)hj_isValidNumber;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)hj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)hj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;


@end
