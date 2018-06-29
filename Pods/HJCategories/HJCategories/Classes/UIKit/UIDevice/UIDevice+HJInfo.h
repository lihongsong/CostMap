//
//  UIDevice+HJInfo.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,UIDeviceType) {
    UIDeviceUnKnow = 0,
    UIDeviceIPad = 1,
    UIDeviceIPhone = 2,
    UIDeviceIPod = 3
};

@interface UIDevice (HJInfo)

/**
 获取设备当前网络IP地址
 */
+ (NSString *)hj_IPAddress:(BOOL)preferIPv4;

/**
 获取到当前的使用的网络IP地址
 */
+ (NSDictionary *)hj_IPAddress;

/**
 获取当前应用版本
 */
+(NSString *)hj_appVersion;

/**
 获取当前系统版本
 */
+(NSString *)hj_systemVersion;

/**
 手机设备信息 (没有包括渠道号。。这种和app强关联的就不放进来了 外部处理)
 */
+ (NSDictionary *)hj_deviceInfo;

/**
 获取通讯录信息
 */
+ (NSDictionary *)hj_addressBookInfo;

/**
 获取APP名字
 */
+(NSString *)hj_bundleName;

/**
 获取APP Bundle identifier
 */
+(NSString *)hj_bundleIdentifier;

/**
 获取 APP 的deviceMoel
 */
+ (NSString *)hj_deviceModel;

/**
 获取 APP 的deviceMoelName
 */
+ (NSString *)hj_deviceModelName;

/**
 获取 IDFA
 */
+ (NSString *)hj_deviceIDFA;

/**
 获取UID，取值顺序keychain -> idfa -> 随机数
 */
+ (NSString *)hj_deviceUDID;

/**
 是否是 iphone5 屏幕大小的设备
 */
+ (BOOL)hj_isIPhone5SizedDevice;

/**
 是否是 iphone6 屏幕大小的设备
 */
+ (BOOL)hj_isIPhone6SizedDevice;

/**
 是否是 iphone6p 屏幕大小的设备
 */
+ (BOOL)hj_isIPhone6PlusSizedDevice;

/**
 是否是 iphoneX 屏幕大小的设备
 */
+ (BOOL)hj_isIPhoneXSizedDevice;

/**
 是否是 ipad
 */
+ (BOOL)hj_isIPad;

/**
 判断手机是否越狱
 */
+ (BOOL)hj_isJailBreak;

/**
 设备类型
 */
+ (NSString *)hj_deviceTypeString;

/**
 设备类型
 */
+ (UIDeviceType)hj_deviceType;

/**
 是否新版本第一次安装
 */
+ (BOOL)hj_isFirstInstallInNewVersion;

@end
