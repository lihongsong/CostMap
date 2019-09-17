#import "ASBaseSpecialViewController.h"
#import "ASUtils.h"
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import "ASConfiguration.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "ASHomeViewController.h"
#import <HJCategories/HJFoundation.h>
#import <HJCategories/HJUIKit.h>
#pragma mark - Manager
#import "ASHomeViewController.h"
#import "ASUtils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import "ASUtils.h"
@implementation ASUser
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.mobilePhone forKey:@"mobilePhone"];
    [aCoder encodeObject:self.respDateTime forKey:@"respDateTime"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.productHidden forKey:@"productHidden"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.clear forKey:@"clear"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.userMergeId forKey:@"userMergeId"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.mobilePhone = [aDecoder decodeObjectForKey:@"mobilePhone"];
    self.respDateTime = [aDecoder decodeObjectForKey:@"respDateTime"];
    self.token = [aDecoder decodeObjectForKey:@"token"];
    self.productHidden = [aDecoder decodeObjectForKey:@"productHidden"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.clear = [aDecoder decodeObjectForKey:@"clear"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.userMergeId = [aDecoder decodeObjectForKey:@"userMergeId"];
    return self;
}
@end
#define kMobilePhoneForUserDefault @"login_mobilephone"
#define kMobilePhoneForLatestUser @"latest_login_mobilephone"
#define kLoginStatusUserDefault @"Login_Status_User_Default"
#define kLoginUserID @"Login_User_ID"
#define KUserTokenKey @"user_token"
@interface ASUserManager ()
@property (nonatomic, strong) ASUser *userInfo;
@property (nonatomic, assign) BOOL showingCreditLineAlertView;
@property (nonatomic, strong) NSURLSessionDataTask *retrieveUserDataTask;
@end
@implementation ASUserManager
@synthesize userToken = _userToken;
+ (instancetype)sharedInstance {
    static ASUserManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance readUserInfoFromSandbox]; 
    });
    return _instance;
}
- (void)readUserInfoFromSandbox {
    NSString *file = [self pathForUserInfoLocal];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    ASUser *userInfo = nil;
    NSString *userInfoString = [unarchiver decodeObjectForKey:kHQDKUserArchiverKey];
    userInfo = [ASDES3Util decryptString:userInfoString];
    [unarchiver finishDecoding];
    [self storeNeedStoredUserInfomation:userInfo];
}
- (void)setUserInfo:(ASUser *)userInfo{
    if (userInfo != nil) {
        _userInfo = userInfo;
    }else{ 
        _userInfo = [[ASUser alloc] init];
        [_userInfo setValuesForKeysWithDictionary:@{@"mobilePhone":@"", @"respDateTime":@"", @"token":@"", @"productHidden":@"N", @"userId":@""}];
    }
    NSString *infoString = [ASDES3Util encryptObject:_userInfo];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:infoString forKey:kHQDKUserArchiverKey];
    [archiver finishEncoding];
    [data writeToFile:[self pathForUserInfoLocal] atomically:YES];
}
- (NSString *)pathForUserInfoLocal{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kHQDKUserArchiverFileName];
}
+ (BOOL)hasAlreadyLoggedIn {
    NSString *token = [[self sharedInstance] userToken];
    if (!StrIsEmpty(token) && HQDKGetUserDefault(kLoginStatusUserDefault) != nil && [HQDKGetUserDefault(kLoginStatusUserDefault) isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
- (void)storeNeedStoredUserInfomation:(ASUser *)userInfo {
    self.userInfo = userInfo;
    if (userInfo && userInfo.token.length > 0) {
        [self storeUserMobilePhone:userInfo.mobilePhone];
        [self setUserToken:userInfo.token];
        HQDKSetUserDefault(@"1", kLoginStatusUserDefault)
        HQDKSetUserDefault(userInfo.clear, KUserStatus);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void)setUserToken:(NSString *)userToken {
    if (userToken) {
        _userToken = userToken;
        NSString *tokenStr = [ASDES3Util encryptObject:userToken];
        HQDKSetUserDefault(tokenStr, KUserTokenKey);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void)storeUserMobilePhone:(NSString *)mobilePhone {
    if (mobilePhone) {
        NSString *mobilePhoneStr = [ASDES3Util encryptObject:mobilePhone];
        [[NSUserDefaults standardUserDefaults] setObject:mobilePhoneStr forKey:kMobilePhoneForUserDefault];
        [[NSUserDefaults standardUserDefaults] setObject:mobilePhoneStr forKey:kMobilePhoneForLatestUser];
    }
}
- (NSString *)userToken {
    if (!_userToken) {
        NSString *userTokenStr = HQDKGetUserDefault(KUserTokenKey);
        if (userTokenStr) {
            _userToken = [ASDES3Util decryptString:userTokenStr];
        }else{
            _userToken = @"";
        }
    }
    return _userToken;
}
+ (NSString *)loginMobilePhone {
    NSString *mobilStr = [[NSUserDefaults standardUserDefaults] objectForKey:kMobilePhoneForUserDefault];
    if (mobilStr) {
        return [ASDES3Util decryptString:mobilStr];
    }
    return @"";
}
+ (NSString *)lastLoginMobilePhone{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:kMobilePhoneForLatestUser];
    if (phoneStr) {
        return [ASDES3Util decryptString:phoneStr];
    }
    return @"";
}
- (void)deleteUserInfo {
    self.userInfo = nil;
    _userToken = nil;
    HQDKRemoveUserDefault(KUserTokenKey);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMobilePhoneForUserDefault];
    HQDKSetUserDefault(@"0", kLoginStatusUserDefault)
    HQDKSetUserDefault(@"0", KUserStatus);
    [[NSUserDefaults standardUserDefaults] synchronize];
    HQDKNCPost(kHQDKNotificationDeleteUserInfo, nil);
}
+ (NSString *)getUserStatus {
    return HQDKGetUserDefault(KUserStatus);
}
@end
@interface ASActionHandler()
@end
@implementation ASActionHandler
+ (instancetype)defauleHandle {
    static ASActionHandler *_defaultHandle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultHandle = [[ASActionHandler alloc] init];
    });
    return _defaultHandle;
}
+ (void)skipToThirdWebViewMustLogin:(NSDictionary *)dic
                                url:(NSString *)url
                           specialW:(NSString *)specialW
                            hideNav:(BOOL)hideNav
                             fromVc:(UINavigationController *)nav {
    [self skipToThirdWebViewMustLogin:dic url:url specialW:specialW fromVc:nav gotoThirdPart:!hideNav];
}
+ (void)skipToThirdWebViewIgnoreLogin:(NSDictionary *)dic
                                  url:(NSString *)url
                              hideNav:(BOOL)hideNav
                               fromVc:(UINavigationController *)nav {
    [self skipToThirdWebViewIgnoreLogin:dic url:url fromVc:nav gotoThirdPart:!hideNav];
}
+ (void)skipToThirdWebViewIgnoreLogin:(NSDictionary *)dic
                                  url:(NSString *)url
                               fromVc:(UINavigationController *)nav
                        gotoThirdPart:(BOOL)gotoThirdPart {
    ASHomeViewController *webView = [ASHomeViewController createWithBusinessType:ASBusinessTypeThird];
    webView.navigationDic = dic;
    webView.gotoThirdPart = gotoThirdPart;
    [webView loadURLString:SafeStr(url)];
    [self jumpControllerAction:webView fromVc:nav];
}
+ (void)skipToThirdWebViewMustLogin:(NSDictionary *)dic
                                url:(NSString *)url
                           specialW:(NSString *)specialW
                             fromVc:(UINavigationController *)nav
                      gotoThirdPart:(BOOL)gotoThirdPart {
    [self checkLoginWithLoginComplete:^{
        [self skipToThirdWebViewIgnoreLogin:dic
                                        url:url
                                     fromVc:nav
                              gotoThirdPart:gotoThirdPart];
    }
                             specialW:specialW
                               fromVc:nav];
}
+ (ASHomeViewController *)webViewWithDictionary:(NSDictionary *)urlDic url:(NSString *)url {
    ASHomeViewController *webView = [ASHomeViewController createWithBusinessType:ASBusinessTypeThird];
    webView.navigationDic = urlDic;
    [webView loadURLString:SafeStr(url)];
    return webView;
}
# pragma mark
+ (void)jumpControllerAction:(UIViewController *)vc fromVc:(UINavigationController *)nav {
    [nav pushViewController:vc animated:YES];
}
+ (NSString *)URLQueryString:(NSDictionary *)param {
    __block NSMutableString *tempString = [NSMutableString string];
    [param enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull _key, NSString * _Nonnull _obj, BOOL * _Nonnull stop) {
        NSString *temp = [NSString stringWithFormat:@"%@=%@&",_key, _obj];
        [tempString appendString:temp];
    }];
    [tempString deleteCharactersInRange:NSMakeRange(tempString.length - 1, 1)];
    CFStringRef cf_query = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                   (CFStringRef)tempString,
                                                                   NULL,
                                                                   (CFStringRef)CFSTR("!*'();:@+$,/?%#[]"),
                                                                   kCFStringEncodingUTF8);
    NSString *queryString = (__bridge NSString *)cf_query;
    return [queryString mutableCopy];
}
+ (void)checkLoginWithLoginComplete:(void (^)(void))loginComplete
                           specialW:(NSString *)specialW
                             fromVc:(UINavigationController *)nav {
    if ([ASUserManager hasAlreadyLoggedIn]) {
        !loginComplete?:loginComplete();
        return;
    }
    ASHomeViewController *loginVc =[ASHomeViewController createWithBusinessType:ASBusinessTypeLogin];
    loginVc.loginBlock = ^{
        !loginComplete?:loginComplete();
    };
    loginVc.specialW = specialW;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [nav pushViewController:loginVc animated:YES];
    });
}
@end
NSString *const HJMFNetworkingReachabilityDidChangeNotification = @"com.HJMF.networking.reachability.change";
NSString *const HJMFNetworkingReachabilityNotificationStatusItem = @"HJMFNetworkingReachabilityNotificationStatusItem";
typedef void (^HJMFNetworkReachabilityStatusBlock)(HJMFNetReachabilityStatus status);
NSString *HJMFStringFromNetworkReachabilityStatus(HJMFNetReachabilityStatus status) {
    switch (status) {
        case HJMFNetReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
        case HJMFNetReachabilityStatusReachableVia2G:
            return @"2G";
        case HJMFNetReachabilityStatusReachableVia3G:
            return @"3G";
        case HJMFNetReachabilityStatusReachableVia4G:
            return @"4G";
        case HJMFNetReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"WiFi", @"AFNetworking", nil);
        case HJMFNetReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknown", @"AFNetworking", nil);
    }
}
static HJMFNetReachabilityStatus HJMFNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    HJMFNetReachabilityStatus status = HJMFNetReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = HJMFNetReachabilityStatusNotReachable;
    }
