//
//  NSError+HQWYError.h
//  HQWYNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
//错误定义
#define HQWYSystemErrorDomain   @"HQWY.system.error.domain"
#define HQWYLogicErrorDomain    @"HQWY.logic.error.domain"
#define HQWYAPIDataErrorDomain  @"HQWY.apidata.error.domain"

#define HQWYSystemErrorMessageWrongApiDataMessage  @"数据格式错误"
#define HQWYSystemErrorMessageUnkownErrorMessage   @"网络异常，请稍后再试"
#define HQWYSystemErrorMessageNetworkIssueMessage  @"您的网络不给力，请稍后再试"

#define KHQWYNotificationTokenInvalidate                @"KHQWYNotificationTokenInvalidate"//用户token失效
#define KHQWYNotificationJiekuan_1000                   @"KHQWYNotificationJiekuan_1000"   //信用不足，无法借款
#define KHQWYNotificationForceUpdate                    @"KHQWYNotificationForceUpdate"    //强制升级弹窗
#define KHQWYNotificationImageCodeError                 @"KHQWYNotificationImageCodeError" //获取图形验证码错误

static NSString *const kHQWYTokenInvalidateCode        =   @"uc_user_007";              //用户被抢登（token失效）
static NSString *const kHQWYForceUpdateCode            =   @"SYS_ERR_FORCE_UPDATE";//强制更新
static NSString *const kHQWYAnquanxinxiCode            =   @"GW_ERR_WRONG_IMG_CODE"; //图像验证码错误
static NSString *const kHQWYjiekuanCode                =   @"jiekuan_1000"; 


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
- (NSString *)HQWY_errorMessage;

/**
 取出错误信息，不会自动弹窗

 @return 返回封装后的具体错误信息
 */
- (NSString *)HQWY_parseLogicErrorMessage;

/**
 封装 url 并返回

 @return 返回封装后的 url 字符串
 */
- (NSString *)HQWY_errorUrlString;

/**
 封装错误 code 并返回

 @return 返回封装后的 errorCode 字符串
 */
- (NSString *)HQWY_codeString;

/**
 处理系统异常，例如服务器异常
 
 @param error 原始 error
 @return 返回重新封装的 error
 */
+ (NSError *)HQWY_handleSystemError:(NSError *)error;

/**
 处理业务异常，例如登录异常
 
 @param error 原始 error
 @return 返回重新封装的 error
 */
+ (NSError *)HQWY_handleLogicError:(NSDictionary *)error code:(NSString *)code;

/**
  处理数据异常，例如数据格式错误

 @return 返回重新封装的 error
 */
+ (NSError *)HQWY_handleApiDataError;

/**
 接口异常，例如数据格式错误
 
 @return 返回重新封装的 error
 */
+ (NSError *)HQWY_handleApiNetError;

/**
 封装error信息到error对象

 @param errorDomain 描述
 @param codeString 错误码
 @param errorInfo 错误信息
 @return 返回error
 */
+ (NSError *)HQWY_errorWithDomain:(NSString *)errorDomain
                     codeString:(NSString *)codeString
                      errorInfo:(NSDictionary *)errorInfo;

@end
