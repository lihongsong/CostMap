//
//  AppDelegate.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "HQWYUtilitiesDefine.h"
#import "HQWYThirdPartKeyDefine.h"
#import "DeviceHelp.h"
#import "TouchIDViewController.h"
#import "LaunchViewController.h"
#import "AppDelegate+SDKRegister.h"
#import "ActiveViewController.h"
#import "AppDelegate+APNS.h"
#import "FBManager.h"
#import "TalkingData.h"
#import "TalkingDataAppCpa.h"
#import <Bugly/Bugly.h>
#import "HQWYLaunchManager.h"
#import "HJGuidePageWindow.h"

#import <BMKLocationKit/BMKLocationAuth.h>

@interface AppDelegate ()<BMKLocationAuthDelegate,BuglyDelegate>
@property(nonatomic,strong)MainTabBarViewController * mTabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpSDKs];

    // 百度定位 3nOIiqTdyBEQycGng1zhUzzgU6xRWNrB
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:Baidu_AppKey authDelegate:self];
    //FIXME:review 在这里weakSelf 最好放在block上面吧
    WeakObj(self);

    //FIXME:review 注册三方SDK相关的，统一放到一个方法里吧
    [self registerAppUpdate];
    //    /** 通过通知栏调起APP处理通知信息 */
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LaunchViewController *launchVC = [LaunchViewController new];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    launchVC.accomplishBlock = ^(BOOL isOpen) {
        StrongObj(self);
//        if (![exampleCreditScore isEqualToString:@"88"]) {
//            [self setupLaunchViewControllerWithRemoteNotification:remoteNotification];
//            [self checkUpdate];
//        }else{
            [self setUpViewControllerWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:launchOptions];
            [self checkUpdate];
//        }
    };

    //开始检测网络状态(主要针对IOS10以后的网络需要授权问题)
    //如果还没有网络授权,则在用户选择后再发送一些API
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //FIXME:review 这里什么意思？
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
    
    __block HJGuidePageWindow *guideWindow = [HJGuidePageWindow shareGuidePageWindow:GuidePageAPPLaunchStateNormal];
   WeakObj(self)
    HJGuidePageViewController *launchVC = [guideWindow makeHJGuidePageWindow:^(HJGuidePageViewController *make) {
        StrongObj(self)
        // 1秒 网络加载  3秒图片加载
        make.setTimer(0, 3, nil,YES);
        make.setAnimateFinishedBlock(^(id info) {
            
            self.window = oldWindow;
            [self loadActiveViewController:hNC];
            [self.window makeKeyWindow];
            
            guideWindow.hidden = YES;
            [guideWindow removeFromSuperview];
        });
        make.setCountdownBtnBlock(^(UIButton *btn) {
            //FIXME:review 此处不要写死坐标，需要优化
            btn.frame = CGRectMake(SWidth - 66 - 30, SHeight - 30 -28, 66, 28);
            
            [btn addTarget:self action:@selector(launchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        // 点击跳过，埋点
        });
    }];
    [HJGuidePageWindow show];
    HQWYLaunchManager *launchManager = [[HQWYLaunchManager alloc] init];
    launchManager.guideVC = launchVC;
    [launchManager showLanuchPageModel];
}

- (void)launchButtonClick {
    [self eventId:HQWY_StartApp_Jump_click];
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
    UserDefaultSetObj([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMddHHmm"], @"TenMinutesRefresh");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    if ([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMddHHmm"].integerValue - [GetUserDefault(@"TenMinutesRefresh") integerValue] > 10) {
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kAppWillEnterForeground" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma 三方SDK设置

- (void)setUpSDKs{
    //移动武林榜
    [RCMobClick startWithAppkey:MobClick_AppKey projectName:MobClick_ProjectName channelId:APP_ChannelId isIntegral:YES];
    /** TalkingData */
    [TalkingData sessionStarted:TalkingData_AppId withChannelId:APP_ChannelId];
    //FIXME:v2.0 这个产品确认是否需要
    [TalkingDataAppCpa init:TalkingDataAppCpa_AppId withChannelId:APP_ChannelId];

    //设置意见反馈
    [FBManager configFB];
    [self setUpBugly];
}

- (void)setUpBugly {

    /** bugly */
    BuglyConfig *buglyConfig = [[BuglyConfig alloc] init];
    buglyConfig.blockMonitorEnable = YES;
    buglyConfig.reportLogLevel = BuglyLogLevelError;
    buglyConfig.delegate = self;
#if defined(Release)
    [Bugly startWithAppId:Bugly_AppId
                   config:buglyConfig];
#else
    [Bugly startWithAppId:Bugly_AppIdDebug
        developmentDevice:YES
                   config:buglyConfig];
#endif
}

@end
