//
//  DeviceManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "DeviceManager.h"
#import "DeviceHelp.h"
#import "LoginInfoModel.h"

@implementation DeviceManager

+ (NSString *)ln_APIServer {
    return @"http://t1-static.huaqianwy.com/mem";
}

+ (void)sendDeviceinfo{
    
    NSDictionary *devInfo = [DeviceHelp collectDeviceInfo];
    
    LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:devInfo
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    [self ln_requestJsonModelAPI:Device_info
                         headers:@{@"Content-Type" : @"application/json",
                                   @"phone": userInfo.mobile ?: @""}
                        httpBody:data
                      completion:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                          
                      }];
}
@end
