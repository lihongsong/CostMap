//
//  HQWYUser+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUser+Service.h"

@implementation HQWYUser (Service)

+ (NSString *)ln_APIServer {
    return HQWY_HOST_PATH;
}

#pragma mark 验证码登录
+ (NSURLSessionDataTask *)authenticationCodeLogin:(NSString *)code mobile:(NSString *)phoneNumber serialNumber:(NSString *)serialNumber registerType:(RegisterType)type Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion{
    
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:code forKey:@"code"];
    [params setValue:phoneNumber forKey:@"mobilePhone"];
    [params setValue:serialNumber forKey:@"serialNumber"];
    [params setValue:[NSNumber numberWithInteger:type] forKey:@"registerType"];

    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    return  [HQWYUser ln_requestJsonModelAPI:LN_POST_LOGIN_PATH
                                     headers:@{@"Content-Type" : @"application/json"}
                                    httpBody:data
                                  completion:completion];


//    return [HQWYUser ln_requestModelAPI:LN_POST_LOGIN_PATH  parameters:params completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        completion(responseObject,error);
//    }];
}

#pragma mark 密码登录
+ (NSURLSessionDataTask *)passwordLogin:(NSString *)password mobile:(NSString *)phoneNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion{
    
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:password forKey:@"loginPwd"];
    [params setValue:phoneNumber forKey:@"mobilePhone"];

    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    return  [HQWYUser ln_requestJsonModelAPI:LN_POST_PASSWORD_LOGIN_PATH
                                 headers:@{@"Content-Type" : @"application/json"}
                                httpBody:data
                              completion:completion];

//    return [HQWYUser ln_requestModelAPI:LN_POST_PASSWORD_LOGIN_PATH  parameters:params completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        completion(responseObject,error);
//    }];
}

+ (NSURLSessionDataTask *)loginOUT:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion{
    return [self ln_requestModelAPI:LN_POST_LOGIN_OUT_PATH parameters:nil completion:completion];
}

@end