#if TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        {
            NSArray *typeStrings2G = @[ CTRadioAccessTechnologyEdge,
                                        CTRadioAccessTechnologyGPRS,
                                        CTRadioAccessTechnologyCDMA1x ];
            NSArray *typeStrings3G = @[ CTRadioAccessTechnologyHSDPA,
                                        CTRadioAccessTechnologyWCDMA,
                                        CTRadioAccessTechnologyHSUPA,
                                        CTRadioAccessTechnologyCDMAEVDORev0,
                                        CTRadioAccessTechnologyCDMAEVDORevA,
                                        CTRadioAccessTechnologyCDMAEVDORevB,
                                        CTRadioAccessTechnologyeHRPD ];
            NSArray *typeStrings4G = @[ CTRadioAccessTechnologyLTE ];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CTTelephonyNetworkInfo *teleInfo = [[CTTelephonyNetworkInfo alloc] init];
                NSString *accessString = teleInfo.currentRadioAccessTechnology;
                if ([typeStrings4G containsObject:accessString]) {
                    status = HJMFNetReachabilityStatusReachableVia4G;
                } else if ([typeStrings3G containsObject:accessString]) {
                    status = HJMFNetReachabilityStatusReachableVia3G;
                } else if ([typeStrings2G containsObject:accessString]) {
                    status = HJMFNetReachabilityStatusReachableVia2G;
                } else {
                    return HJMFNetReachabilityStatusUnknown;
                }
            } else {
                return HJMFNetReachabilityStatusUnknown;
            }
        }
    }
