#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
#pragma mark - Protocol
@protocol ASPreludeDelegate <NSObject>
- (BOOL)hjmf_needSingPrelude;
- (void)hjmf_singPreludeWithCompletion:(void (^)(void))completion;
@end
@interface ASTheme : NSObject
#pragma mark -
@property (strong, nonatomic) UIColor *navTitleTextColor;
@property (strong, nonatomic) UIFont *navTitleTextFont;
@property (strong, nonatomic) UIImage *backIndicatorImage;
@property (strong, nonatomic) UIColor *navBarTintColor;
@property (strong, nonatomic) UIColor *navTintColor;
#pragma mark -
@property (strong, nonatomic) UIColor *tabBarShadowColor;
@property (strong, nonatomic) UIColor *mainColor;
@property (strong, nonatomic) UIColor *foregroundColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *placeHolderColor;
@property (strong, nonatomic) UIColor *errorColor;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *subTitleColor;
@property (strong, nonatomic) UIColor *promptColor;
@property (strong, nonatomic) UIColor *weakPromptColor;
@property (strong, nonatomic) UIColor *separatorColor;
@property (strong, nonatomic) UIColor *sectionSpaceColor;
@property (strong, nonatomic) UIColor *disableColor;
@property (strong, nonatomic) UIColor *hightlightedColor;
@property (strong, nonatomic) UIFont *statemetnFont;
@property (strong, nonatomic) UIFont *subTitleFont;
@end
@interface ASUrl : NSObject
#pragma mark -
@property (copy, nonatomic) NSString *service_base_url;
@property (copy, nonatomic) NSString *web_base_url;
#pragma mark -
@property (copy, nonatomic) NSString *login_url;
@property (copy, nonatomic) NSString *home_url;
@end
@interface ASConfiguration : NSObject
+ (instancetype)shareInstance;
#pragma mark -
@property (weak, nonatomic) id<ASPreludeDelegate> preludeDelegate;
#pragma mark -
@property (strong, nonatomic) ASUrl *urls;
#pragma mark -
@property (strong, nonatomic) ASTheme *theme;
@property (copy, nonatomic) NSString *productLine;
@property (copy, nonatomic) NSString *productID;
@property (copy, nonatomic) NSString *appIdentify;
@property (copy, nonatomic) NSString *channel;
@property (copy, nonatomic) NSString *terminalId;
@property (copy, nonatomic) NSString *projectMark;
@property (copy, nonatomic) NSString *tokenInvalidCode;
@property (assign, nonatomic, getter=isCommando) BOOL commando;
@end
#define HJMFConfShare [ASConfiguration shareInstance]
#define HJMFConfURLS HJMFConfShare.urls
#define HJMFConfTheme HJMFConfShare.theme
NS_ASSUME_NONNULL_END
