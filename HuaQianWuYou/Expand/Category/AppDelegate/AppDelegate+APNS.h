//
//  AppDelegate+APNS.h
//  HuaQianWuYou
//
//  Created by sunhw on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AppDelegate.h"
#import "MiPushSDK.h"


@interface AppDelegate (APNS)<MiPushSDKDelegate, UNUserNotificationCenterDelegate>
//APP未启动 通知栏调起APP 处理通知信息
- (void)handleRemoteNotificationFromLaunchingWith:(NSDictionary *)userInfo;
@end
