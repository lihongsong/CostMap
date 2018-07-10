//
//  DeviceManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "DeviceManager.h"
#import "DeviceHelp.h"
@implementation DeviceManager

+ (void)sendDeviceinfo{
    
    NSDictionary *devInfo = [DeviceHelp collectDeviceInfo];
    [self ln_requestAPI:Device_info parameters:devInfo success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
}
@end
