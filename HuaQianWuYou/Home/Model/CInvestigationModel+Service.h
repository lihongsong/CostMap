//
//  CInvestigationModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationModel.h"

@interface CInvestigationModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestCInvestigationWithAccumulationFundAccount:(NSString *_Nullable)accumulationFundAccount
                                                                accumulationFundPWD:(NSString *_Nullable)accumulationFundPWD
                                                                             iDCard:(NSString *_Nullable)iDCard
                                                                               name:(NSString *_Nullable)name
                                                                        phoneNumber:(NSString *_Nullable)phoneNumber
                                                                            smsCode:(NSString *_Nullable)smsCode
                                                                    servicePassword:(NSString *_Nullable)servicePassword
                                                                         Completion:(void (^_Nullable)(CInvestigationModel *_Nullable, NSError *_Nullable))completion;
@end
