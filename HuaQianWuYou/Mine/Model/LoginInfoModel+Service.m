//
//  LoginInfoModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LoginInfoModel+Service.h"
#import<CommonCrypto/CommonDigest.h>

@implementation LoginInfoModel (Service)

+ (NSString *)ln_APIServer {
    return @"http://jieqian.2345.com/index.php?m=api&c=login&a=index";
}

+ (NSURLSessionDataTask *_Nullable)requestLoginWithMobile:(NSString *)mobile
                                                  channel:(NSString *)channel
                                                 password:(NSString *)password
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                       NSError *_Nullable error))completion {
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:mobile forKey:@"mobile"];
    [dict1 setValue:channel forKey:@"channel"];
    [dict1 setValue:[self md5:password] forKey:@"password"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_POST
                                          parameters:dict1
                                             success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
                completion(nil, error);
            }];
    return task;
}


#pragma mark 注册
+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *)mobile
                                                  channel:(NSString *)channel
                                                 password:(NSString *)password
                                                smsCode:(NSString*)smsCode
                                               Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                             NSError *_Nullable error))completion {
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:mobile forKey:@"mobile"];
    [dict1 setValue:channel forKey:@"channel"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_POST
                                          parameters:dict1
                                             success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
                                                 completion(nil, error);
                                             }];
    return task;
}


+ (NSURLSessionDataTask *_Nullable)requestRegisterWithMobile:(NSString *)mobile
                                                     smsCode:(NSString *)smsCode
                                                  Completion:(nullable void (^)(LoginInfoModel *_Nullable result,
                                                                                NSError *_Nullable error))completion{
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:mobile forKey:@"mobile"];
    [dict1 setValue:smsCode forKey:@"smsCode"];
//    [dict1 setValue:[self md5:password] forKey:@"password"];
    NSURLSessionDataTask *task = [self ln_requestModelAPI:@""
                                               parameters:dict1
                                               completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                                                   completion(responseObject,error);
                                               }];
    return task;
}



+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
