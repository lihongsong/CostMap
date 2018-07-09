//
//  ChangePasswordModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ChangePasswordModel.h"

@interface ChangePasswordModel (Service)

+ (NSURLSessionDataTask *_Nullable)changePasswordCode:(NSString *)code
                                             jumpType:(NSString *)jumpType
                                             passWord:(NSString*)password
                                          mobilePhone:(NSString*)mobilePhone
                                         serialNumber:(NSString*)serialNumber
                                           Completion:(nullable void (^)(ChangePasswordModel *_Nullable result,
                                                                                                                 NSError *_Nullable error))completion;

@end
