//
//  RCBaseCommon.h
//  RCMobClick
//
//  Created by tianqiwang on 16/2/24.
//  Copyright © 2016年 2345. All rights reserved.
//  2345移动武林榜SDK
//  修改记录:
//  贾普民/2016-02-24/增加
//  类的功能描述:系统基础公用字段获取方法

#import <Foundation/Foundation.h>

@interface RCBaseCommon : NSObject

/**
 *  @author 贾普民, 16-02-24 10:02:52
 *
 *  获取UID，取值顺序keychain->idfa（mac）->随机数
 *
 *  @return UID字符串
 */
+ (NSString *)getUIDString;


/**
 *  @author 贾普民, 16-02-24 13:02:04
 *
 *  获取设备idfa标示符
 *
 *  @return idfa字符串
 */
+ (NSString *)getIdfaString;

/**
 *  @author 贾普民, 16-02-24 13:02:29
 *
 *  获取设备idfv标示符
 *
 *  @return idfv字符串
 */
+ (NSString *)getIdfvString;

/**
 *  @author 贾普民, 16-02-24 13:02:47
 *
 *  获取系统版本号
 *
 *  @return 系统版本号字符串
 */
+ (NSString *)getSystemVersionString;

/**
 *  @author 贾普民, 16-02-24 13:02:19
 *
 *  获取app的发布版本号
 *
 *  @return app的发布版本号字符串
 */
+ (NSString *)getAppReleaseVersionString;

/**
 *  @author 贾普民, 16-02-24 13:02:19
 *
 *  获取app的构建版本号
 *
 *  @return app的构建版本号字符串
 */
+ (NSString *)getAppBuildVersionString;

/**
 *  @author 贾普民, 16-02-24 14:02:33
 *
 *  获取app的bundleID：com.2345.XXX
 *
 *  @return bundleID字符串
 */
+ (NSString *)getBundleIdentifier;

/**
 *  @author 贾普民, 16-02-24 13:02:59
 *
 *  获取当前ipa包的渠道号
 *
 *  @return 渠道号字符串
 */
+ (NSString *)getChannelString;

/**
 *  @author 贾普民, 16-02-24 13:02:21
 *
 *  获取系统是否越狱
 *
 *  @return YES:越狱；NO:没有越狱
 */
+ (BOOL)getIsJailBreak;

@end
