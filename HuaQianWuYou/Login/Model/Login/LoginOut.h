//
//  LoginOut.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/16.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseModel.h"

@interface LoginOut : BaseModel
+ (NSURLSessionDataTask *)signOUT:(void (^)(id _Nullable, NSError * _Nullable))completion;
@end
