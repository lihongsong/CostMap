//
//  NSString+HJTranslate.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSString (HJTranslate)

/**
 将 self 添加到 formatString 中 并且给自己添加上一个 富文本属性
 
 @param formatString formatString
 @param attributes 富文本属性
 @return 富文本
 */
- (nullable NSAttributedString *)hj_setAttributeFormatString:(nonnull NSString *)formatString
                                                  attributes:(nullable NSDictionary *)attributes;


/**
 将其中一段 subString 添加上富文本属性并返回一个富文本

 @param subString subString
 @param attributes 富文本属性
 @return 富文本
 */
- (nullable NSAttributedString *)hj_setAttributeSubString:(nonnull NSString *)subString
                                               attributes:(nullable NSDictionary *)attributes;

/**
 每隔一定距离插入特定字符串
 
 @param insertedString 插入的字符串
 @param firstLocation 第一次插入的位置
 @param distance 每次插入位置间隔
 @return 返回的字符串
 */
- (nullable NSString *)hj_stringByInsert:(nonnull NSString *)insertedString
                           firstLocation:(NSInteger)firstLocation
                                distance:(NSInteger)distance;


/**
 替换范围内的字符为 mark 字符
 
 @param mark mark 字符
 @param range 替换的范围
 @return 替换后的字符串
 */
- (nullable NSString *)hj_convertMark:(nonnull NSString *)mark
                              inRange:(NSRange)range;


@end
