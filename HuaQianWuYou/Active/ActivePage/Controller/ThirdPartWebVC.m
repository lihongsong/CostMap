//
//  ThirdPartWebVC.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ThirdPartWebVC.h"
#import "HQWYJavaScriptResponse.h"
#import "HQWYReturnToDetainView.h"
#import "UnClickProductModel.h"
#import "UnClickProductModel+Service.h"
#import "UploadProductModel.h"
#import "UploadProductModel+Service.h"


#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";
@interface ThirdPartWebVC ()<NavigationViewDelegate,HQWYReturnToDetainViewDelegate,WKNavigationDelegate,WKUIDelegate,HJWebViewDelegate>

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)NSInteger countTime;
@property(nonatomic, strong)NSArray *listArr;
@property(nonatomic, assign)NSInteger productIndex;
@property(nonatomic, strong)NavigationView *navigationView;
@property(nonatomic, assign)BOOL isShowAlertOrBack;//是否弹挽留或者回列表
@end

@implementation ThirdPartWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowFailToast = false;
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
    self.wkWebView.frame = CGRectMake(0,NavigationHeight, SWidth, SHeight - NavigationHeight + TabBarHeight - 49);
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
        [self initData];
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

- (void)initData{
     NSString *needBackDialog = [NSString stringWithFormat:@"%@",self.navigationDic[@"needBackDialog"]];
    if ([needBackDialog integerValue] ||[needBackDialog isEqualToString:@"true"]) {
        WeakObj(self);
        self.productIndex = 0;
        
        [UnClickProductModel getUnClickProductList:self.navigationDic[@"category"] mobilePhone:[HQWYUserManager loginMobilePhone] Completion:^(id _Nullable result, NSError * _Nullable error) {
            StrongObj(self);
            if (error) {
                return;
            } 
            self.listArr = result;
        }];
    }
}

-(void)rightButtonItemClick{
    [self eventId:HQWY_ThirdPart_Right_click];
    [self toBeforeViewController];
    if (!StrIsEmpty([[self.navigationDic objectForKey:@"right"] objectForKey:@"callback"])) {
        [self.wkWebView evaluateJavaScript:[[self.navigationDic objectForKey:@"right"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (!error) { // 成功
                NSLog(@"%@",response);
            } else { // 失败
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
}

#pragma leftItemDelegate
- (void)webGoBack{
    [self eventId:HQWY_ThirdPart_Back_click];
    if (self.isShowAlertOrBack) {
        if (!StrIsEmpty([[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"])) {
            [self.wkWebView evaluateJavaScript:[[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                if (!error) { // 成功
                } else { // 失败
                }
            }];
        }
        NSString *needBackDialog = [NSString stringWithFormat:@"%@",self.navigationDic[@"needBackDialog"]];
        if (![needBackDialog integerValue]){
            if (![needBackDialog isEqualToString:@"true"]){
                [self toBeforeViewController];
                return;
            }
        }
        
        if ([GetUserDefault(@"isShowPromptToday") isEqualToString:[self getToday]]) {
            [self toBeforeViewController];
            return;
        }
        
        if (!(self.listArr.count > 0)) {
            [self toBeforeViewController];
            return;
        }
        if(self.productIndex >= self.listArr.count){
            [self toBeforeViewController];
            return;
        }
        self.countTime = 3;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        [HQWYReturnToDetainView showController:self];
        [HQWYReturnToDetainView countTime:@"3"];
    }else{
        if(self.wkWebView.canGoBack){
            [self.wkWebView goBack];
        }else{
            [self toBeforeViewController];
        }
    }
}

- (void)toBeforeViewController{
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:^{
            
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
        NSDictionary *product = [[NSDictionary alloc]initWithDictionary:self.listArr[self.productIndex]];
        [self uploadData:product[@"id"]];
        [self loadURLString:product[@"address"]];
        //NSLog(@"____%@",product[@"address"]);
        [self.navigationView.titleButton setTitle:product[@"name"] forState:UIControlStateNormal];
        self.productIndex ++;
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
    /** 注册埋点事件 */
    [self.manager registerHandler:kAppExecStatistic handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        StrongObj(self)
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [self eventId:dic[@"eventId"]];
        ResponseCallback([HQWYJavaScriptResponse success]);
    }];
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
    [self toBeforeViewController];
    [HQWYReturnToDetainView  dismiss];
}

#pragma mark HQWYReturnToDetainViewDelegate
- (void)nonePromptButtonClick {
    SetUserDefault([self getToday],@"isShowPromptToday");
    [self toBeforeViewController];
    [HQWYReturnToDetainView  dismiss];
}

- (NSString *)getToday{
    return [NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"];
}

- (void)webView:(HJWebViewController *)webViewController didFinishLoadingURL:(NSURL *)URL{
    NSString *strUrl = [NSString stringWithFormat:@"%@",URL];
    if(StrIsEmpty(strUrl)){
        [self.wkWebView ln_showToastHUD:@"链接地址错误，打开失败"];
        return;
    }
    self.isShowFailToast = false;
    [self getResoponseCode:URL];
    [self checkIsShowAlertOrBack:URL];
    [self setWkwebviewGesture];
    [self.wkWebView ln_hideProgressHUD];
}

- (void)webView:(HJWebViewController *)webViewController didFailToLoadURL:(NSURL *)URL error:(NSError *)error{
    if (error.code == 101) {
        [self.wkWebView ln_showToastHUD:@"链接地址错误，打开失败"];
        [self.refreshView removeFromSuperview];
        return;
    }else{
        if(self.isShowFailToast){
            [self.wkWebView ln_showToastHUD:@"网络异常~"];
        }
    }
    self.isShowFailToast = true;
    [self checkIsShowAlertOrBack:URL];
    [self setWkwebviewGesture];
    [self.wkWebView ln_hideProgressHUD];
}

- (void)checkIsShowAlertOrBack:(NSURL *)webViewURL{
    NSString *urlStr = [NSString stringWithFormat:@"%@",webViewURL];
    if (self.productIndex > 0){
        NSDictionary *product = [[NSDictionary alloc]initWithDictionary:self.listArr[self.productIndex - 1]];
        if ([urlStr isEqualToString:product[@"address"]]) {
            self.isShowAlertOrBack = true;
        }else{
            self.isShowAlertOrBack = false;
        }
    }else{
        if ([urlStr isEqualToString:self.navigationDic[@"url"]]){
            self.isShowAlertOrBack = true;
        }else{
            self.isShowAlertOrBack = false;
        }
    }
}

- (void)appWillEnterForeground:(NSNotification *)noti {
    if ([noti.userInfo[@"TenMinutesRefresh"] integerValue]) {
        [self.wkWebView reload];
    }
    [self.manager callHandler:kWebViewWillAppear];
}

@end
