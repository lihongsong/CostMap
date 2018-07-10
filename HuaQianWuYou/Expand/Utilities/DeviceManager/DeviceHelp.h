//
//  DeviceHelp.h
//  Easy
//
//  Created by liyanbo on 15/2/2.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceHelp : NSObject
+ (BOOL)isAppFirstInstall;

// 获取当前版本
+(NSString *)getCurrentVersionInfo;
// 获取存储的应用版本信息
+(NSString *)getStoredAppVersionInfo;
//存储应用的版本信息
+(void)storeAppVesrionInfo:(NSString *)appVesrionInfo;

//获取APP名字
+(NSString *)getCurrentBundleName;

//手机设备信息
+ (NSDictionary *)collectDeviceInfo;

@end
