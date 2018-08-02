//
//  ThirdPartWebVC.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ThirdPartWebVC.h"
#import "HQWYJavaScriptResponse.h"
#import "UnClickProductModel.h"
#import "UnClickProductModel+Service.h"
#import "UploadProductModel.h"
#import "UploadProductModel+Service.h"
#import "HQWYJavaScriptOpenSDKHandler.h"
#import "HQWYJavaScriptOpenNativeHandler.h"
#import "HQWYJavaScriptOpenWebViewHandler.h"
#import "HQWYJavaScriptGetAjaxHeaderHandler.h"
#import <RCMobClick/RCBaseCommon.h>
#import "HQWYJavaScriptMonitorHandler.h"

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static void *HJWebContext = &HJWebContext;
static NSString * const kJSSetUpName = @"javascriptSetUp.js";
@interface ThirdPartWebVC ()<NavigationViewDelegate,WKNavigationDelegate,WKUIDelegate,HJWebViewDelegate,HQWYJavaScriptOpenNativeHandlerDelegate>

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)NSInteger countTime;
@property(nonatomic, strong)NSArray *listArr;//后台返的产*品list
@property(nonatomic, strong)NSURL *productUrl;//每一个产*品第一个页面url
@property(nonatomic, assign)BOOL isProductFirstPage;
@property(nonatomic, strong)NavigationView *navigationView;
@property(nonatomic, assign)BOOL isShowAlertOrBack;//是否弹挽留或者回列表
@end

@implementation ThirdPartWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowFailToast = false;
    self.isProductFirstPage = true;
    self.listArr = [[NSArray alloc]init];
    self.isShowAlertOrBack = true;
    [self setUPWKWebView];
    [self initNavigation];
    [self registerHander];
    [self isUploadData];
    if (![self externalAppRequiredToOpenURL:self.wkWebView.URL]) {
         [self.wkWebView ln_showLoadingHUDMoney];
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:@"kAppWillEnterForeground" object:nil];
}

#pragma mark webview 配置
- (void)setUPWKWebView{
    [self setWKWebViewInit];
    self.wkWebView.scrollView.bounces = true;
    self.wkWebView.frame = CGRectMake(0,NavigationHeight, SWidth, SHeight - NavigationHeight + TabBarHeight - 49);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (StrIsEmpty(self.wkWebView.title)) {
        [self.wkWebView reload];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.wkWebView ln_hideProgressHUD];
}

- (void)isUploadData{
    if (self.navigationDic != nil && self.navigationDic[@"productId"] != nil && !StrIsEmpty([HQWYUserManager loginMobilePhone])) {
        NSString *productID = [NSString stringWithFormat:@"%@",self.navigationDic[@"productId"]];
        if(!StrIsEmpty(productID)){
            [self uploadData:self.navigationDic[@"productId"]];
        }
    }
}

#pragma mark 上报数据
- (void)uploadData:(NSNumber *)productId {
    [UploadProductModel uploadProduct:self.navigationDic[@"category"] mobilePhone:[HQWYUserManager loginMobilePhone] productID:productId Completion:^(UploadProductModel * _Nullable result, NSError * _Nullable error) {
        [self initDataCompletion:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
    }];
}

//自定义导航栏
- (void)initNavigation{
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWidth, StatusBarHeight)];
    [self.view addSubview:statusView];
    statusView.backgroundColor = [UIColor whiteColor];
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:self.navigationView];
    self.navigationView.delegate = self;
    [self.navigationView changeNavigationType:self.navigationDic[@"nav"]];
}

- (void)initDataCompletion:(nullable void (^)(id _Nullable, NSError * _Nullable))completion{
    if (self.navigationDic[@"needBackDialog"]) {
        WeakObj(self);
        [UnClickProductModel getUnClickProductList:self.navigationDic[@"category"] mobilePhone:[HQWYUserManager loginMobilePhone] Completion:^(id _Nullable result, NSError * _Nullable error) {
            StrongObj(self);
            if (error) {
                completion(result,error);
                return;
            }
            self.listArr = result;
            NSLog(@"____%@____",self.listArr);
            completion(result,error);
        }];
    }else{
        completion(nil,nil);
    }
}

#pragma mark 右边精准推荐
-(void)rightButtonItemClick{
    [self eventId:HQWY_ThirdPart_Right_click];
   // NSLog(@"______右边精准推荐");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kAppClickTopPreRecommend" object:nil userInfo:[self.navigationDic objectForKey:@"nav"]];
    [self toBeforeViewControllerAnimation:false];
}

