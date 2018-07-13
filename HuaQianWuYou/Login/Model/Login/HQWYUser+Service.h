//
//  HQWYUser+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUser.h"

@interface HQWYUser (Service)
/**
 验证码登录

 @param code 验证码
 @param phoneNumber 手机号
 @param serialNumber 业务流水号
 @param completion <#completion description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)authenticationCodeLogin:(NSString *)code mobile:(NSString *)phoneNumber serialNumber:(NSString *)serialNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion;

#pragma mark 密码登录
/**
 密码登录
 
 @param password 密码
 @param phoneNumber 手机号
 @param completion <#completion description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)passwordLogin:(NSString *)password mobile:(NSString *)phoneNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion;

@end
