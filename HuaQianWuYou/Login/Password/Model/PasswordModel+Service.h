//
//  PasswordModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "PasswordModel.h"

@interface PasswordModel (Service)

+ (NSURLSessionDataTask *_Nullable)verifyPhoneNum:(NSString *_Nullable)accountName Completion:(nullable void (^)(PasswordModel *_Nullable result,
                                                                                          NSError *_Nullable error))completion;

@end
