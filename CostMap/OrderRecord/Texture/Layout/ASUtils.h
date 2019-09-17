#ifndef ASJavaSBridgeHandleMacros_h
#define ASJavaSBridgeHandleMacros_h
#import <Foundation/Foundation.h>
static NSString * const kAppOpenNative = @"appOpenNative";
static NSString * const kAppGetAjaxHeader = @"appGetAjaxHeader";
static NSString * const kAppExecBack = @"appExecBack";
static NSString * const kAppGetChannel = @"appGetChannel";
static NSString * const kAppGetVersion = @"appGetVersion";
static NSString * const kAppGetBundleId = @"appGetBundleId";
static NSString * const kAppGetUserToken = @"appGetUserToken";
static NSString * const kAppGetUserId = @"appGetUserId";
static NSString * const kAppGetMobilephone = @"appGetMobilephone";
static NSString * const kAppIsLogin = @"appIsLogin";
static NSString * const kAppGetDeviceType = @"appGetDeviceType";
static NSString * const kAppGetDeviceUID = @"appGetDeviceUID";
static NSString * const kAppOpenWebview = @"appOpenWebview";
static NSString * const kWebViewWillAppear = @"webViewWillAppear";
static NSString * const kAppGetNavigationBarStatus = @"appSetNavigationBar";
static NSString * const kAppClearUser = @"appClearUser";
static NSString * const kAppCloseWebview = @"appCloseWebview";
static NSString * const kAppGetRoute = @"appGetRoute";
static NSString * const kAppPageConfig = @"appPageConfig";
static NSString * const kAppSetNavigationBarRight = @"appSetNavigationBarRight";
static NSString * const kAppGetLastLoginMobilePhone = @"appGetLastLoginMobilePhone";
static NSString * const kAppLoginSuccess = @"appLoginSuccess";
static NSString * const kHtmlNotifyLoginSuccess = @"htmlNotifyLoginSuccess";
static NSString * const kHtmlDownloadOther = @"htmlDownloadOther";
static NSString * const kHtmlJSBridgeIsComplete = @"htmlJSBridgeIsComplete";
static NSString * const kHtmlInitializeJSBridge = @"htmlInitializeJSBridge";
static NSString * const kHtmlHandlePush = @"htmlHandlePush";
static NSString * const kAppDataCache = @"appDataCache";
static NSString * const kAppSignParams = @"appSignParams";
#define kHQDKNotificationAppWillEnterForeground @"kAppWillEnterForeground"
#define kHQDKNotificationAppClickTopPreRecommend @"kAppClickTopPreRecommend"
#define kHQDKNotificationAppGetRoute @"kAppGetRoute"
#define kHQDKNotificationSetRouteHome @"home"
#define kHQDKNotificationDeleteUserInfo @"kDeleteUserInfo"
#define kHQDKNotificationDownloadApp @"kHQDKNotificationDownloadApp"
#define kHQDKNotificationHTMLHandlePush @"kHTMLHandlePush"
#define kHQDKNotificationHTMLLoginSuccess @"kHTMLLoginSuccess"  
FOUNDATION_STATIC_INLINE void HQDKNCPost(NSString *name, id anObject) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:anObject];
}
FOUNDATION_STATIC_INLINE void HQDKNCAddObserver(id observer, SEL aSelector, NSString *name, id anObject) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:name object:anObject];
}
#ifdef DEBUG
#   define HQDKLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define HQDKLog(...)
#endif
#define WEAK_SELF __weak typeof(self)weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf;
#define KeyWindow [[UIApplication sharedApplication] delegate].window
#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height
#define HQDKSetUserDefault(x,y) [[NSUserDefaults standardUserDefaults] setObject:x forKey:y];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define HQDKGetUserDefault(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]
#define HQDKRemoveUserDefault(x) [[NSUserDefaults standardUserDefaults] removeObjectForKey:x];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define ObjIsNilOrNull(_obj)    (((_obj) == nil) || (_obj == (id)kCFNull))
#define StrIsEmpty(_str)        (ObjIsNilOrNull(_str) || (![(_str) isKindOfClass:[NSString class]]) || ([(_str) isEqualToString:@""]))
#define ArrIsEmpty(_arr)        (ObjIsNilOrNull(_arr) || (![(_arr) isKindOfClass:[NSArray class]]) || ([(_arr) count] == 0))
#define DicIsEmpty(_dic)        (ObjIsNilOrNull(_dic) || (![(_dic) isKindOfClass:[NSDictionary class]]) || ([(_dic.allKeys) count] == 0))
#define SafeStr(_str) StrIsEmpty(_str) ? @"" : _str
#define LNAOPSAFESTRING(str) ((((str) != nil) && ![(str) isKindOfClass:[NSNull class]]) ? [NSString stringWithFormat:@"%@", (str)] : @"")
#define kUserArchiverKey @"userInfoModel"
#define kUserArchiverFileName @"userInfoFile"
#define kHQDKUserArchiverKey @"HQDKUserInfoModel"
#define kHQDKUserArchiverFileName @"HQDKUserInfoFile"
#define KUserStatus @"UserStatus"
#endif 
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface ASGTMBase64 : NSObject
+(NSData *)encodeData:(NSData *)data;
+(NSData *)decodeData:(NSData *)data;
+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSString *)stringByEncodingData:(NSData *)data;
+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;
+(NSData *)decodeString:(NSString *)string;
+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;
+(NSData *)webSafeDecodeData:(NSData *)data;
+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;
+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;
+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;
+(NSData *)webSafeDecodeString:(NSString *)string;
@end
static NSString *const kHQDKEncryptKey = @"1qaz!@#$";
@interface ASDES3Util : NSObject
+ (NSString *)encryptObject:(id) obj;
+ (id)decryptString: (NSString *)str;
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
+ (NSString *)md5Encrypt:(NSString *)str;
@end
@interface ASJavaScriptResponse : NSObject
+ (NSString *)success;
+ (NSString *)failMsg:(NSString *)msg;
+ (NSString *)result:(id)result;
+ (NSString *)responseCode:(NSString *)code error:(NSString *)error result:(id)result;
+ (NSString *)responseError:(NSError *)error;
@end
@interface UIImage (HJMFBundle)
+ (UIImage *)hjmf_imageName:(NSString *)name;
+ (UIImage *)hjmf_imageWithFileName:(NSString *)name;
@end
typedef NS_ENUM(NSInteger,DefaultViewType){
    DefaultViewType_Default, 
    DefaultViewType_NoNetWork,
    DefaultViewType_NoResult,
};
typedef void(^ReloadButtonBlock)(void);
@interface DefaultView : UIView
@property (nonatomic,strong) ReloadButtonBlock reloadBlock;
@property (nonatomic,copy) NSString *imageNameString;
@property (nonatomic,copy) NSString *tip1String;
@property (nonatomic,copy) NSString *tip2String;
@property (nonatomic,assign) DefaultViewType type;
@property (nonatomic,assign) BOOL disenableBtn;
@end
@interface LeftItemButton : UIButton
@end
@interface RightItemButton : UIButton
@end
typedef NS_ENUM(NSInteger,NavigationType) {
    navigationTypeDefault = 0,
    navigationTypeBack = 1,
};
@protocol ASNavigationViewDelegate<NSObject>
@optional
- (void)locationButtonClick;
- (void)webGoBack;
- (void)rightButtonItemClick;
@end
@interface ASNavigationView : UIView
@property (strong, nonatomic) UIImageView *arrowImage;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) LeftItemButton *leftItemButton;
@property (nonatomic,weak) id<ASNavigationViewDelegate>delegate;
@property (strong, nonatomic) RightItemButton *rightItemButton;
@property (nonatomic,strong) UILabel *leftLabel;
@property (strong,nonatomic) UIButton *titleButton;
- (void)changeNavigation:(NSDictionary *)typeDic type:(NavigationType)type;
- (void)changeNavigationRight:(NSDictionary *)typeDic;
@end
@interface ASProgressBar : UIView
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, strong) NSTimer *progressTimer;
@property(nonatomic, strong) UIImageView *progressView;
- (void)progressUpdate:(CGFloat)progress;
- (void)updateProgress:(CGFloat)progress;
@end
