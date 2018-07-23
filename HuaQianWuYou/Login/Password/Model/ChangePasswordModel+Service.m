//
//  ChangePasswordModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ChangePasswordModel+Service.h"

@implementation ChangePasswordModel (Service)


+ (NSURLSessionDataTask *)changePasswordCode:(NSString *)code jumpType:(NSString *)jumpType passWord:(NSString *)password mobilePhone:(NSString *)mobilePhone serialNumber:(NSString *)serialNumber Completion:(void (^)(ChangePasswordModel * _Nullable, NSError * _Nullable))completion{
    
     NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:code forKey:@"code"];
    [params setValue:jumpType forKey:@"jumpType"];
    [params setValue:password forKey:@"loginPwd"];
    [params setValue:mobilePhone forKey:@"mobilePhone"];
    [params setValue:serialNumber forKey:@"serialNumber"];
    
    return [ChangePasswordModel ln_requestModelAPI:ChangePassword parameters:params completion:completion];
}
@end
