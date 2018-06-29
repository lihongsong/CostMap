//
//  NSString+HJMatcher.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "NSString+HJMatcher.h"

@implementation NSString (HJMatcher)

- (NSArray *)hj_matchWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self hj_firstMatchedResultWithRegex:regex];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:[result numberOfRanges]];
    for (int i = 0 ; i < [result numberOfRanges]; i ++ ) {
        [mArray addObject:[self substringWithRange:[result rangeAtIndex:i]]];
    }
    return mArray;
}


- (NSString *)hj_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index
{
    NSTextCheckingResult *result = [self hj_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:index]];
}


- (NSString *)hj_firstMatchedGroupWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self hj_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:0]];
}


- (NSTextCheckingResult *)hj_firstMatchedResultWithRegex:(NSString *)regex
{
    NSRegularExpression *regexExpression = [NSRegularExpression regularExpressionWithPattern:regex options:(NSRegularExpressionOptions)0 error:NULL];
    NSRange range = {0, self.length};
    return [regexExpression firstMatchInString:self options:(NSMatchingOptions)0 range:range];
}


@end
