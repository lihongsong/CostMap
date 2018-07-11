//
//  HQWYUser+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUser.h"

@interface HQWYUser (Service)
+ (NSURLSessionDataTask *)authenticationCodeLogin:(NSString *)code mobile:(NSString *)phoneNumber serialNumber:(NSString *)serialNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion;

#pragma mark 密码登录
+ (NSURLSessionDataTask *)passwordLogin:(NSString *)password mobile:(NSString *)phoneNumber Completion:(void (^)(HQWYUser * _Nullable, NSError * _Nullable))completion;

@end
