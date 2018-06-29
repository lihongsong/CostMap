//
//  RCMobClick.h
//  RCMobClick
//  version 2.1
//  Created by tianqiwang on 15/4/27.
//  Copyright (c) 2015年 tianqiwang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RCNetworkError;

@interface RCMobClick : NSObject

/**
 *  @author 贾普民, 15-04-27 11:04:57
 *
 *  打印字符串,测试是否能执行SDK的方法使用，开发者可以自己测试着玩哦。
 *
 *  @param messageString 控制台打印的内容
 */
+ (void)showMessage:(NSString *)messageString;

/**
 *  @author 贾普民, 15-04-27 12:04:56
 *
 *  初始化移动武林榜统计模块,默认渠道ID是AppStore。
    默认不使用积分渠道推广。若使用积分渠道推广请使用方法：【+ (void)startWithAppkey:(NSString *)appKey projectName:(NSString *)name channelId:(NSString *)channelId isIntegral:(BOOL)isIntegral】
 *
 *  @param appKey       武林榜的appKey,向武林榜服务器端申请。
 *  @param name         武林榜的项目名,向武林榜服务器端申请。
 */
+ (void)startWithAppkey:(NSString *)appKey
            projectName:(NSString *)name;

/**
 *  @author 贾普民, 15-04-27 12:04:27
 *
 *  初始化移动武林榜统计模块默认渠道ID是AppStore。
 *
 *  @param appKey       武林榜的appKey,向武林榜服务器端申请。
 *  @param name       武林榜的项目名,向武林榜服务器端申请。
 *  @param channelId    渠道id,需要和服务器端一直，填写nil或者@“”时，取默认渠道，渠道ID是AppStore.
 *  @param isIntegral   是否在积分渠道结算，YES:在积分渠道推广结费，NO:不在积分渠道推广结费。
 */
+ (void)startWithAppkey:(NSString *)appKey
            projectName:(NSString *)name
              channelId:(NSString *)channelId
             isIntegral:(BOOL)isIntegral;

/**
 *  @author 贾普民, 15-04-27 12:04:13
 *
 *  自定义事件,计数的数量统计，例如点击事件。
 *  使用前需要先到移动武林榜后台添加相应的事件。
 *
 *  @param eventId 移动武林榜后台注册的事件。
 */
+ (void)event:(NSString *)eventId;

/**
 *  @author 贾普民, 15-05-22 16:05:03
 *
 *  设置是否打印sdk的log信息, 默认NO(不打印log),SDK日志前缀【50BangSDK_】
 *
 *  @param enabled enabled设置为YES,SDK 会输出log信息可供调试参考. 除非特殊需要，否则发布产品时需改回NO.
 */
+ (void)setLogEnabled:(BOOL)enabled;

/**
 发送接口请求异常统计信息
 
 @param responseError 异常信息
 */
+ (void)reportError:(RCNetworkError *)responseError;

/**
 设置头部拓展参数

 @param extend 拓展参数 <支持类型 NSString/NSNumber/NSDictionary/NSArray 所有容器内对象也必须是这几种类型>
 */
+ (void)setHeaderExtend:(id)extend;

@end
