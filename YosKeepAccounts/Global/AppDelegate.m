#import "AppDelegate.h"
#import "YosKeepAccountsHomePresenter.h"
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
- (BOOL)setupIntroduceWithRemoteNotification:(NSDictionary *)remoteNotification {
    
    [self setRootPresenter];
    return YES;
}
- (void)setUpSDK {
    
    HJMediatorConfig *config = [HJMediatorConfig new];
    config.prefixString = @"YosKeepAccounts";
    config.suffixString = @"Presenter";
    [[HJMediator shared] setUpConfig:config];
    [[HJMediator shared] setUpRootViewController:self.rootTabBar];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HJHexColor(0x666666),
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18]}];
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