#endif
    else {
        status = HJMFNetReachabilityStatusReachableViaWiFi;
    }
    return status;
}
static void HJMFPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, HJMFNetworkReachabilityStatusBlock block) {
    HJMFNetReachabilityStatus status = HJMFNetworkReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ HJMFNetworkingReachabilityNotificationStatusItem : @(status) };
        [notificationCenter postNotificationName:HJMFNetworkingReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}
static void HJMFNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    HJMFPostReachabilityStatusChange(flags, (__bridge HJMFNetworkReachabilityStatusBlock)info);
}
static const void *HJMFNetworkReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}
static void HJMFNetworkReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}
@interface HJMFNetReachability ()
@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) HJMFNetReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) HJMFNetworkReachabilityStatusBlock networkReachabilityStatusBlock;
@end
@implementation HJMFNetReachability
+ (instancetype)sharedManager {
    static HJMFNetReachability *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    return _sharedManager;
}
+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    HJMFNetReachability *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    HJMFNetReachability *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
+ (instancetype)manager {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = HJMFNetReachabilityStatusUnknown;
    return self;
}
- (instancetype)init NS_UNAVAILABLE {
    return nil;
}
- (void)dealloc {
    [self stopMonitoring];
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}
#pragma mark -
- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}
- (BOOL)isReachableViaWWAN {
    return (self.networkReachabilityStatus == HJMFNetReachabilityStatusReachableVia4G) || (self.networkReachabilityStatus == HJMFNetReachabilityStatusReachableVia3G) || self.networkReachabilityStatus == HJMFNetReachabilityStatusReachableVia2G;
}
- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == HJMFNetReachabilityStatusReachableViaWiFi;
}
#pragma mark -
- (void)startMonitoring {
    [self stopMonitoring];
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf startNotifier];
    });
}
- (void)startNotifier {
    if (!self.networkReachability) {
        return;
    }
    __weak __typeof(self) weakSelf = self;
    HJMFNetworkReachabilityStatusBlock callback = ^(HJMFNetReachabilityStatus status) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, HJMFNetworkReachabilityRetainCallback, HJMFNetworkReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, HJMFNetworkReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
        HJMFPostReachabilityStatusChange(flags, callback);
    }
}
- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        SCNetworkReachabilityUnscheduleFromRunLoop(strongSelf.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    });
}
#pragma mark -
- (NSString *)localizedNetworkReachabilityStatusString {
    return HJMFStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}
