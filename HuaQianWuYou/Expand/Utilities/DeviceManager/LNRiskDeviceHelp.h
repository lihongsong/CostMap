//
//  DeviceHelp.h
//  EasyLoan
//
//  Created by liyanbo on 15/2/2.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNRiskDeviceHelp : NSObject

//获取ipv4的地址信息
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

//获取ip地址
+ (NSDictionary *)getIPAddresses;

//用户的位置信息
+ (NSString *)locationStr;

// 获取用户的输入法类型
+ (NSString *)readKeyBoardInputType;

//当前的设备名称
+ (NSString *)currentDeviceName;

// 判断手机是否越狱
+ (BOOL)isJailBreak;

// 获取设备运营商的信息
+ (NSString *)getcurrentDeviceTelephoneInformation;

// 网络环境
+ (NSString *)networkEnvironment;

//屏幕亮度 0-1
+ (CGFloat)screenLight;

// 获取系统的启动时间
+ (double)getLaunchSystemTime;

// 手机的电量0-1 如果是-1 则是没有获取到
+ (float)batteryLevel;

//获取设备的音量信息
+ (NSDictionary *)getDeviceSound;

//buildID
+(NSString *)appBundleId;

// app Version号
+(NSString *)appVersion;

// buildNumb 号
+(NSString * )buildNumber;

// SDK 的version
+(NSString *)sdkVersion;

@end
