#import "ASHomeViewController.h"
#import "ASUtils.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Foundation/Foundation.h>
#import <HJWebView/HJJSBridgeResponse.h>
#import "ASUtils.h"
#import <HJCategories/HJUIKit.h>
#import <HJCategories/HJFoundation.h>
#import "ASConfiguration.h"
#import "ASUtils.h"
#import <Masonry/Masonry.h>
typedef NS_ENUM(NSInteger, leftNavigationItemType) {
    leftNavigationItemTypeLocation = 0,
    leftNavigationItemTypeBack = 1
};
#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);
typedef void (^loginOutBlock)(BOOL);
@interface ASHomeViewController ()
<
ASNavigationViewDelegate,
UINavigationControllerDelegate,
HJWebViewDelegate
>
@property (assign, nonatomic) ASBusinessType businessType;
@property (strong,nonatomic) NSMutableDictionary *getH5Dic;
@property (nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) NSURL *productUrl;
@property(nonatomic, strong) NSString *productName;
@property(nonatomic, assign) BOOL isProductFirstPage;
@property(nonatomic, assign) BOOL canBack;
@property (strong,nonatomic) ASNavigationView *navigationView;
@property(nonatomic, copy)NSString *currentUrlStr;
@end
@implementation ASHomeViewController
+ (instancetype)createWithBusinessType:(ASBusinessType)type {
    ASHomeViewController *vc = [self new];
    vc.businessType = type;
    if (vc.businessType == ASBusinessTypeHome) {
        HQDKNCAddObserver(vc, @selector(htmlHandlePush:), kHQDKNotificationHandlePush, nil);
    } else if (vc.businessType == ASBusinessTypeThird) {
    } else {
    }
    return vc;
}
- (instancetype)init {
    if (self = [super init]) {
        self.businessType = ASBusinessTypeHome;
    }
    return self;
}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_businessType == ASBusinessTypeHome) {
        self.navigationController.delegate = self;
        self.isShowFailToast = false;
        [self setKWbeWViewInit];
        [self setBottomView];
        [self registerBridgeManagerHander];
#ifdef DEBUG
        [HJJSBridgeManager enableLogging];
#endif
        HQDKNCAddObserver(self, @selector(appWillEnterForegroundNoti:), kHQDKNotificationAppWillEnterForeground, nil);
        HQDKNCAddObserver(self, @selector(topPreRecommendNoti:), kHQDKNotificationAppClickTopPreRecommend, nil);
        HQDKNCAddObserver(self, @selector(changeRouteToHomeNoti:), kHQDKNotificationAppGetRoute, nil);
        HQDKNCAddObserver(self, @selector(htmlLoginSuccess:), kHQDKNotificationLoginSuccess, nil);
        HQDKNCAddObserver(self, @selector(_htmlDownloadApp:), kHQDKNotificationDownloadThird, nil);
        HQDKNCAddObserver(self, @selector(_htmlReportThird:), kHQDKNotificationReportThird, nil);
        [self loadActiveRequestWithUrl:[HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.home_url]];
    } else if (_businessType == ASBusinessTypeThird) {
        self.isShowFailToast = false;
        self.isProductFirstPage = true;
        self.canBack = true;
        [self initProgressView];
        [self initNavigation];
        [self setKWbeWViewInit];
        [self registerBridgeManagerHander];
        [self isUploadData];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appWillEnterForeground:)
                                                     name:kHQDKNotificationAppWillEnterForeground
                                                   object:nil];
    } else {
        self.delegate = self;
        [self registerBridgeManagerHander];
        [self initProgressView];
        WEAK_SELF
        [self registerLoginSuccessBridge:^{
            STRONG_SELF
            !self.loginBlock?:self.loginBlock();
        }];
        [self initNavigation];
        NSString *loginUrl = [HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.login_url];
        if (!StrIsEmpty(self.specialW)) {
            loginUrl = [NSString stringWithFormat:@"%@?w=%@", loginUrl, self.specialW];
        }
        [self loadURLString:loginUrl];
    }
}

