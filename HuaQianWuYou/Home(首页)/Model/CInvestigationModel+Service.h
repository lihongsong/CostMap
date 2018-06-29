//
//  CInvestigationModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationModel.h"

@interface CInvestigationModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestCInvestigationWithAccumulationFundAccount:(NSString *)accumulationFundAccount
                                                                accumulationFundPWD:(NSString *)accumulationFundPWD
                                                                             iDCard:(NSString *)iDCard
                                                                               name:(NSString *)name
                                                                        phoneNumber:(NSString *)phoneNumber
                                                                            smsCode:(NSString *)smsCode
                                                                    servicePassword:(NSString *)servicePassword
                                                                         Completion:(void (^)(CInvestigationModel *, NSError *))completion;
@end