#pragma leftItemDelegate
- (void)webGoBack{
    self.navigationView.backButton.enabled = false;
    [self eventId:HQWY_ThirdPart_Back_click];
    if (self.isShowAlertOrBack) {
        if ([[self.navigationDic objectForKey:@"left"] isKindOfClass:[NSDictionary class]]) {
            if (!StrIsEmpty([[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"])) {
                [self.wkWebView evaluateJavaScript:[[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    if (!error) { // 成功
                    } else { // 失败
                    }
                }];
            }
        }
      
        if ([self.navigationDic[@"needBackDialog"] isEqual:@0]){
                [self toBeforeViewControllerAnimation:true];
                return;
        }
        
        if ([GetUserDefault(@"isShowPromptToday") isEqualToString:[self getToday]]) {
            [self toBeforeViewControllerAnimation:true];
            return;
        }
        
        if (!(self.listArr.count > 0)) {
            [self toBeforeViewControllerAnimation:true];
            return;
        }
    
        self.countTime = 3;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        [HQWYReturnToDetainView showController:self];
        [HQWYReturnToDetainView countTime:@"3"];
    }else{
        if(self.wkWebView.canGoBack){
            [self.wkWebView goBack];
            self.navigationView.backButton.enabled = true;
        }else{
            [self toBeforeViewControllerAnimation:true];
        }
    }
}

- (void)toBeforeViewControllerAnimation:(BOOL) animate{
    if (self.navigationController != nil) {
        self.navigationView.backButton.enabled = true;
        [self.navigationController popViewControllerAnimated:animate];
    }else{
        [self dismissViewControllerAnimated:animate completion:^{
            self.navigationView.backButton.enabled = true;
        }];
    }
}

- (void)changeTime{
     self.countTime--;
    if (self.countTime <= 0) {
        [HQWYReturnToDetainView dismiss];
        self.countTime = 3;
        [self.timer invalidate];
        self.timer = nil;
        [self.wkWebView ln_showLoadingHUDMoney];
        [self initDataCompletion:^(id _Nullable result, NSError * _Nullable error) {
            if (error) {
                self.navigationView.backButton.enabled = true;
                [self.wkWebView ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.hqwy_errorMessage];
                return;
            }
            [self.wkWebView ln_hideProgressHUD];
            if (self.listArr.count > 0) {
                NSDictionary *product = [[NSDictionary alloc]initWithDictionary:self.listArr[0]];
                [self uploadData:product[@"id"]];
                self.isProductFirstPage = true;
                [self loadURLString:product[@"address"]];
                [self.navigationView.titleButton setTitle:product[@"name"] forState:UIControlStateNormal];
            }else{
                self.navigationView.backButton.enabled = true;
            }
        }];
    }else{
        [HQWYReturnToDetainView countTime:[NSString stringWithFormat:@"%ld",(long)self.countTime]];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.manager = nil;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Private Method

- (void)registerHander {
    WeakObj(self)
    self.manager = [HJJSBridgeManager new];
    [self.manager setupBridge:self.wkWebView navigationDelegate:self];
    /** 隐藏 loading */
    [self.manager registerHandler:kAppDismissLoading handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [KeyWindow ln_hideProgressHUD];
        ResponseCallback([HQWYJavaScriptResponse success]);
    }];
    
    /** 展示 loading */
    [self.manager registerHandler:kAppShowLoading handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [KeyWindow ln_showLoadingHUDCommon:@"拼命加载中…"];
        ResponseCallback([HQWYJavaScriptResponse success]);
    }];
    
    /** 注册埋点事件 */
    [self.manager registerHandler:kAppExecStatistic handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        StrongObj(self)
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [self eventId:dic[@"eventId"]];
        ResponseCallback([HQWYJavaScriptResponse success]);
    }];
    
    //清除用户信息
    [self.manager registerHandler:kAppClearUser handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [HQWYUserSharedManager deleteUserInfo];
    }];
    
    /** 注册获取app版本事件 */
    [self.manager registerHandler:kAppGetVersion handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_appVersion]]);
    }];
    
    /** 注册获取channel事件 */
    [self.manager registerHandler:kAppGetChannel handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:APP_ChannelId]);
    }];
    
    /** 注册获取bundleID事件 */
    [self.manager registerHandler:kAppGetBundleId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_bundleName]]);
    }];
    
    /** web 返回 */
    [self.manager registerHandler:kAppExecBack handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    /** web 返回 */
    [self.manager registerHandler:kAppCloseWebview handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    /** 注册获取用户token事件 */
    [self.manager registerHandler:kAppGetUserToken handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *token = @"";
        if ([HQWYUserManager hasAlreadyLoggedIn]) {
            token = [HQWYJavaScriptResponse result:HQWYUserSharedManager.userToken];
            ResponseCallback(token);
        } else {
            ResponseCallback([HQWYJavaScriptResponse result:token]);
        }
        
    }];
    
    /** 注册获取手机号事件 */
    [self.manager registerHandler:kAppGetMobilephone handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *phone = [HQWYUserManager loginMobilePhone];
        
        ResponseCallback([HQWYJavaScriptResponse result:SafeStr(phone)]);
    }];
    
    /** 注册获取用户是否登录事件 */
    [self.manager registerHandler:kAppIsLogin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *isLogin = @([HQWYUserManager hasAlreadyLoggedIn]).stringValue;
        ResponseCallback([HQWYJavaScriptResponse result:isLogin]);
    }];
    
    /** 获取用户需要登录事件 */
    [self.manager registerHandler:kAppNeedLogin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *isLogin = @([HQWYUserManager hasAlreadyLoggedIn]).stringValue;
        if ([HQWYUserManager hasAlreadyLoggedIn]) {
            ResponseCallback([HQWYJavaScriptResponse result:isLogin]);
        }else{
            [self presentNative:^{
                ResponseCallback([HQWYJavaScriptResponse result:@1]);
            }];
        }
    }];
    
    /** 注册获取设备类型事件 */
    [self.manager registerHandler:kAppGetDeviceType handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:@"iOS"]);
    }];
    
    /** 注册获取设备唯一标识事件 */
    [self.manager registerHandler:kAppGetDeviceUID handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[RCBaseCommon getUIDString]]);
    }];
    
    /** 注册打开webView事件 */
    [self.manager registerHandler:[HQWYJavaScriptOpenWebViewHandler new]];
    
    /** 注册打开原生APP页面事件 */
    HQWYJavaScriptOpenNativeHandler *handler = [HQWYJavaScriptOpenNativeHandler new];
    handler.delegate = self;
    [self.manager registerHandler:handler];
    
    /** 注册打开SDK意见反馈事件 */
    [self.manager registerHandler:[HQWYJavaScriptOpenSDKHandler new]];
    
    /** 注册获取请求头事件 */
    
    [self.manager registerHandler:[HQWYJavaScriptGetAjaxHeaderHandler new]];
    
    /** 注册异常监控事件 */
    [self.manager registerHandler:[HQWYJavaScriptMonitorHandler new]];
}

