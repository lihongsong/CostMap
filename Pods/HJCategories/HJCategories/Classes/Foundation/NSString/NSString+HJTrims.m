//
//  NSString+HJTrims.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSString+HJTrims.h"

@implementation NSString (HJTrims)

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)hj_stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)hj_stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString hj_stringByStrippingHTML];
}

/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)hj_trimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)hj_trimmingWhitespaceAndNewlines{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  @brief  去掉字符串中所有的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)hj_trimmingAllSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


@end