- (void)isUploadData {
    if (!ObjIsNilOrNull(self.navigationDic) &&
        !ObjIsNilOrNull(self.navigationDic[@"productId"]) &&
        !ObjIsNilOrNull(self.navigationDic[@"productClickEventId"]) &&
        ObjIsNilOrNull(self.navigationDic[@"noReport"]) &&
        !StrIsEmpty([ASUserManager loginMobilePhone])) {
        
        NSMutableDictionary *header = [NSMutableDictionary dictionary];
        [header setValue:[ASUserManager loginMobilePhone] forKey:@"mobilePhone"];
        [header setValue:@"" forKey:@"imei"];
        [header setValue:[UIDevice hj_bundleVersion] forKey:@"appVersionCode"];
        [header setValue:[UIDevice hj_deviceIDFA] forKey:@"idfa"];
        [header setValue:self.navigationDic[@"productClickEventId"] forKey:@"clickEvent"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.navigationDic[@"category"] forKey:@"category"];
        [params setValue:self.navigationDic[@"productId"] forKey:@"productId"];
        [params setValue:HJMFConfShare.projectMark forKey:@"projectSymbol"];
        [params setValue:header forKey:@"header"];
        HQDKNCPost(kHQDKNotificationReportThird, params);
    }
}

- (void)_htmlDownloadApp:(NSNotification *)noti {
    NSDictionary *param = noti.object;
    [self safeCallHandler:kHtmlDownloadThird data:[param hj_JSONString] callback:nil];
}
- (void)htmlLoginSuccess:(NSNotification *)noti {
    [self safeCallHandler:kHtmlNotifyLoginSuccess data:nil callback:nil];
}

- (void)_htmlReportThird:(NSNotification *)noti {
    NSDictionary *param = noti.object;
    [self safeCallHandler:kHtmlReportThird data:[param hj_JSONString] callback:nil];
}