#pragma mark - Public Method

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message {
    [self.manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HQWYReturnToDetainViewDelegate
- (void)cancleAlertClick {
    [self toBeforeViewControllerAnimation:true];
    [HQWYReturnToDetainView  dismiss];
}

#pragma mark HQWYReturnToDetainViewDelegate
- (void)nonePromptButtonClick {
    SetUserDefault([self getToday],@"isShowPromptToday");
    [self toBeforeViewControllerAnimation:true];
    [HQWYReturnToDetainView  dismiss];
}

- (NSString *)getToday{
    return [NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"];
}

- (void)webView:(HJWebViewController *)webViewController didFinishLoadingURL:(NSURL *)URL{
    self.navigationView.backButton.enabled = true;
    if (self.isProductFirstPage) {
        self.productUrl = URL;
    }
    NSString *strUrl = [NSString stringWithFormat:@"%@",URL];
    if(StrIsEmpty(strUrl)){
        [self.wkWebView  ln_hideProgressHUD:LNMBProgressHUDAnimationError message:@"链接地址错误，打开失败"];
        return;
    }
    self.isShowFailToast = false;
    [self getResoponseCode:URL];
    [self checkIsShowAlertOrBack:URL];
    [self setWkwebviewGesture];
    self.isProductFirstPage = false;
    [self.wkWebView ln_hideProgressHUD];
}

- (void)webView:(HJWebViewController *)webViewController didFailToLoadURL:(NSURL *)URL error:(NSError *)error{
    self.navigationView.backButton.enabled = true;
    if (self.isProductFirstPage) {
        self.productUrl = URL;
    }
    if (error.code == 101) {
          [self.wkWebView  ln_hideProgressHUD:LNMBProgressHUDAnimationError message:@"链接地址错误，打开失败"];
        [self.refreshView removeFromSuperview];
        return;
    }else if (error.code == 102){
       [self.refreshView removeFromSuperview];
        [self.wkWebView ln_hideProgressHUD];
        return;
    }else{
        if(self.isShowFailToast){
            [self.wkWebView  ln_hideProgressHUD:LNMBProgressHUDAnimationToast message:@"网络异常~"];
        }
    }
    self.isShowFailToast = true;
    [self checkIsShowAlertOrBack:URL];
    [self setWkwebviewGesture];
    [self.wkWebView ln_hideProgressHUD];
}

- (void)checkIsShowAlertOrBack:(NSURL *)webViewURL{
    if ([self.productUrl isEqual:webViewURL]) {
        self.isShowAlertOrBack = true;
    }else{
         self.isShowAlertOrBack = false;
    }
}

- (void)appWillEnterForeground:(NSNotification *)noti {
    if ([noti.userInfo[@"TenMinutesRefresh"] integerValue]) {
        NSLog(@"appWillEnterForeground222");
        [self.wkWebView ln_showLoadingHUDMoney];
        [self loadURLString:self.navigationDic[@"url"]];
    }
}
@end
