//
//  NSError+HQWYError.h
//  HQWYNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+HQWYResponseCode.h"

//错误定义
#define HQWYSystemErrorDomain   @"hqwy.system.error.domain"
#define HQWYLogicErrorDomain    @"hqwy.logic.error.domain"
#define HQWYAPIDataErrorDomain  @"hqwy.apidata.error.domain"

#define HQWYSystemErrorMessageWrongApiDataMessage  @"数据格式错误"
#define HQWYSystemErrorMessageUnkownErrorMessage   @"网络异常，请稍后再试"
#define HQWYSystemErrorMessageNetworkIssueMessage  @"您的网络不给力，请稍后再试"

//错误类别
typedef enum
{
    HQWYSystemErrorWrongApiData = 1,
    HQWYSystemErrorNetworkIssue,
    HQWYSystemErrorUnknownError
} HQWYErrorStatus;

@interface NSError (HQWYError)

/**
 封装错误信息并返回
 
 @return 返回封装后的具体错误信息
 */
- (NSString *)hqwy_errorMessage;

/**
 封装错误 code 并返回

 @return 返回封装后的 errorCode 字符串
 */
- (HQWYRESPONSECODE)hqwy_respCode;

/**
 处理系统异常，例如服务器异常
 
 @param error 原始 error
 @return 返回重新封装的 error
 */
+ (NSError *)hqwy_handleSystemError:(NSError *)error;

/**
 处理业务异常，例如登录异常
 
 @param respMsg 原始 respMsg
 @param respCode 原始 respCode
 @return 返回重新封装的 error
 */
+ (NSError *)hqwy_handleLogicError:(NSString *)respMsg respCode:(NSString *)respCode;

/**
  处理数据异常，例如数据格式错误

 @return 返回重新封装的 error
 */
+ (NSError *)hqwy_handleApiDataError;

@end
