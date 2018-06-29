//
//  LoginInfoModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LoginInfoModel.h"

@interface LoginInfoModel (Service)

/**
 登录
 */
+ (NSURLSessionDataTask *_Nullable)requestLoginWithMobile:(NSString *)mobile
                                                  channel:(NSString *)channel
                                                 password:(NSString *)password
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                             NSError *_Nullable error))completion;
#pragma mark 注册
+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *)mobile
                                                  channel:(NSString *)channel
                                                 password:(NSString *)password
                                                     smsCode:(NSString*)smsCode
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                             NSError *_Nullable error))completion;

+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *)mobile
                                                     smsCode:(NSString *)smsCode
                                                  Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                                NSError *_Nullable error))completion;
@end
