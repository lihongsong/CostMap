//
//  NSString+HJUrl.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSString (HJUrl)

- (NSString *)hj_processedUrlWithToken:(NSString *)token;

/**
 场景
 
 @return 键值对字符串
 */
- (NSString *)hj_sceneSuffix;

/**
 对于接口请求添加场景标志
 
 @param scene 请求接口的场景标志
 @return 在原有的url后拼接scene标志
 */
- (NSString *)hj_processedUrlWithScene:(NSString *)scene;

@end