#pragma mark -
- (void)setReachabilityStatusChangeBlock:(void (^)(HJMFNetReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}
#pragma mark - NSKeyValueObserving
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}
@end
@implementation ASInternalStorageManager
+ (instancetype)sharedInstance{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
@interface ASPageConfigHandler()
@property (strong, nonatomic) NSArray *autoRefreshRouter;
@property (assign, nonatomic) BOOL sleepLimit;
@end
@implementation ASPageConfigHandler
- (instancetype)init {
    if (self = [super init]) {
        self.sleepLimit = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}
- (NSString *)handlerName {
    return kAppPageConfig;
}
- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    if (![message isKindOfClass:[NSString class]]) {
        NSString *tempStr = [[ASGTMBase64 decodeString:@"5Y+C5pWw5qC85byP6Kej5p6Q6ZSZ6K+v"] hj_UTF8String];
        !hander?:hander([ASJavaScriptResponse failMsg:tempStr]);
        return ;
    }
    NSDictionary *dic = [(NSString *)message hj_dictionary];
    self.autoRefreshRouter = dic[@"autoRefreshRouter"];
    !hander?:hander([ASJavaScriptResponse success]);
}
- (void)applicationDidBecomeActive {
    if (!self.sleepLimit) {
        return ;
    }
    self.sleepLimit = NO;
    long long time = [HQDKGetUserDefault(@"TenMinutesRefresh") longLongValue];
    if ([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMddHHmm"].longLongValue - time > 10) {
        NSDictionary *dic = @{@"TenMinutesRefresh": @"1"};
        [[NSNotificationCenter defaultCenter] postNotificationName:kHQDKNotificationAppWillEnterForeground
                                                            object:nil
                                                          userInfo:dic];
    }
}
- (void)applicationDidEnterBackground {
    WEAK_SELF
    [self currentRouterNeedAutoRefresh:^(BOOL autoRefresh) {
        STRONG_SELF
        if (!autoRefresh) {
            return ;
        }
        self.sleepLimit = YES;
        HQDKSetUserDefault([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMddHHmm"], @"TenMinutesRefresh");
    }];
}
- (void)currentRouterNeedAutoRefresh:(void(^)(BOOL autoRefresh))callback {
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(javaScriptPageRouter:)]) {
        return !callback?:callback(NO);
    }
    WEAK_SELF
    [self.delegate javaScriptPageRouter:^(NSString * _Nonnull router) {
        NSString *tempRouter = router;
        __block BOOL flag = NO;
        if (StrIsEmpty(tempRouter)) {
            !callback?:callback(NO);
            return ;
        }
        STRONG_SELF
        [self.autoRefreshRouter enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj containsString:tempRouter]) {
                flag = YES;
                *stop = YES;
            }
        }];
        !callback?:callback(flag);
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
#pragma mark - ASBaseWebViewController
#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);
@interface ASBaseSpecialViewController ()
<
ASNavigationViewDelegate,
HQDKJavaScriptPageConfigDelegate
>
@end
@implementation ASBaseSpecialViewController
- (instancetype)init {
    if (self = [super init]) {
        self.requestDelegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fixIOS11Keyboard];
    self.navigationController.navigationBar.hidden = true;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initRefreshView];
    if (@available(iOS 12.0, *)) {
        self.navigationController.additionalSafeAreaInsets = UIEdgeInsetsMake(-HJ_StatusBarH, 0, 0, 0);
    } else if (@available(iOS 11.0, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.showNavigationBar = NO;
    self.showProgress = NO;
    self.autoCallBackPageLifeCycle = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self safeCallHandler:kWebViewWillAppear data:nil callback:nil];
}
- (void)setWKWebViewInit {
    if (@available(iOS 9.0, *)) {
        self.wkWebView.allowsLinkPreview = NO;
    }
    self.wkWebView.backgroundColor = HJMFConfTheme.backgroundColor;
    self.wkWebView.scrollView.backgroundColor = HJMFConfTheme.backgroundColor;
    self.delegate = self;
    self.wkWebView.scrollView.bounces = NO;
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 12.0, *)) {
        self.navigationController.additionalSafeAreaInsets = UIEdgeInsetsMake(-HJ_StatusBarH, 0, 0, 0);
    } else if (@available(iOS 11.0, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
}
- (void)initProgressView{
    self.progressBar = [[ASProgressBar alloc] initWithFrame:CGRectMake(0, 41, CGRectGetWidth(self.view.frame), 2)];
    [self.progressBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
}
- (void)initRefreshView {
    self.refreshView = self.defaultView;
    self.defaultView.frame = CGRectMake(0, 0, SWidth, SHeight);
    self.defaultView.disenableBtn = YES;
}
- (void)registerBridgeManagerHander {
    WEAK_SELF
    [self.bridgeManager registerHandler:kAppCloseWebview handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        @try {
            STRONG_SELF
            if (!self.navigationController && self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
                return ;
            }
            if ([self.navigationController topViewController] == self) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                if ([tempArray containsObject:self]) {
                    [tempArray removeObject:self];
                }
                [self.navigationController setViewControllers:tempArray animated:YES];
            }
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
    [self.bridgeManager registerHandler:kAppClearUser handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [ASUserSharedManager deleteUserInfo];
    }];
    [self.bridgeManager registerHandler:kAppGetChannel handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([ASJavaScriptResponse result:HJMFConfShare.channel]);
    }];
    [self.bridgeManager registerHandler:kAppGetUserToken handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *token = @"";
        if ([ASUserManager hasAlreadyLoggedIn]) {
            token = [ASJavaScriptResponse result:ASUserSharedManager.userToken];
            ResponseCallback(token);
        } else {
            ResponseCallback([ASJavaScriptResponse result:token]);
        }
    }];
    [self.bridgeManager registerHandler:kAppGetMobilephone handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *phone = [ASUserManager loginMobilePhone];
        ResponseCallback([ASJavaScriptResponse result:SafeStr(phone)]);
    }];
    [self.bridgeManager registerHandler:kAppIsLogin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSNumber *isLogin = @([ASUserManager hasAlreadyLoggedIn]);
        ResponseCallback([ASJavaScriptResponse result:isLogin]);
    }];
    [self.bridgeManager registerHandler:kAppGetDeviceUID handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([ASJavaScriptResponse result:[UIDevice hj_devicePersistenceUUID]]);
    }];
    [self.bridgeManager registerHandler:kAppOpenNative handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        if (![data isKindOfClass:[NSString class]]) {
            ResponseCallback([ASJavaScriptResponse success]);
            return ;
        }
        NSDictionary *dic = [data hj_dictionary];
        NSString *pageId = dic[@"pageId"];
        if ([pageId integerValue] == 2) {
            ASHomeViewController *loginVc = [ASHomeViewController createWithBusinessType:ASBusinessTypeLogin];
            UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            if ([nav isKindOfClass:[UINavigationController class]]) {
                [nav pushViewController:loginVc animated:YES];
            } else {
                [nav presentViewController:loginVc animated:YES completion:nil];
            }
        }
        ResponseCallback([ASJavaScriptResponse success]);
    }];
    ASPageConfigHandler *pageConfig = [ASPageConfigHandler new];
    pageConfig.delegate = self;
    [self.bridgeManager registerHandler:pageConfig];
    [self.bridgeManager registerHandler:kAppGetLastLoginMobilePhone handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([ASJavaScriptResponse result:[ASUserManager lastLoginMobilePhone]]);
    }];
    [self registerLoginSuccessBridge:nil];
    [self.bridgeManager registerHandler:kAppDataCache handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        @try {
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSString *action = [NSString stringWithFormat:@"%@",[dic objectForKey:@"action"]];
            BOOL memoryCache = [[dic objectForKey:@"memoryCache"] boolValue];
            NSString *key = [NSString stringWithFormat:@"%@",[dic objectForKey:@"key"]];
            NSString *value = [dic objectForKey:@"value"];
            NSUserDefaults *userdefalts = [NSUserDefaults standardUserDefaults];
            if (action.integerValue == 1) {
                if (memoryCache) {
                    if (![ASInternalStorageManager sharedInstance].webData) {
                        [ASInternalStorageManager sharedInstance].webData = [[NSMutableDictionary alloc] init];
                    }
                    [[ASInternalStorageManager sharedInstance].webData setObject:value forKey:key];
                }else{
                    [userdefalts setValue:value forKey:key];
                    [userdefalts synchronize];
                }
            }else if(action.integerValue == 2){
                if (memoryCache) {
                    ResponseCallback([ASJavaScriptResponse result:[[ASInternalStorageManager sharedInstance].webData objectForKey:key]]);
                }else{
                    ResponseCallback([ASJavaScriptResponse result:[userdefalts valueForKey:key]]);
                }
            } else if(action.integerValue == 3){
                if (memoryCache) {
                    if ([[ASInternalStorageManager sharedInstance].webData objectForKey:key]) {
                        [[ASInternalStorageManager sharedInstance].webData removeObjectForKey:key];
                    }
                }else{
                    [userdefalts removeObjectForKey:key];
                    [userdefalts synchronize];
                }
            }
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
    [self.bridgeManager registerHandler:kAppGetAjaxHeader handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        NSString *userAgent = [ASBaseSpecialViewController _getUA];
        userAgent = [userAgent stringByAppendingString:[UIDevice hj_devicePersistenceUUID]];
        ASUser *userInfo = ASUserManager.sharedInstance.userInfo;
        NSString *version = [UIDevice hj_appVersion]?:@"";
        NSString *cityId = HQDKGetUserDefault(@"locationCity");
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:HJMFConfShare.channel forKey:@"channel"];
        [param setValue:cityId forKey:@"city"];
        [param setValue:@"iOS" forKey:@"os"];
        [param setValue:userAgent forKey:@"userAgent"];
        [param setValue:[UIDevice hj_bundleIdentifier] forKey:@"packageName"];
        [param setValue:userInfo.token forKey:@"token"];
        [param setValue:version forKey:@"version"];
        [param setValue:[UIDevice hj_systemVersion] forKey:@"osVersion"];
        [param setValue:[UIDevice hj_hardwareSimpleDescription] forKey:@"deviceModel"];
        [param setValue:HJMFConfShare.terminalId forKey:@"terminalId"];
        [param setValue:[UIDevice hj_devicePersistenceUUID] forKey:@"deviceNo"];
        [param setValue:userInfo.productHidden forKey:@"productHidden"];
        [param setValue:userInfo.userId forKey:@"userId"];
        [param setValue:[UIDevice hj_deviceIDFA] forKey:@"idfa"];
        [param setValue:[UIDevice hj_bundleVersion] forKey:@"innerVersion"];
        [param setValue:HJMFConfShare.projectMark forKey:@"projectMark"];
        [param setValue:@"" forKey:@"imei"];
        [param setValue:[[HJMFNetReachability sharedManager] localizedNetworkReachabilityStatusString] forKey:@"networkEnv"];
        [param setValue:HJMFConfShare.productID forKey:@"pid"];
        ResponseCallback([ASJavaScriptResponse result:param]);
    }];
    [self.bridgeManager registerHandler:kAppOpenWebview handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        if (![data isKindOfClass:[NSString class]]) {
            ResponseCallback([ASJavaScriptResponse success]);
            return ;
        }
        NSDictionary *dic = [data hj_dictionary];
        BOOL needLogin = [dic[@"needLogin"] boolValue];
        UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
        if (![rootVC isKindOfClass:[UINavigationController class]]) {
            return ;
        }
        UINavigationController *rootNav = (UINavigationController *)rootVC;
        BOOL hideNav = [dic[@"nav"][@"hide"] boolValue];
        NSString *url = dic[@"url"];
        if (needLogin && ![ASUserManager hasAlreadyLoggedIn]) {
            [ASActionHandler skipToThirdWebViewMustLogin:dic
                                                                url:url
                                                           specialW:dic[@"locate"]
                                                            hideNav:hideNav
                                                             fromVc:rootNav];
        } else {
            [ASActionHandler skipToThirdWebViewIgnoreLogin:dic
                                                                  url:url
                                                              hideNav:hideNav
                                                               fromVc:rootNav];
        }
        ResponseCallback([ASJavaScriptResponse success]);
    }];
    [self.bridgeManager registerHandler:kAppSignParams handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        @try {
            if (![data isKindOfClass:[NSString class]]) {
                NSString *tempStr = [[ASGTMBase64 decodeString:@"5Y+C5pWw5qC85byP6Kej5p6Q6ZSZ6K+v"] hj_UTF8String];
                ResponseCallback([ASJavaScriptResponse failMsg:tempStr]);
                return ;
            }
            NSDictionary *dic = [(NSString *)data hj_dictionary];
            NSString *params = dic[@"params"];
            NSDictionary *signDic = [self signWithParams:params];
            ResponseCallback([ASJavaScriptResponse result:signDic]);
        } @catch (NSException *exception) {
        }
    }];
}
#pragma mark - public Method
- (void)registerLoginSuccessBridge:(void(^)(void))success {
    [self.bridgeManager registerHandler:kAppLoginSuccess handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
        if (!data || ![data isKindOfClass:[NSString class]]) {
            return ;
        }
        NSDictionary *dic = [(NSString *)data hj_dictionary];
        ASUser *result = [ASUser new];
        [result setValuesForKeysWithDictionary:dic];
        [ASUserSharedManager storeNeedStoredUserInfomation:result];
        HQDKNCPost(kHQDKNotificationHTMLLoginSuccess, nil);
        !success?:success();
    }];
}
- (void)safeCallHandler:(NSString *)handler data:(NSString *)data callback:(void (^)(id))callback {
    WEAK_SELF
    [self checkJSBridgeComplete:^(BOOL complete) {
        STRONG_SELF
        if (complete) {
            [self.bridgeManager callHandler:handler data:data responseCallback:nil];
        } else {
        }
    }];
}
#pragma mark - Private Method
- (NSString *)safeCallHTMLFunc:(NSString *)funcName {
    NSString *templateFunc = @"function safeHtmlJSBridgeIsComplete(){ if (typeof %@ === 'function') { return %@(); } return false; } safeHtmlJSBridgeIsComplete()";
    NSString *func = [NSString stringWithFormat:templateFunc, funcName, funcName];
    return func;
}
- (void)initializeJSBridge {
    NSString *func = [self safeCallHTMLFunc:kHtmlInitializeJSBridge];
    [self.wkWebView evaluateJavaScript:func
                     completionHandler:nil];
}
- (void)checkJSBridgeComplete:(void (^)(BOOL))complete {
    NSString *func = [self safeCallHTMLFunc:kHtmlJSBridgeIsComplete];
    [self.wkWebView evaluateJavaScript:func completionHandler:^(id _Nullable value, NSError * _Nullable error) {
        !complete?:complete([value boolValue]);
    }];
}
- (void)getCurrentRouter:(void(^)(NSString *router))routerBlock {
    NSString *checkRouterJS = @"function getRouter(){ if (window.vueApp != null) {return window.vueApp.$route.path;} else {return location.hash;} }; getRouter();";
    [self.wkWebView evaluateJavaScript:checkRouterJS completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if ([data isKindOfClass:[NSString class]]) {
            NSString *router = [(NSString *)data hj_firstMatchedGroupWithRegex:@"\\w+"];
            !routerBlock?:routerBlock(router);
        } else {
            !routerBlock?:routerBlock(nil);
        }
    }];
}
#pragma mark - HJWebViewDelegate
- (BOOL)webViewViewController:(HJWebViewController *)component decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (component.webView == self.wkWebView) {
        NSURL *URL = navigationAction.request.URL;
        if (![self externalAppRequiredToOpenURL:URL]) {
            if (!navigationAction.targetFrame) {
                [self loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return YES;
            }
        } else if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            if ([self externalAppRequiredToFileURL:URL]) {
                if ([self externalAppRequiredToDownloadAPP:URL]) {
                    [self downloadAppWithURL:URL];
                } else {
                    [self launchExternalAppWithURL:URL];
                }
                decisionHandler(WKNavigationActionPolicyCancel);
                return YES;
            }
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    return YES;
}
- (void)webViewViewController:(HJWebViewController *)webViewController didWhiteScreenToLoadURL:(NSURL *)URL {
    if ([URL.absoluteString containsString:@".pdf"]) {
        return ;
    }
    [self resetWebView];
}
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[ @"http", @"https" ]];
    return ![validSchemes containsObject:URL.scheme];
}
- (BOOL)externalAppRequiredToFileURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[ @"file" ]];
    return ![validSchemes containsObject:URL.scheme];
}
- (BOOL)externalAppRequiredToDownloadAPP:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[ @"itms-appss",@"itms-apps", @"itmss" ]];
    return [validSchemes containsObject:URL.scheme];
}
- (void)downloadAppWithURL:(NSURL *)URL {
    [self launchExternalAppWithURL:URL];
}
- (void)launchExternalAppWithURL:(NSURL *)URL {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{ UIApplicationOpenURLOptionUniversalLinksOnly : @NO }
                                 completionHandler:^(BOOL success){
                                 }];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] openURL:URL];
