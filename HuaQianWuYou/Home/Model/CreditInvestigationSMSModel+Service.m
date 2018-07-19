//
//  CreditInvestigationSMSModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CreditInvestigationSMSModel+Service.h"

@implementation CreditInvestigationSMSModel (Service)
#pragma mark 获取验证码
+ (NSURLSessionDataTask *_Nullable)requestSMSCodeWithMobile:(NSString *)mobile
                                                 Completion:(nullable void (^)(id _Nullable result,
                                                                               NSError *_Nullable error))completion {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:mobile forKey:@"mobile"];
    [dict setValue:@"api" forKey:@"m"];
    [dict setValue:@"login" forKey:@"c"];
    [dict setValue:@"smsCode" forKey:@"a"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_POST
                                          parameters:dict
                                             success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
                                                 completion(nil, error);
                                             }];
    return task;
}

@end
