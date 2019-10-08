#import "AppDelegate.h"
#import "ASUtils.h"
#import "ASBaseSpecialViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "ASHomeViewController.h"
#import "ASUtils.h"
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import "ASConfiguration.h"
#import <WebKit/WebKit.h>

#import "CostMapHomePresenter.h"
#import "CostMap-Swift.h"
#import "CostMapDeviceHelp.h"
#import "ASCustomView.h"
#import "CostMapAuthenticationPresenter.h"

static NSString * const kCostMapInstalled = @"kCostMapInstalled";

@interface AppDelegate ()
{
    BOOL _isUpdateUserInfo;
}

@property (strong, nonatomic) CostMapTabBarPresenter *rootTabBar;

@end
@implementation AppDelegate

- (void)setUpSDK {
    
    [self setupIQKeyboardManager];
    HJMediatorConfig *config = [HJMediatorConfig new];
    config.prefixString = @"CostMap";
    config.suffixString = @"Presenter";
    [[HJMediator shared] setUpConfig:config];
    [[HJMediator shared] setUpRootViewController:self.rootTabBar];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HJHexColor(0x666666),
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18]}];
}
- (void)setUpFMDB {
    if (![[CostMapSQLManager share] isTableExist:kSQLTableName]) {
        [[CostMapSQLManager share] creatNewDataBase:kSQLTableName];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _rootTabBar = [CostMapTabBarPresenter createRootViewController];
    
    BOOL isOpen = [[[NSUserDefaults standardUserDefaults] valueForKey:kCostMapInstalled] boolValue];

    [self.window makeKeyAndVisible];
    [self setUpSDK];
    [self setUpFMDB];
    [self requestConfig];
    
    if (isOpen) {
        WEAK_SELF
        CostMapAuthenticationPresenter *touchIDVC = [[CostMapAuthenticationPresenter alloc] init];
        self.window.rootViewController = touchIDVC;
        touchIDVC.rootStartVC = ^(BOOL isCheckPass){
            STRONG_SELF
            
            NSString *appVersion = [UIDevice hj_appVersion];
            NSString *temp = [[NSUserDefaults standardUserDefaults] valueForKey:appVersion];
            
            if (!StrIsEmpty(temp)) {
                [self setupLaunchViewControllerWithRemoteNotification];
                return ;
            }
            
            self.window.rootViewController = _rootTabBar;
            [ASCustomView show];
        };
    } else {
        self.window.rootViewController = _rootTabBar;
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kCostMapInstalled];
        [ASCustomView show];
    }
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    HQDKSetUserDefault([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMddHHmm"], @"TenMinutesRefresh");
}
#pragma mark - EnterForeground Event Handling
- (void)setupIQKeyboardManager {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}
#pragma mark - Private methods
- (void)setupLaunchViewControllerWithRemoteNotification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [self configApp];
    [self checkUserMergeId];
    [self getNetWorkEnvironment];
    [self setUpWithActive];
}
- (void)getNetWorkEnvironment {
    __block NSString *networkenv = @""; 
    [[HJMFNetReachability sharedManager] startMonitoring];
    [[HJMFNetReachability sharedManager] setReachabilityStatusChangeBlock:^(HJMFNetReachabilityStatus status) {
        switch (status) {
            case HJMFNetReachabilityStatusUnknown:
                networkenv = @"UNKNOWN";
                break;
            case HJMFNetReachabilityStatusNotReachable:
                networkenv = @"NONET";
                break;
            case HJMFNetReachabilityStatusReachableViaWiFi:
                networkenv = @"WiFi";
                break;
            default:
                break;
        }
        HQDKSetUserDefault(networkenv, @"networkEnvironment");
    }];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [self handleApplication:application openUrl:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [self handleApplication:application openUrl:url];
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    return [self handleApplication:application openUrl:url];
}
- (void)setUpWithActive {
    ASHomeViewController *activeVC = [[ASHomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:activeVC];
    BOOL singPrelude = NO;
    if (HJMFConfShare.preludeDelegate &&
        [HJMFConfShare.preludeDelegate respondsToSelector:@selector(hjmf_needSingPrelude)]) {
        singPrelude = [HJMFConfShare.preludeDelegate hjmf_needSingPrelude];
    }
    if (singPrelude) {
        [HJMFConfShare.preludeDelegate hjmf_singPreludeWithCompletion:^{
            [self showHome:homeNav];
        }];
        return ;
    }
    [self showHome:homeNav];
}
- (void)showHome:(UINavigationController *)nav {
    [self restoreRootViewController:nav isShowAlert:true];
    [self.window makeKeyWindow];
    [UIApplication sharedApplication].delegate.window = self.window;
}
- (void)restoreRootViewController:(UIViewController *)rootViewController isShowAlert:(BOOL)isShow{
    [UIView transitionWithView:self.window duration:0.15f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
    }];
}
- (void)checkUserMergeId {
    if ([ASUserManager hasAlreadyLoggedIn] && StrIsEmpty([ASUserManager sharedInstance].userInfo.userMergeId)) {
        [ASUserSharedManager deleteUserInfo];
    }
}
- (BOOL)handleApplication:(UIApplication *)app openUrl:(NSURL *)url {
    NSString *urlQuery = [url.query hj_urlDecode];
    NSString *jsonStr = [urlQuery stringByReplacingOccurrencesOfString:@"json=\"" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    if (StrIsEmpty(jsonStr)) {
        return YES;
    }
    @try {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:[jsonStr hj_dictionary]];
        if (!tempDic) {
            return YES;
        }
        [tempDic setValue:@(1) forKey:@"sourceType"];
        HQDKNCPost(kHQDKNotificationHandlePush, [tempDic hj_JSONString]);
    } @catch (NSException *exception) {
    }
    return YES;
}


- (void)requestConfig {
    
    NSString *appVersion = [UIDevice hj_appVersion];
    NSString *temp = [[NSUserDefaults standardUserDefaults] valueForKey:appVersion];
    
    if (!StrIsEmpty(temp)) {
        [self setupLaunchViewControllerWithRemoteNotification];
        return ;
    }
    
    [ASCustomView cache];
}

- (void)configApp {
    
    NSString *appVersion = [UIDevice hj_appVersion];
    NSString *temp = [[NSUserDefaults standardUserDefaults] valueForKey:appVersion];
    
    if (StrIsEmpty(temp)) {
        return ;
    }
    
    ASConfiguration *config = [ASConfiguration shareInstance];
    
    config.urls.service_base_url = @"";
    config.urls.web_base_url = @"";
    
    config.terminalId = @"ljjios";
    config.projectMark = @"jkd_ios";
    config.channel = @"ljj-iosymjz_fr_xq";
    config.productID = @"903";
    config.appIdentify = @"27";
    config.productLine = @"5";
    
    config.theme.mainColor = HJHexColor(0xFF6A45);
    
    NSDictionary *tempDic = [temp hj_dictionary];
    
    config.urls.login_url = tempDic[@"1"];
    config.urls.home_url = tempDic[@"2"];
}


@end
