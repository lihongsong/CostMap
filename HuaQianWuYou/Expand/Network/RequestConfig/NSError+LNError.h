//
//  NSError+LNError.h
//  LNNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
//错误定义
#define LNSystemErrorDomain   @"HQWY.system.error.domain"
#define LNAPIDataErrorDomain  @"HQWY.apidata.error.domain"
#define LNLogicErrorDomain    @"HQWY.logic.error.domain"

#define LNSystemErrorMessageWrongApiDataMessage  @"数据格式错误"
#define LNSystemErrorMessageUnkownErrorMessage   @"网络异常，请稍后再试"
#define LNSystemErrorMessageNetworkIssueMessage  @"您的网络不给力，请稍后再试"

#define KNotificationCommon_0001       @"KNotificationCommon_0001"//用户token失效
#define KNotificationJiekuan_1000      @"KNotificationJiekuan_1000"//信用不足，无法借款
#define KNotificationCommon_0035       @"KNotificationCommon_0035"//强制升级弹窗
#define KNotificationImageCodeError    @"KNotificationImageCodeError"//获取图形验证码错误

static NSString *const kTokenInvalidateCode = @"common_0001";
static NSString *const kForceUpdateCode     = @"common_0035";
static NSString *const kAnquanxinxiCode     = @"anquanxinxi_0034";
static NSString *const kjiekuanCode         = @"jiekuan_1000";
static NSString *const kPasswordAllreadySetupCode  =   @"check_0003";

//错误类别
typedef enum
{
    LNSystemErrorWrongApiData = 1,
    LNSystemErrorNetworkIssue,
    LNSystemErrorUnknownError
} LNErrorStatus;

@interface NSError (LNError)

/**
 封装错误信息并返回
 
 @return 返回封装后的具体错误信息
 */
- (NSString *)ln_errorMessage;

/**
 处理系统异常，例如服务器异常
 
 @param error 原始error
 @return 返回重新封装的error
 */
+ (NSError *)ln_handleSystemError:(NSError *)error;

/**
 处理业务异常，例如登录异常
 
 @param error 原始error
 @return 返回重新封装的error
 */
+ (NSError *)ln_handleLogicError:(NSDictionary *)error;

+ (NSError *)ln_handleApiDataError;

+ (NSError *)ln_errorWithDomain:(NSString *)errorDomain codeString:(NSString *)codeString message:(id)message;
@end

