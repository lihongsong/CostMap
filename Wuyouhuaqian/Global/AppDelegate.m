//
//  AppDelegate.m
//  HJHQWY
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "AppDelegate.h"

#import "WYHQHomeViewController.h"
#import "WYHQIntroduceViewController.h"
#import "WYHQTouchIDViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) WYHQBaseNavigationController *homeNav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    /** 通过通知栏调起APP处理通知信息 */
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WYHQHomeViewController *homeViewController = [WYHQHomeViewController instance];
    _homeNav = [[WYHQBaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    self.window.rootViewController = _homeNav;
    
    [self.window makeKeyAndVisible];
    
    [self setUpSDK];
    
    [self setUpFMDB];
    
    [self setupIntroduceWithRemoteNotification:launchOptions];
    
    return YES;
}

// 网络环境
- (void)getNetWorkEnvironment {
    //开始检测网络状态(主要针对IOS10以后的网络需要授权问题)
    //如果还没有网络授权,则在用户选择后再发送一些API
    __block NSString *networkenv = @""; // 网络环境 3G Wi-Fi
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkenv = @"UNKNOWN";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkenv = @"NONET";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkenv = @"WWAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkenv = @"WiFi";
                break;
            default:
                break;
        }
        UserDefaultSetObj(networkenv, @"networkEnvironment");
    }];
}

- (void)setUpViewControllerWithHighScoreWithRemoteNotificaton:(NSDictionary *)remoteNotification launchOptions:(NSDictionary *)launchOptions {
    
    [self getNetWorkEnvironment];
    
    UIWindow *oldWindow = self.window;
    
    __block HJGuidePageWindow *guideWindow = [HJGuidePageWindow shareGuidePageWindow:GuidePageAPPLaunchStateNormal];
    guideWindow.backgroundColor = [UIColor whiteColor];
    WEAK_SELF
    __unused HJGuidePageViewController *launchVC = [guideWindow makeHJGuidePageWindow:^(HJGuidePageViewController *make) {
        STRONG_SELF
        make.setTimer(0, 3, nil,YES);
        make.setAnimateFinishedBlock(^(id info) {
            self.window = oldWindow;
            [self loadActiveViewController:self.homeNav];
            [self.window makeKeyWindow];
            
            guideWindow.hidden = YES;
            [guideWindow removeFromSuperview];
        });
        make.setCountdownBtnBlock(^(UIButton *btn) {
            
            CGFloat h = 30;
            CGFloat w = 60;
            CGFloat x = SWidth - 15 - w;
            CGFloat y = SHeight - 15 - h;
            
            btn.frame = CGRectMake(x, y, w, h);
            [btn setTitleColor:[UIColor stateLittleGrayColor] forState:UIControlStateNormal];
            [btn.layer setCornerRadius:15];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn.titleLabel setFont:[UIFont stateLabelFont]];
            [btn.layer setBorderColor:[UIColor loginGrayColor].CGColor];
            [btn.layer setBorderWidth:1.0f];
            
        });
    }];
    
    [HJGuidePageWindow show];
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


- (void)setRootViewController {
    [self restoreRootViewController:_homeNav];
}

#pragma mark - 引导页设置
- (BOOL)setupIntroduceWithRemoteNotification:(NSDictionary *)remoteNotification {
    
    NSString *isInstallApp = UserDefaultGetObj(kHasInstallApp);
    
    // 是否安装过 APP
    if (!isInstallApp.integerValue) {
        WYHQIntroduceViewController *introduceVC = [[WYHQIntroduceViewController alloc] init];
        UserDefaultSetObj(@"1", kHasInstallApp);
        UserDefaultSetObj([NSDate date], @"firstDay");
        introduceVC.rootStartVC = ^{
            [self setRootViewController];
        };
        self.window.rootViewController = introduceVC;
        return YES;
    } else {
        
        NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
        
        if (![userDefault boolForKey:kCachedTouchIdStatus]) {
            [self setUpViewControllerWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:remoteNotification];
        } else {
            WEAK_SELF
            WYHQTouchIDViewController *touchIDVC = [[WYHQTouchIDViewController alloc]init];
            self.window.rootViewController = touchIDVC;
            touchIDVC.rootStartVC = ^(BOOL isCheckPass){
                STRONG_SELF
                [self setUpViewControllerWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:remoteNotification];
            };
        }
        
        return NO;
    }
}

- (void)setUpSDK {
    
    HJMediatorConfig *config = [HJMediatorConfig new];
    config.prefixString = @"WYHQ";
    config.suffixString = @"ViewController";
    
    [[HJMediator shared] setUpConfig:config];
    [[HJMediator shared] setUpRootViewController:_homeNav];
}

- (void)setUpFMDB {
    
    if (![[WYHQSQLManager share] isTableExist:kSQLTableName]) {
        [[WYHQSQLManager share] creatNewDataBase:kSQLTableName];
    }
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


@end
