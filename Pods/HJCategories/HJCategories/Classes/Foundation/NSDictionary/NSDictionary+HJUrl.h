//
//  NSDictionary+HJUrl.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HJUrl)

/**
 将url参数转换成NSDictionary
 */
+ (NSDictionary *)hj_dictionaryWithURLQuery:(NSString *)query;

/**
 将NSDictionary转换成url 参数字符串
 */
- (NSString *)hj_URLQueryString;


@end
