//
//  AppDelegate.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "HJGuidePage.h"
#import "UtilitiesDefine.h"
#import "DebugChangeHostVC.h"
#import "ThirdPartKeyDefine.h"
#import "DeviceHelp.h"
#import "IntroduceViewController.h"
#import "TouchIDViewController.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()//<JPUSHRegisterDelegate>
@property(nonatomic,strong)MainTabBarViewController * mTabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    WeakObj(self);
    /** Window设置 */
    [self setUpWindow];
    
//    /** 通过通知栏调起APP处理通知信息 */
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//
//    /** 启动图设置 */
    [self setupLaunchViewControllerWithRemoteNotification:remoteNotification];
    
    //开始检测网络状态(主要针对IOS10以后的网络需要授权问题)
    //如果还没有网络授权,则在用户选择后再发送一些API
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [selfWeak appBasicAPISend:launchOptions WithBlock:YES];
        }
    }];
    return YES;
}


#pragma mark window 设置
-(void)setUpWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark - 启动图设置
- (void)setupLaunchViewControllerWithRemoteNotification:(NSDictionary *)remoteNotification {
//#ifdef DEBUG
//    //等设计稿
////    if ([DeviceHelp isAppFirstInstall]) {
////        IntroduceViewController *introduceVC = [[IntroduceViewController alloc]init];
////         self.window.rootViewController = introduceVC;
////    }else{
//        DebugChangeHostVC *debugVC = [[DebugChangeHostVC alloc]init];
//        self.window.rootViewController = debugVC;
//        debugVC.rootStartVC = ^{
//            MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
//            [self restoreRootViewController:rootViewController];
//        };
//  //  }
//#else
//    MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
//    self.window.rootViewController = rootViewController;
//    UIWindow *oldWindow = self.window;
//    // 不确定用不用自定义sdk
//    __block HJGuidePageWindow *guideWindow = [HJGuidePageWindow sheareGuidePageWindow:GuidePageAPPLaunchStateNormal];
//    WeakObj(self)
//    HJGuidePageViewController *launchVC = [guideWindow makeHJGuidePageWindow:^(HJGuidePageViewController *make) {
//        StrongObj(self)
//        // 1秒 网络加载  3秒图片加载
//        make.setTimer(0, 5, nil, YES);
//        make.setAnimateFinishedBlock(^(id info) {
//
//            self.window = oldWindow;
//            [self restoreRootViewController:rootViewController];
//            [self.window makeKeyWindow];
//
//            guideWindow.hidden = YES;
//            [guideWindow removeFromSuperview];
//
//        });
//        make.setCountdownBtnBlock(^(UIButton *btn) {
//            btn.frame = CGRectMake((SWidth - 66 - 30), (NavigationHeight + 10), 66, 28);
//        });
//    }];
//    self.window.rootViewController = launchVC;
//    [HJGuidePageWindow show];
//
//    //    JKLaunchManager *launchManager = [[JKLaunchManager alloc] init];
//    //    launchManager.guideVC = launchVC;
//    //    [launchManager showLanuchPageModel];
//
//#endif

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if (![userDefault boolForKey:@"kCachedTouchIdStatus"]) {
        MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
        self.window.rootViewController = rootViewController;
    } else {
        TouchIDViewController *touchIDVC = [[TouchIDViewController alloc]init];
        self.window.rootViewController = touchIDVC;
        touchIDVC.rootStartVC = ^{
            MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
            self.window.rootViewController = rootViewController;
            // [self restoreRootViewController:rootViewController];
        };
    }
    
}

#pragma mark - 渐变动画更换RootVC

- (void)restoreRootViewController:(UIViewController *)rootViewController {
    [UIView transitionWithView:self.window
                      duration:0.25f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.window.rootViewController = rootViewController;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
}

//一些基本API调用
- (void)appBasicAPISend:(NSDictionary *)launchOptions WithBlock:(BOOL)isBlock {
    static BOOL isSend = NO;
    //确保APP启动后只发送一次
    if (!isSend) {
        if (isBlock) {
            //发送过后就断开网络监控
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        }
        isSend = YES;
        
        // 启动APNs.
        //[self registerJPush:launchOptions];
        
        // TalkingData 统计SDK初始化
//        [TalkingData sessionStarted:TalkingData_AppId withChannelId:AppChannel];
//        [TalkingDataAppCpa init:TalkingDataAppCpa_AppId withChannelId:AppChannel];
        
//        //bugly注册
//        BuglyConfig *buglyConfig = [[BuglyConfig alloc]init];
//        buglyConfig.blockMonitorEnable = YES;
//
//#if defined (ReleaseNet)
//        [Bugly startWithAppId:Bugly_AppId config:buglyConfig];
//#elif defined (PreNet)
//        [Bugly startWithAppId:Bugly_AppIdDebug config:buglyConfig];
//#else
//        [Bugly startWithAppId:Bugly_AppIdDebug developmentDevice:YES config:buglyConfig];
//#endif
        
    }
}

/*
- (void)registerJPush:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Required
    // init Push
    [JPUSHService setupWithOption:launchOptions appKey:JPush_AppKey
                          channel:JPush_Channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 注册APNs成功并上报DeviceToken
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional。实现注册APNs失败接口（可选）
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
