//
//  LoginOut+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/16.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "LoginOut+Service.h"

@implementation LoginOut (Service)
+ (NSURLSessionDataTask *)loginOUT:(void (^)(LoginOut * _Nullable, NSError * _Nullable))completion{
    return [self ln_requestModelAPI:LN_POST_LOGIN_OUT_PATH parameters:nil completion:completion];
}

@end
