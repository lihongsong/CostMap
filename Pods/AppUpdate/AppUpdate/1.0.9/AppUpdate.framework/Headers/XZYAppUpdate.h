//
//  AppUpdate.h
//  AppUpdateDemo
//
//  Created by zhangnan on 15/11/2.
//  Copyright © 2015年 zhangnan. All rights reserved.
//  v2.1

#import <UIKit/UIKit.h>

#define REQUEST_TIMEOUT 60.0
#define APP_UPDATE_QUEUE_DOMAIN "com.queue.appupdate"

typedef NSString *XZYAppUpdateKey NS_EXTENSIBLE_STRING_ENUM;

static XZYAppUpdateKey const kAppUpdateInfoUrl = @"https://update.app.2345.com/ios.php";

static XZYAppUpdateKey const kAppUpdateLocalizeTable = @"AppUpdateLocalizable";

static XZYAppUpdateKey const kAppUpdateErrorDomain = @"kAppUpdateErrorDomain";

static XZYAppUpdateKey const kAppUpdateIgnoredVersionKey = @"kAppUpdateIgnoredVersionKey";

static XZYAppUpdateKey const kAppUpdateLastRemindDateKey = @"kAppUpdateLastRemindDateKey";

static const NSInteger kAppUpdateTipsAlertTag = 1000;

typedef NS_ENUM(NSUInteger, AppUpdateErrorCode) {
    AppUpdateErrorResponseDataNil = 1,
    AppUpdateErrorResponseDataNotDictionary,
    AppUpdateErrorFromServer,  //渠道暂停、或渠道不存在等问题
    AppUpdateErrorUnKnown //未知错误
};

typedef NS_ENUM(NSInteger, AppUpdatePriority)
{
    AppUpdatePriorityDefault = 2,// 服务端返回强制更新，强制更新策略 [更新]，服务端返回推荐更新，使用推荐更新策略 [更新，忽略]
    AppUpdatePriorityHigh = 1,  // 服务端返回推荐更新，使用强制更新策略 [更新]
    AppUpdatePriorityLow = 3    // 服务端返回推荐更新的情况下，使用推荐更新策略 [更新，忽略，稍后提醒]
};

@interface XZYAppUpdate : NSObject

/**
 *  配置AppKey和渠道编号
 *
 *  @param appKey 固定32位key，项目后台可查看
 *  @param cid    渠道编号，最少1位 最多30位 只能包含a-zA-Z0-9、英文下划线、英文破折线
 */
+ (void)startWithAppKey:(NSString *)appKey
              channelId:(NSString *)cid
      appUpdatePriority:(AppUpdatePriority )priority;

/**
 *  在程序启动时自动检测是否有更新
 *
 *  @param failedBlock 错误回调
 */
+ (void)checkUpdateAtLaunch:(void(^)(NSError *error))failedBlock;

/**
 *  手动检测更新，有更新就提示，没有更新也会提示
 *
 *  @param failedBlock 错误回调
 */
+ (void)checkUpdate:(void(^)(NSError *error))failedBlock;

/** 
 * 设置自由控制更新callback函数
 * 若程序需要自由控制收到更新内容后的流程可设置delegate和callback函数来完成
 * callback函数会传入一个NSDictionary参数
 *
 * @param delegate 需要自定义checkUpdate的对象.
 * @param callBackSelectorWithDictionary 当checkUpdate事件完成时此方法会被调用,同时标记app更新信息的字典被传回.
 * @param failedBlock 错误回调
 */
+ (void)checkUpdateWithDelegate:(id)delegate
                       selector:(SEL)callBackSelectorWithDictionary
                           failedBlock:(void(^)(NSError *error))failedBlock;

/**
 设置测试模式
 */
+ (void)setDebug:(BOOL)debug;


@end
