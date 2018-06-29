//
//  NSString+HJMatcher.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSString (HJMatcher)

/**
 通过正则 string 匹配

 @param regex 正则
 @return 匹配数组
 */
- (NSArray *)hj_matchWithRegex:(NSString *)regex;

/**
 返回所需要位置的匹配结果

 @param regex 正则
 @param index 结果位置
 @return 匹配结果
 */
- (NSString *)hj_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;

/**
 返回匹配到的第一个结果

 @param regex 正则
 @return 匹配结果
 */
- (NSString *)hj_firstMatchedGroupWithRegex:(NSString *)regex;

/**
 返回匹配的第一个结果模型

 @param regex 正则
 @return 匹配结果
 */
- (NSTextCheckingResult *)hj_firstMatchedResultWithRegex:(NSString *)regex;

@end
