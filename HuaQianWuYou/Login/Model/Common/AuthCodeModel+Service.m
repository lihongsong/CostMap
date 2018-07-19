//
//  AuthCodeModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AuthCodeModel+Service.h"

@implementation AuthCodeModel (Service)
+ (NSString *)ln_APIServer {
    return HQWY_HOST_PATH;
}

+ (NSURLSessionDataTask *)requsetMobilePhoneCode:(NSString *)mobilePhone smsType:(NSInteger)smsType Completion:(void (^)(AuthCodeModel * _Nullable, NSError * _Nullable))completion{
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:mobilePhone forKey:@"mobilePhone"];
    [params setValue:[NSString stringWithFormat:@"%ld", (long)smsType] forKey:@"smsType"];
    return [self ln_requestModelAPI:SMS_SEND parameters:params completion:completion];
    
}


+ (NSURLSessionDataTask *)validateSMSCode:(NSString *)code mobilePhone:(NSString *)mobilePhone smsType:(NSInteger)smsType serialNumber:(NSString *)serialNumber Completion:(void (^)(AuthCodeModel * _Nullable, NSError * _Nullable))completion{
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:mobilePhone forKey:@"mobilePhone"];
    [params setValue:[NSString stringWithFormat:@"%ld", (long)smsType] forKey:@"smsType"];
    
    [params setValue:code forKey:@"code"];
    [params setValue:serialNumber forKey:@"serialNumber"];
    return [self ln_requestModelAPI:SMS_Validate parameters:params completion:completion];
    
}




+ (NSURLSessionDataTask *)validateImageCode:(NSString *)imageCode serialNumber:(NSString *)serialNumber Completion:(void (^)(AuthCodeModel * _Nullable, NSError * _Nullable))completion{
    
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:imageCode forKey:@"imageCode"];
    [params setValue:serialNumber forKey:@"serialNumber"];
    return [self ln_requestModelAPI:ValidateImageCode parameters:params completion:completion];
    
}
@end
