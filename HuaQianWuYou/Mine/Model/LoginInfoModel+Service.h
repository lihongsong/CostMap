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
+ (NSURLSessionDataTask *_Nullable)requestLoginWithMobile:(NSString *_Nonnull)mobile
                                                  channel:(NSString *_Nullable)channel
                                                 password:(NSString *_Nullable)password
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                             NSError *_Nullable error))completion;
#pragma mark 注册
+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *_Nullable)mobile
                                                     channel:(NSString *_Nullable)channel
                                                    password:(NSString *_Nullable)password
                                                     smsCode:(NSString*_Nullable)smsCode
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                             NSError *_Nullable error))completion;

+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *_Nullable)mobile
                                                     smsCode:(NSString *_Nullable)smsCode
                                                  Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                                NSError *_Nullable error))completion;
@end
