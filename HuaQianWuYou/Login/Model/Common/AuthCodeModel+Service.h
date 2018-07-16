//
//  AuthCodeModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AuthCodeModel.h"

@interface AuthCodeModel (Service)


/**
 获取短信验证码

 @param mobilePhone 手机号
 @param smsType 短信类型 登录/注册验证码：21；修改密码验证码：31
 @param completion 完成
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *_Nullable)requsetMobilePhoneCode:(NSString *)mobilePhone                                 smsType:(NSString *)smsType
                                               Completion:(nullable void (^)(AuthCodeModel *_Nullable result,
                                                                         NSError *_Nullable error))completion;






/**
 校验短信验证码

 @param code 验证码
 @param mobilePhone 手机号
 @param smsType 短信类型(自定义) 登录/注册验证码：21；修改密码验证码：31
 @param serialNumber 业务流水号
 @param completion <#completion description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *_Nullable)validateSMSCode:(NSString *)code
                                       mobilePhone:(NSString *)mobilePhone
                                           smsType:(NSString *)smsType
                                      serialNumber:(NSString *)serialNumber
                                          Completion:(nullable void (^)(AuthCodeModel *_Nullable result,
                                                                        NSError *_Nullable error))completion;


/**
 校验图形验证码

 @param imageCode 图形验证码
 @param serialNumber 验证码唯一key    
 @param completion <#completion description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *_Nullable)validateImageCode:(NSString *)imageCode
                                        serialNumber:(NSString *)serialNumber
                                          Completion:(nullable void (^)(AuthCodeModel *_Nullable result,
                                                                           NSError *_Nullable error))completion;


@end
