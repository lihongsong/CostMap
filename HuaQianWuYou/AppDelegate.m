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
#import "ThirdPartKeyDefine.h"
#import <RCMobClick/RCMobClick.h>
#import <UMMobClick/MobClick.h>
#import "DeviceHelp.h"
#import "TouchIDViewController.h"
#import "LaunchViewController.h"
#import "AppDelegate+SDKRegister.h"
#import "ActiveViewController.h"
#import "AppDelegate+APNS.h"

@interface AppDelegate ()
@property(nonatomic,strong)MainTabBarViewController * mTabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //移动武林榜
    [RCMobClick startWithAppkey:MobClick_AppKey projectName:MobClick_ProjectName channelId:MobClick_Channel isIntegral:YES];
    
    //友盟  老的58fec71d677baa3921000b81
    UMConfigInstance.appKey = UMen_AppKey;
    UMConfigInstance.channelId = UMen_channelId;
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:appVersion];
    [MobClick startWithConfigure:UMConfigInstance];
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];//调试用，发布需改回默认no
#endif
    
    WeakObj(self);
    [self registerAppUpdate];
    //    /** 通过通知栏调起APP处理通知信息 */
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LaunchViewController *launchVC = [LaunchViewController new];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    launchVC.accomplishBlock = ^(NSString *exampleCreditScore) {
        StrongObj(self);
        if (![exampleCreditScore isEqualToString:@"88"]) {
            [self setupLaunchViewControllerWithRemoteNotification:remoteNotification];
            [self checkUpdate];
        }else{
            
            [self setUpViewControllerWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:launchOptions];
            [self checkUpdate];
        }
    };
    
    //开始检测网络状态(主要针对IOS10以后的网络需要授权问题)
    //如果还没有网络授权,则在用户选择后再发送一些API
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //[selfWeak appBasicAPISend:launchOptions WithBlock:YES];
        }
    }];
    
    /** 注册小米推送,启动APNs */
    [MiPushSDK registerMiPush:self];
    
    /** APP未启动 通知栏调起APP 处理通知信息 */
    if (remoteNotification) {
        [self handleRemoteNotificationFromLaunchingWith:remoteNotification];
    }
    
    return YES;
}

- (void)setUpViewControllerWithHighScoreWithRemoteNotificaton:(NSDictionary *)remoteNotification launchOptions:(NSDictionary *)launchOptions {
    ActiveViewController *activeVC = [[ActiveViewController alloc]init];
    BaseNavigationController *hNC = [[BaseNavigationController alloc]initWithRootViewController:activeVC];
    UIWindow *oldWindow = self.window;
    
    __block HJGuidePageWindow *guideWindow = [HJGuidePageWindow sheareGuidePageWindow:GuidePageAPPLaunchStateNormal];
   WeakObj(self)
    HJGuidePageViewController *launchVC = [guideWindow makeHJGuidePageWindow:^(HJGuidePageViewController *make) {
        StrongObj(self)
        // 1秒 网络加载  3秒图片加载
        make.setTimer(0, 5, nil,YES);
        make.setAnimateFinishedBlock(^(id info) {
            
            self.window = oldWindow;
            [self loadActiveViewController:hNC];
            [self.window makeKeyWindow];
            
            guideWindow.hidden = YES;
            [guideWindow removeFromSuperview];
        });
        make.setCountdownBtnBlock(^(UIButton *btn) {
            btn.frame = CGRectMake(SWidth - 66 - 30, SHeight - 30 -28, 66, 28);
        });
    }];
    [HJGuidePageWindow show];
    
   BasicDataModel *model = [BasicDataModel getCacheModel:AdvertisingTypeStartPage];
    BasicDataInfo *info = model.acitveList[0];
    //launchVC.setTimer(info.showTime.integerValue,0, @"s跳过",NO);
    launchVC.setTimer(5,0, @"s跳过",NO);
    launchVC.setBackGroundImage(info.imageUrl, YES, NO, ^{
        //[HJGuidePageWindow dismiss];
    });
}

#pragma mark - 启动图设置
- (void)setupLaunchViewControllerWithRemoteNotification:(NSDictionary *)remoteNotification {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault boolForKey:@"kCachedTouchIdStatus"]) {
        MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
        [self restoreRootViewController:rootViewController];
    } else {
        TouchIDViewController *touchIDVC = [[TouchIDViewController alloc]init];
        self.window.rootViewController = touchIDVC;
        touchIDVC.rootStartVC = ^{
            MainTabBarViewController *rootViewController = [[MainTabBarViewController alloc]init];
            [self restoreRootViewController:rootViewController];
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

#pragma mark - 渐变动画更换RootVC

- (void)loadActiveViewController:(UIViewController *)rootViewController {
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

#pragma 三方SDK设置

@end
