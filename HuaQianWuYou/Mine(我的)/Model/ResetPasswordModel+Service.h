//
//  ResetPasswordModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "ResetPasswordModel.h"

@interface ResetPasswordModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestUpdatePassword:(NSString *)password
                                              Completion:(nullable void (^)(ResetPasswordModel *_Nullable result,
                                                                             NSError *_Nullable error))completion;
@end
