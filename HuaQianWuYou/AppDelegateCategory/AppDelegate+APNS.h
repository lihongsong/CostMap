//
//  AppDelegate+APNS.h
//  HuaQianWuYou
//
//  Created by sunhw on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AppDelegate.h"
//FIXME: 因为"ThirdFrameWork(三方库) "目录有汉字和空格，导致编译失败，所以MiPushSDK文件夹暂时放在了外面，等亚洲修复后要移动到"ThirdFrameWork"目录，别忘记又该Buidle Setting里的Library Search Paths里的MiPushSDK路径; 2018.6.29_sunhw
#import "MiPushSDK.h"


@interface AppDelegate (APNS)<MiPushSDKDelegate, UNUserNotificationCenterDelegate>
//APP未启动 通知栏调起APP 处理通知信息
- (void)handleRemoteNotificationFromLaunchingWith:(NSDictionary *)userInfo;
@end
