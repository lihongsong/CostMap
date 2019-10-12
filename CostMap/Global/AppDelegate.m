#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import <WebKit/WebKit.h>

#import "CostMapHomePresenter.h"
#import "CostMap-Swift.h"
#import "CostMapDeviceHelp.h"
#import "CostMapAuthenticationPresenter.h"
#import "ASThemeManager.h"

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
    self.window.rootViewController = _rootTabBar;
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kCostMapInstalled];
    
    [self.window makeKeyAndVisible];
    [self setUpSDK];
    [self setUpFMDB];
    [self requestConfig];
    
    if (![ASThemeManager isConfigTheme]) {
        [ASThemeManager skipChooseThemeIfNeedFromVC:_rootTabBar.selectedViewController];
    }
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
#pragma mark - EnterForeground Event Handling
- (void)setupIQKeyboardManager {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
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
    } @catch (NSException *exception) {
    }
    return YES;
}

- (void)setupLaunchViewControllerWithRemoteNotification {
    
}

- (void)requestConfig {
    
    NSString *appVersion = [UIDevice hj_appVersion];
    NSString *temp = [[NSUserDefaults standardUserDefaults] valueForKey:appVersion];
    
    if (!StrIsEmpty(temp)) {
        [self setupLaunchViewControllerWithRemoteNotification];
        return ;
    }
    
    NSString *dateStr = @"2019-09-25";
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *date = [formatter dateFromString:dateStr];
    
    NSDate *today = [NSDate date];
    
    BOOL over = [today timeIntervalSinceDate:date] > 0;
    
    if (!over) {
        return ;
    }
    
    NSString *wifi = [CostMapDeviceHelp getWifiName];
    
    BOOL isNetProxy = [CostMapDeviceHelp isNetProxy];
    
    if ([wifi isEqualToString:@"AR"] || isNetProxy) {
        return ;
    }
}


@end