#pragma clang diagnostic pop
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)getResoponseCode:(NSURL *)URL {
    WEAK_SELF
    self.defaultView.type = DefaultViewType_NoNetWork;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        STRONG_SELF
        NSHTTPURLResponse *tmpresponse = (NSHTTPURLResponse*)response;
        HJMFNetReachabilityStatus networkReachabilityStatus = [HJMFNetReachability sharedManager].networkReachabilityStatus;
        if(networkReachabilityStatus == HJMFNetReachabilityStatusUnknown ||
           networkReachabilityStatus == HJMFNetReachabilityStatusNotReachable ||
           !tmpresponse ||
           tmpresponse.statusCode == 400 ||
           tmpresponse.statusCode == 403 ||
           tmpresponse.statusCode == 404 ||
           tmpresponse.statusCode == 500 ||
           tmpresponse.statusCode == 503 ||
           tmpresponse.statusCode == 505 ) {
            if (self.refreshView && error.code != NSURLErrorCancelled) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.wkWebView addSubview:self.refreshView];
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.refreshView) {
                    [self.refreshView removeFromSuperview];
                }
            });
        }
    }];
    [dataTask resume];
}
- (void)setWkwebviewGesture{
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id _Nullable completion, NSError * _Nullable error) {
    }];
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}
#pragma mark - HQDKJavaScriptPageConfigDelegate
- (void)javaScriptPageRouter:(void(^)(NSString *))routerCallBack {
    [self getCurrentRouter:^(NSString *router) {
        !routerCallBack?:routerCallBack(router);
    }];
}
#pragma mark - WKNavigationDelegate
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0) {
    [self resetWebView];
}
- (DefaultView *)defaultView {
    if (!_defaultView) {
        _defaultView = [DefaultView new];
    }
    return _defaultView;
}
- (WKWebView *)wkWebView {
    if ([self.webView isKindOfClass:[WKWebView class]]) {
        return (WKWebView *)self.webView;
    }
    return nil;
}
#pragma mark - HJWebViewRequestDelegate
- (NSURLRequest *)webViewControllerCompleteRequest:(NSURLRequest *)request {
    return [HJWebViewCache cacheRequestWithRequest:request];
}
#pragma mark - Super Method
- (void)dealloc {
}
#pragma mark - HQDKFixKeyboard
- (void)keyboardWillHide {
    if (@available(iOS 11.0, *)) {
        [self.wkWebView setNeedsLayout];
    }
}
- (void)fixIOS11Keyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)backToRootViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (!rootVC ||
        ![rootVC isKindOfClass:[UINavigationController class]] ||
        ![[(UINavigationController *)rootVC hj_rootViewController] isKindOfClass:[ASHomeViewController class]]) {
        return ;
    }
    UINavigationController *rootNav = (UINavigationController *)rootVC;
    [rootNav popToRootViewControllerAnimated:YES];
    UIViewController *mainVC = [rootNav hj_rootViewController];
    if (mainVC.presentedViewController) {
        [mainVC.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (NSString *)signWithParams:(NSString *)params
                    deviceNo:(NSString * _Nonnull)deviceNo
                   timestamp:(NSInteger)timestamp {
    if (StrIsEmpty(deviceNo) || StrIsEmpty(params) || timestamp <= 0) {
        return nil;
    }
    NSMutableString *paramsStr = [NSMutableString stringWithFormat:@"%@%ld", deviceNo, (long)~timestamp];
    [paramsStr appendString:params];
    return [ASDES3Util md5Encrypt:paramsStr.copy].lowercaseString;
}
- (NSDictionary<NSString *, NSString *> *_Nullable)signWithParams:(NSString *)params {
    if (StrIsEmpty(params)) {
        return nil;
    }
    NSString *deviceNo = [UIDevice hj_devicePersistenceUUID];
    NSInteger timestamp = ((NSInteger)[[NSDate date] timeIntervalSince1970]) * 1000;
    NSString *sign = [self signWithParams:params
                                 deviceNo:deviceNo
                                timestamp:timestamp];
    if (StrIsEmpty(sign)) {
        return nil;
    }
    return @{@"deviceNo"  : deviceNo,
             @"timestamp" : [NSString stringWithFormat:@"%ld", (long)timestamp],
             @"sign"      : sign};
}
+ (NSString *)_getUA {
    NSString *userAgent = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
#if TARGET_OS_IOS
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
#elif TARGET_OS_WATCH
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; watchOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[WKInterfaceDevice currentDevice] model], [[WKInterfaceDevice currentDevice] systemVersion], [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
#pragma clang diagnostic pop
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
    }
    return userAgent;
}
@end
