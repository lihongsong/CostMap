//
//  AppDelegate+APNS.m
//  HuaQianWuYou
//
//  Created by sunhw on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AppDelegate+APNS.h"

@implementation AppDelegate (APNS)

//APP未启动 通知栏调起APP 处理通知信息
- (void)handleRemoteNotificationFromLaunchingWith:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //回调MiPushSDK
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    [MiPushSDK openAppNotify:messageId];
}

//IOS10一下 APP处于后台(点击通知栏通知调起APP触发)或者处于前台(接收到通知直接触发)
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //回调MiPushSDK
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    [MiPushSDK openAppNotify:messageId];
}

// IOS10以上 APP处于前台接收到通知触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //回调MiPushSDK
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    [MiPushSDK openAppNotify:messageId];
}

// IOS10以上 APP处于后台通过点击通知栏直接触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //回调MiPushSDK
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    [MiPushSDK openAppNotify:messageId];
    completionHandler();
}

//IOS8.0之后新添加方法
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    //注册远程通知
    [application registerForRemoteNotifications];
}

//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 小米推送注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

//注册消息推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

#pragma mark MiPushSDKDelegate

- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data {
    
    [self mipushRequestSelector:selector response:data];
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data {
    [self mipushRequestSelector:selector response:data];
}

- (void)mipushRequestSelector:(NSString *)selector response:(NSDictionary *)data {
    // 可在此获取regId (用手机号作为别名推,暂不用regId)
    if ([selector isEqualToString:@"bindDeviceToken:"]) {
    }
    
    //别名绑定成功
    if ([selector isEqualToString:@"setAlias:"]) {
    }
    
    if ([selector isEqualToString:@"getAllAliasAsync"]) {
    }
    
    if ([selector isEqualToString:@"getAllTopicAsync"]) {
    }
}
@end
