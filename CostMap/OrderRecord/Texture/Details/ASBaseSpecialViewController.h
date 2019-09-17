#import "HJWebViewController.h"
#import "ASUtils.h"
#import <HJWebView/HJWebViewCache.h>
#import <HJWebView/HJUniversalWebViewController.h>
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import <HJCategories/HJCoreFoundation.h>
#pragma mark - Manager
#import <SystemConfiguration/SystemConfiguration.h>
NS_ASSUME_NONNULL_BEGIN
@interface ASUser : NSObject
@property (nonatomic, copy) NSString *mobilePhone;
@property (nonatomic, copy) NSString *respDateTime;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *productHidden;
@property (nonatomic, copy) NSString *clear;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userMergeId;
@end
#define ASUserSharedManager [ASUserManager sharedInstance]
typedef void(^UserManegerCallBack)(ASUser *userInfo);
@interface ASUserManager : NSObject
@property (nonatomic,strong,readonly) ASUser * userInfo;
@property(nonatomic,copy,readonly) NSString *userToken;
+ (instancetype)sharedInstance;
- (void)storeNeedStoredUserInfomation:(ASUser *)userInfo;
-(void)storeUserMobilePhone:(NSString *)mobilePhone;
- (void)deleteUserInfo;
+ (BOOL)hasAlreadyLoggedIn;
+ (NSString *)lastLoginMobilePhone;
+ (NSString *)loginMobilePhone;
+ (NSNumber *)getUserStatus;
@end
@interface ASActionHandler : NSObject
+ (void)skipToThirdWebViewMustLogin:(NSDictionary *)dic
                                url:(NSString *)url
                           specialW:(NSString *)specialW
                            hideNav:(BOOL)hideNav
                             fromVc:(UINavigationController *)nav;
+ (void)skipToThirdWebViewIgnoreLogin:(NSDictionary *)dic
                                  url:(NSString *)url
                              hideNav:(BOOL)hideNav
                               fromVc:(UINavigationController *)nav;
+ (void)checkLoginWithLoginComplete:(void(^)(void))loginComplete
                           specialW:(NSString *)specialW
                             fromVc:(UINavigationController *)nav;
@end
typedef NS_ENUM(NSInteger, HJMFNetReachabilityStatus) {
    HJMFNetReachabilityStatusUnknown = -1,
    HJMFNetReachabilityStatusNotReachable = 0,
    HJMFNetReachabilityStatusReachableVia2G = 1,
    HJMFNetReachabilityStatusReachableVia3G = 2,
    HJMFNetReachabilityStatusReachableVia4G = 3,
    HJMFNetReachabilityStatusReachableViaWiFi = 4,
};
@interface HJMFNetReachability : NSObject
@property (readonly, nonatomic, assign) HJMFNetReachabilityStatus networkReachabilityStatus;
@property (readonly, nonatomic, assign, getter=isReachable) BOOL reachable;
@property (readonly, nonatomic, assign, getter=isReachableViaWWAN) BOOL reachableViaWWAN;
@property (readonly, nonatomic, assign, getter=isReachableViaWiFi) BOOL reachableViaWiFi;
+ (instancetype)sharedManager;
+ (instancetype)manager;
+ (instancetype)managerForDomain:(NSString *)domain;
+ (instancetype)managerForAddress:(const void *)address;
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;
- (void)startMonitoring;
- (void)stopMonitoring;
- (NSString *)localizedNetworkReachabilityStatusString;
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(HJMFNetReachabilityStatus status))block;
@end
@interface ASInternalStorageManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *webData;
+ (instancetype)sharedInstance;
@end
#pragma mark - ASBaseWebViewController
@protocol HQDKJavaScriptPageConfigDelegate <NSObject>
- (void)javaScriptPageRouter:(void(^)(NSString *))routerCallBack;
@end
@interface ASPageConfigHandler : NSObject<HJBridgeProtocol>
@property (weak, nonatomic) id<HQDKJavaScriptPageConfigDelegate> delegate;
@end
typedef void (^loginFinshBlock)(void);
typedef void (^SignFinishBlock)(void);
@interface ASBaseSpecialViewController : HJUniversalWebViewController <HJWebViewDelegate, HJWebViewRequestDelegate>
@property (nonatomic, strong) ASProgressBar *progressBar;
@property(nonatomic,assign) BOOL isShowFailToast;
@property(nonatomic, strong) DefaultView *defaultView;
@property (readonly) WKWebView *wkWebView;
- (void)initProgressView;
- (void)initRefreshView;
- (void)setWkwebviewGesture;
- (void)setWKWebViewInit;
- (void)getResoponseCode:(NSURL *)URL;
- (void)getCurrentRouter:(void(^)(NSString *router))routerBlock;
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL;
- (void)registerBridgeManagerHander;
- (void)registerLoginSuccessBridge:(void(^)(void))success;
- (void)backToRootViewController;
- (void)safeCallHandler:(NSString *)handler data:(NSString *)data callback:(void(^)(id data))callback;
- (void)checkJSBridgeComplete:(void (^)(BOOL))complete;
- (BOOL)externalAppRequiredToDownloadAPP:(NSURL *)URL;
- (void)downloadAppWithURL:(NSURL *)URL;
- (void)fixIOS11Keyboard;
@end
NS_ASSUME_NONNULL_END