- (void)htmlHandlePush:(NSNotification *)noti {
    NSString *jsonStr = noti.object;
    [self backToRootViewController];
    [self checkJSBridgeComplete:^(BOOL complete) {
        if (complete) {
            [self.bridgeManager callHandler:kHtmlHandlePush
                                       data:jsonStr
                           responseCallback:nil];
        } else {
        }
    }];
}
- (void)loadActiveRequestWithUrl:(NSString *)url {
    if (StrIsEmpty(url) || ![NSURL URLWithString:url] ) {
        url = [HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.home_url];
    }
    [super loadURLString:url];
}
#pragma mark BottomView
- (void)setBottomView {
    if (HJ_IS_IPHONEXSERIES) {
        CGRect frame = CGRectMake(0, SHeight - HJ_BottombarH, SWidth, HJ_BottombarH);
        self.bottomView = [[UIView alloc] initWithFrame:frame];
        self.bottomView.backgroundColor = HJMFConfTheme.backgroundColor;
        [self.view addSubview:self.bottomView];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_businessType == ASBusinessTypeHome) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    } else if (_businessType == ASBusinessTypeThird) {
        if(!StrIsEmpty(self.navigationView.titleButton.titleLabel.text)) {
            self.productName = self.navigationView.titleButton.titleLabel.text;
        }
    } else {
    }
}
- (void)initRefreshView {
    [super initRefreshView];
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        self.defaultView.frame = CGRectMake(0, HJ_NavigationH, SWidth, SHeight-HJ_NavigationH);
    } else {
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, HJ_StatusBarH)];
        [self.view addSubview:statusView];
        statusView.backgroundColor = [UIColor whiteColor];
        self.progressBar.frame = CGRectMake(0, 0, SWidth, 2);
        [statusView addSubview:self.progressBar];
    }
}
- (void)initNavigation {
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        if (self.gotoThirdPart) {
            UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWidth, HJ_StatusBarH)];
            [self.view addSubview:statusView];
            statusView.backgroundColor = [UIColor whiteColor];
            self.navigationView = [[ASNavigationView alloc]initWithFrame:CGRectMake(0, HJ_StatusBarH, SWidth, 44)];
            [self.view addSubview:self.navigationView];
            self.navigationView.delegate = self;
            [self.navigationView changeNavigation:self.navigationDic[@"nav"] type:navigationTypeDefault];
            self.progressBar.frame = CGRectMake(0, 41, SWidth, 2);
            [self.navigationView addSubview:self.progressBar];
        } else {
            UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, HJ_StatusBarH)];
            [self.view addSubview:statusView];
            statusView.backgroundColor = [UIColor whiteColor];
            self.progressBar.frame = CGRectMake(0, 0, SWidth, 2);
            [statusView addSubview:self.progressBar];
        }
    } else {
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        [self.progressBar removeFromSuperview];
        if (self.navigationController.delegate == self) {
            self.navigationController.delegate = nil;
        }
    } else {
    }
}
- (void)loadURLString:(NSString *)URLString {
    if (StrIsEmpty(URLString) || ![NSURL URLWithString:URLString] ) {
        return;
    }
    [super loadURLString:URLString];
}
- (void)loadRequest:(NSURLRequest *)request {
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        self.currentUrlStr = request.URL.absoluteString;
    } else {
    }
    [super loadRequest:request];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        [self.wkWebView setNavigationDelegate:nil];
        [self.wkWebView setUIDelegate:nil];
    } else {
    }
}
- (void)resetWebView {
    if (_businessType == ASBusinessTypeHome) {
        [super resetWebView];
        [self setKWbeWViewInit];
        [self registerBridgeManagerHander];
        [self loadActiveRequestWithUrl:[HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.home_url]];
    } else if (_businessType == ASBusinessTypeThird) {
        [super resetWebView];
        [self setKWbeWViewInit];
        [self registerBridgeManagerHander];
        [self loadURLString:self.currentUrlStr];
    } else {
    }
}
- (void)setKWbeWViewInit {
    if (_businessType == ASBusinessTypeHome) {
        [super setKWbeWViewInit];
    } else if (_businessType == ASBusinessTypeThird) {
        [super setKWbeWViewInit];
        [self.wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.gotoThirdPart) {
                make.top.mas_equalTo(self.view.mas_top).mas_offset(HJ_NavigationH);
            } else {
                make.top.mas_equalTo(self.view.mas_top);
            }
            make.left.right.mas_equalTo(self.view);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view.mas_bottom);
            }
        }];
        self.wkWebView.scrollView.bounces = true;
    } else {
        [super setKWbeWViewInit];
    }
}
#pragma mark - Private Method
- (void)registerBridgeManagerHander {
    [super registerBridgeManagerHander];
    WEAK_SELF
    if (_businessType == ASBusinessTypeHome) {
        [self.bridgeManager registerHandler:kAppGetNavigationBarStatus handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
            STRONG_SELF
            self.getH5Dic = [NSMutableDictionary dictionaryWithDictionary:[[data hj_dictionary] objectForKey:@"nav"]];
            [self setNavigation:self.getH5Dic style:navigationTypeDefault];
        }];
        [self.bridgeManager registerHandler:kAppSetNavigationBarRight handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
            STRONG_SELF
            NSDictionary *right = [data hj_dictionary];
            [self.navigationView changeNavigationRight:right];
            [self.getH5Dic setValue:right forKey:@"right"];
        }];
    } else if (_businessType == ASBusinessTypeThird) {
        [self.bridgeManager registerHandler:kAppGetNavigationBarStatus handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
            STRONG_SELF
            NSDictionary *nav = [[data hj_dictionary] objectForKey:@"nav"];
            [self.navigationView changeNavigation:nav type:navigationTypeDefault];
        }];
        [self.bridgeManager registerHandler:kAppSetNavigationBarRight handler:^(id  _Nullable data, HJResponseCallback  _Nullable responseCallback) {
            STRONG_SELF
            NSDictionary *right = [data hj_dictionary];
            [self.navigationView changeNavigationRight:right];
        }];
    } else {
    }
}
#pragma mark - Public Method
- (void)downloadAppWithURL:(NSURL *)URL {
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        NSString *eventId = [NSString stringWithFormat:@"xiazai;w%@;p%@;c%@;l%@",
                             self.navigationDic[@"locate"],
                             self.navigationDic[@"sort"],
                             self.navigationDic[@"productId"],
                             self.navigationDic[@"linkSeqId"]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.navigationDic[@"locate"] forKey:@"adBlock"];
        [params setValue:self.navigationDic[@"sort"] forKey:@"adSeat"];
        [params setValue:HJMFConfShare.channel forKey:@"appChannel"];
        [params setValue:@"10.0.0" forKey:@"appVersion"];
        [params setValue:self.navigationDic[@"fromDetailPage"] forKey:@"isDetailPage"];
        [params setValue:eventId forKey:@"downDefinition"];
        [params setValue:self.navigationDic[@"linkSeqId"] forKey:@"linkId"];
        [params setValue:[ASUserManager loginMobilePhone] forKey:@"phone"];
        [params setValue:@(2) forKey:@"os"];
        [params setValue:self.navigationDic[@"productId"] forKey:@"productId"];
        [params setValue:@([HJMFConfShare.productLine integerValue]) forKey:@"productLine"];
        [params setValue:HJMFConfShare.projectMark forKey:@"projectMark"];
        HQDKNCPost(kHQDKNotificationDownloadThird, params);
    } else {
    }
    [super downloadAppWithURL:URL];
}
#pragma mark - Public Method
#pragma mark setNavigationStyle
- (void)setNavigation:(NSDictionary *)typeDic style:(NavigationType)type {
    if (typeDic == nil) {
        return;
    }
    self.bottomView.backgroundColor = HJMFConfTheme.backgroundColor;
    if ([[typeDic objectForKey:@"hide"] integerValue]) {
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.hidden = true;
        }];
        [self.view layoutIfNeeded];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.hidden = false;
        }];
        [self.navigationView changeNavigation:typeDic type:type];
        if (![[typeDic objectForKey:@"title"] isKindOfClass:[NSDictionary class]]) {
            return;
        }
    }
}
- (void)rightButtonItemClick {
    if (_businessType == ASBusinessTypeHome) {
        if ([[self.getH5Dic objectForKey:@"right"] isKindOfClass:[NSDictionary class]]) {
            if (!StrIsEmpty([[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"])) {
                [self.wkWebView evaluateJavaScript:[[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                }];
            }
        }
    } else if (_businessType == ASBusinessTypeThird) {
        self.navigationController.delegate = self;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHQDKNotificationAppClickTopPreRecommend object:nil userInfo:[self.navigationDic objectForKey:@"nav"]];
        [self toRootViewControllerAnimation:true];
    } else {
    }
}
- (void)toRootViewControllerAnimation:(BOOL)animate {
    if (self.navigationController != nil) {
        self.navigationView.backButton.enabled = true;
        [self.navigationController popToRootViewControllerAnimated:animate];
    }else{
        [self dismissViewControllerAnimated:animate completion:^{
            self.navigationView.backButton.enabled = true;
        }];
    }
}
- (void)toBeforeViewControllerAnimation:(BOOL)animate {
    if (self.navigationController != nil) {
        self.navigationView.backButton.enabled = true;
        [self.navigationController popViewControllerAnimated:animate];
    }else{
        [self dismissViewControllerAnimated:animate completion:^{
            self.navigationView.backButton.enabled = true;
        }];
    }
}
#pragma leftItemDelegate
- (void)locationButtonClick {
    [self leftClick:leftNavigationItemTypeLocation];
}
#pragma leftItemDelegate
- (void)webGoBack {
    if (_businessType == ASBusinessTypeHome) {
        [self leftClick:leftNavigationItemTypeBack];
    } else if (_businessType == ASBusinessTypeThird) {
        self.navigationView.backButton.enabled = false;
        BOOL enableBackHistory = [self.navigationDic[@"enableBackHistory"] boolValue];
        if (enableBackHistory && self.wkWebView.canGoBack) {
            [self.wkWebView goBack];
            self.navigationView.backButton.enabled = true;
            return ;
        }
        if (self.canBack) {
            self.navigationController.delegate = nil;
            [self toBeforeViewControllerAnimation:true];
        } else {
            if(self.wkWebView.canGoBack){
                [self.wkWebView goBack];
                self.navigationView.backButton.enabled = true;
            }else{
                self.navigationController.delegate = nil;
                [self toBeforeViewControllerAnimation:true];
            }
        }
    } else {
    }
}
- (void)leftClick:(leftNavigationItemType)type{
    if (![[self.getH5Dic objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
        if (type == leftNavigationItemTypeBack) {
            if ([self.wkWebView canGoBack]){
                [self.wkWebView goBack];
            }
        }
        return;
    }
    if (StrIsEmpty([[self.getH5Dic objectForKey:@"left"] objectForKey:@"callback"])) {
        if (type == leftNavigationItemTypeBack) {
            if ([self.wkWebView canGoBack]){
                [self.wkWebView goBack];
            }
        }
        return;
    }
    [self.wkWebView evaluateJavaScript:[[self.getH5Dic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (!error) { 
            NSLog(@"%@",response);
        } else { 
        }
    }];
}
- (void)webViewViewController:(HJWebViewController *)webViewController didStartLoadingURL:(NSURL *)URL {
    if (_businessType == ASBusinessTypeHome) {
    } else if (_businessType == ASBusinessTypeThird) {
        self.progressBar.isLoading = YES;
        [self.progressBar progressUpdate:.05];
    } else {
        self.progressBar.isLoading = YES;
        [self.progressBar progressUpdate:.05];
    }
}
- (void)webViewViewController:(HJWebViewController *)webViewController didFinishLoadingURL:(NSURL *)URL {
    if (_businessType == ASBusinessTypeHome) {
        self.isShowFailToast = false;
        [self getResoponseCode:URL];
        [self setWkwebviewGesture];
    } else if (_businessType == ASBusinessTypeThird) {
        self.progressBar.isLoading = NO;
        self.navigationView.backButton.enabled = true;
        if (self.isProductFirstPage) {
            self.productUrl = URL;
        }
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL];
        if(StrIsEmpty(strUrl)){
            return;
        }
        self.isShowFailToast = false;
        [self getResoponseCode:URL];
        [self checkIsShowAlertOrBack:URL];
        [self setWkwebviewGesture];
        self.isProductFirstPage = false;
    } else {
        self.progressBar.isLoading = NO;
        [self getResoponseCode:URL];
        [self setWkwebviewGesture];
    }
}
- (void)webViewViewController:(HJWebViewController *)webViewController didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    if (_businessType == ASBusinessTypeHome) {
        if (error.code != NSURLErrorCancelled) {
            self.isShowFailToast = true;
        }
        [self setWkwebviewGesture];
    } else if (_businessType == ASBusinessTypeThird) {
        self.progressBar.isLoading = NO;
        [self.progressBar updateProgress:0.0];
        self.navigationView.backButton.enabled = true;
        if (self.isProductFirstPage) {
            self.productUrl = URL;
        }
        if (error.code == 101) {
            [self.refreshView removeFromSuperview];
            return;
        } else if (error.code == 102) {
            [self.refreshView removeFromSuperview];
            return;
        } else {
            if (self.isShowFailToast) {
            }
        }
        if (error.code != NSURLErrorCancelled) {
            self.isShowFailToast = true;
        }
        [self checkIsShowAlertOrBack:URL];
        [self setWkwebviewGesture];
    } else {
    }
}
- (void)checkIsShowAlertOrBack:(NSURL *)webViewURL{
    if ([self.productUrl isEqual:webViewURL]) {
        self.canBack = true;
    } else {
        self.canBack = false;
    }
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
#pragma mark - Notification
- (void)changeRouteToHomeNoti:(NSNotification *)noti {
    [self safeCallHandler:kAppGetRoute data:kHQDKNotificationSetRouteHome callback:nil];
}
- (void)topPreRecommendNoti:(NSNotification *)notification {
    if (DicIsEmpty(notification.userInfo)) {
        return;
    }
    if (self.wkWebView.loading) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self topPreRecommendNoti:notification];
        });
    } else {
        self.getH5Dic = [[NSMutableDictionary alloc] initWithDictionary:notification.userInfo];
        [self setNavigation:self.getH5Dic style:navigationTypeBack];
        NSString *url = [HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.home_url];
        [self loadURLString:[url stringByReplacingOccurrencesOfString:@"home" withString:@"recommendlist?fromeApp=true"]];
    }
}
- (void)appWillEnterForegroundNoti:(NSNotification *)noti {
    if ([noti.userInfo[@"TenMinutesRefresh"] integerValue]) {
        NSString *url = [HJMFConfURLS.web_base_url stringByAppendingString:HJMFConfURLS.home_url];
        [self loadActiveRequestWithUrl:[NSString stringWithFormat:@"%@?autoRefresh=1", url]];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        double estimatedProgress = [change[@"new"] doubleValue];
        [self.progressBar progressUpdate:estimatedProgress];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)appWillEnterForeground:(NSNotification *)noti {
    if ([noti.userInfo[@"TenMinutesRefresh"] integerValue]) {
        [self loadURLString:self.currentUrlStr];
    }
}
@end
