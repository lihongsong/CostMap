//
//  CInvestigationModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationModel+Service.h"

@implementation CInvestigationModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestCInvestigationWithAccumulationFundAccount:(NSString *)accumulationFundAccount
                                                                accumulationFundPWD:(NSString *)accumulationFundPWD
                                                                             iDCard:(NSString *)iDCard
                                                                               name:(NSString *)name
                                                                        phoneNumber:(NSString *)phoneNumber
                                                                            smsCode:(NSString *)smsCode
                                                                    servicePassword:(NSString *)servicePassword
                                                                         Completion:(void (^)(CInvestigationModel *, NSError *))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"creditQuery" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    [dict setValue:accumulationFundAccount forKey:@"accumulationFundAccount"];
    [dict setValue:accumulationFundPWD forKey:@"accumulationFundPWD"];
    [dict setValue:smsCode forKey:@"smsCode"];
    [dict setValue:iDCard forKey:@"iDCard"];
    [dict setValue:name forKey:@"name"];
    [dict setValue:phoneNumber forKey:@"phoneNumber"];
    [dict setValue:servicePassword forKey:@"servicePassword"];
    NSURLSessionDataTask *task = [self ln_requestModelAPI:@""
                                                 method:HTTP_POST
                                             parameters:dict
                                             completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                                                 completion(responseObject,error);
                                             }];
    return task;
}
@end
