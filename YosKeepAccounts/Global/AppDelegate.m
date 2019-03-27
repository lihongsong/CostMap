#import "AppDelegate.h"
#import "YosKeepAccountsHomePresenter.h"
#import "YosKeepAccountsIntroducePresenter.h"
#import "YosKeepAccountsTouchIDPresenter.h"
#import "AppDelegate+YKAUserCenter.h"
#import "YosKeepAccounts-Swift.h"
@interface AppDelegate ()

@property (strong, nonatomic) YosKeepAccountsTabBarPresenter *rootTabBar;

@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _rootTabBar = [YosKeepAccountsTabBarPresenter createRootViewController];
    
    self.window.rootViewController = _rootTabBar;
    [self.window makeKeyAndVisible];
    [self setUpSDK];
    [self setUpUpdate];
    [self setUpFMDB];
    [self setupIntroduceWithRemoteNotification:launchOptions];
    return YES;
}
- (void)getNetWorkEnvironment {
    __block NSString *networkenv = @""; 
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
- (void)setUpPresenterWithHighScoreWithRemoteNotificaton:(NSDictionary *)remoteNotification launchOptions:(NSDictionary *)launchOptions {
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
            [self loadActivePresenter:self.rootTabBar];
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
- (void)restoreRootPresenter:(UIViewController *)rootPresenter {
    [UIView transitionWithView:self.window
                      duration:0.25f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.window.rootViewController = rootPresenter;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
}
#pragma mark - 渐变动画更换RootVC
- (void)loadActivePresenter:(UIViewController *)rootPresenter {
    [UIView transitionWithView:self.window
                      duration:0.25f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.window.rootViewController = rootPresenter;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
}
- (void)setRootPresenter {
    [self restoreRootPresenter:self.rootTabBar];
}
#pragma mark - 引导页设置
- (BOOL)setupIntroduceWithRemoteNotification:(NSDictionary *)remoteNotification {
    NSString *isInstallApp = UserDefaultGetObj(kHasInstallApp);
    if (!isInstallApp.integerValue) {
        YosKeepAccountsIntroducePresenter *introduceVC = [[YosKeepAccountsIntroducePresenter alloc] init];
        UserDefaultSetObj(@"1", kHasInstallApp);
        UserDefaultSetObj([NSDate date], @"firstDay");
        introduceVC.rootStartVC = ^{
            [self setRootPresenter];
        };
        self.window.rootViewController = introduceVC;
        return YES;
    } else {
        NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
        if (![userDefault boolForKey:kCachedTouchIdStatus]) {
            [self setUpPresenterWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:remoteNotification];
        } else {
            WEAK_SELF
            YosKeepAccountsTouchIDPresenter *touchIDVC = [[YosKeepAccountsTouchIDPresenter alloc]init];
            self.window.rootViewController = touchIDVC;
            touchIDVC.rootStartVC = ^(BOOL isCheckPass){
                STRONG_SELF
                self.window.rootViewController = nil;
                [self setUpPresenterWithHighScoreWithRemoteNotificaton:remoteNotification launchOptions:remoteNotification];
            };
        }
        return NO;
    }
}
- (void)setUpSDK {
    
    [self registerUserCenter];
    
    HJMediatorConfig *config = [HJMediatorConfig new];
    config.prefixString = @"YosKeepAccounts";
    config.suffixString = @"Presenter";
    [[HJMediator shared] setUpConfig:config];
    [[HJMediator shared] setUpRootViewController:self.rootTabBar];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HJHexColor(0x666666),
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18]}];
}
- (void)setUpUpdate {
    [XZYAppUpdate startWithAppKey:XZYAppUpdateProductKey
                        channelId:APP_ChannelId
                           config:nil];
#if defined (DebugNet) || defined (PreNet)
    [XZYAppUpdate setDebug:YES];
#else
    [XZYAppUpdate setDebug:NO];
#endif
    [XZYAppUpdate checkUpdateAtLaunch:nil];
}
- (void)setUpFMDB {
    if (![[YosKeepAccountsSQLManager share] isTableExist:kSQLTableName]) {
        [[YosKeepAccountsSQLManager share] creatNewDataBase:kSQLTableName];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
@end
