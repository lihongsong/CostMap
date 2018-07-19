//
//  NSError+CustomError.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/24.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
//错误定义
#define CustomErrorDomain   @"Custom.hqwy.error.domain"

@interface NSError (CustomError)
+ (NSError *)custom_errorWithDomain:(NSString *)errorDomain
                         codeString:(NSString *)codeString
                          errorInfo:(NSDictionary *)errorInfo;
@end
