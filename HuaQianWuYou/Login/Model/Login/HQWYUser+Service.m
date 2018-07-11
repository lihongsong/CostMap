//
//  HQWYUser+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUser+Service.h"

@implementation HQWYUser (Service)

#pragma mark 验证码登录
+ (NSURLSessionDataTask *)authenticationCodeLogin:(NSString *)code mobile:(NSString *)phoneNumber serialNumber:(NSString *)serialNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion{
    
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:code forKey:@"code"];
    [params setValue:phoneNumber forKey:@"mobilePhone"];
    [params setValue:serialNumber forKey:@"serialNumber"];
    
    return [HQWYUser ln_requestModelAPI:LN_POST_LOGIN_PATH  parameters:params completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        completion(responseObject,error);
    }];
}

#pragma mark 密码登录
+ (NSURLSessionDataTask *)passwordLogin:(NSString *)password mobile:(NSString *)phoneNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion{
    
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:password forKey:@"loginPwd"];
    [params setValue:phoneNumber forKey:@"mobilePhone"];
    
    return [HQWYUser ln_requestModelAPI:LN_POST_PASSWORD_LOGIN_PATH  parameters:params completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        completion(responseObject,error);
    }];
}


@end
