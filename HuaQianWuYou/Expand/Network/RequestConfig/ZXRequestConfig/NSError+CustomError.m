//
//  NSError+CustomError.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/24.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "NSError+CustomError.h"

@implementation NSError (CustomError)
static NSString *const kCLErrorCodeKey = @"code";
static NSString *const kCLErrorMessageKey = @"msg";

//封装error信息到error对象，返回error
+ (NSError *)custom_errorWithDomain:(NSString *)errorDomain
                         codeString:(NSString *)codeString
                          errorInfo:(NSDictionary *)errorInfo {
    NSError *aError = nil;

    if ([errorDomain isEqualToString:CustomErrorDomain]) {
        NSLog(@"CustomErrorDomain -- message is [%@]", errorInfo[kCLErrorMessageKey]);
        aError = [NSError errorWithDomain:CustomErrorDomain code:[codeString integerValue] userInfo:errorInfo];
    }
    return aError;
}

//封装error信息到error对象，返回error
+ (NSError *)custom_systemErrorCodeString:(NSInteger)code{
    NSError *aError = nil;
  NSDictionary *dic = @{kCLErrorMessageKey : @"网络异常~"};
        aError = [NSError errorWithDomain:SystemErrorDomain code:code userInfo:dic];
    return aError;
}


@end
