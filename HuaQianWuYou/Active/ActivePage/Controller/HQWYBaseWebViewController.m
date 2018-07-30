//
//  HQWYBaseWebViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYBaseWebViewController.h"
#import <HJ_UIKit/HJAlertView.h>
#import "HQWYJavaScriptOpenWebViewHandler.h"
#import <AppUpdate/XZYAppUpdate.h>
#import "HQWYUserManager.h"
#import <WebKit/WebKit.h>
#import "HQWYJavaSBridgeHandleMacros.h"
#import "HQWYJavaScriptResponse.h"
#import <RCMobClick/RCBaseCommon.h>
#import <HJJavascriptBridge/HJJSBridgeManager.h>
#import "HQWYJavaScriptGetAjaxHeaderHandler.h"
#import "HQWYJavaScriptOpenNativeHandler.h"
#import "HQWYJavaScriptOpenSDKHandler.h"
#import "HQWYJavaScriptMonitorHandler.h"
#import "LoginAndRegisterViewController.h"
#import "AuthPhoneNumViewController.h"


#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

@interface HQWYBaseWebViewController ()<NavigationViewDelegate,HJWebViewDelegate,HQWYJavaScriptOpenNativeHandlerDelegate>

@end

@implementation HQWYBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    self.backButtonItem = nil;
    self.closeButtonItem = nil;
    self.customHeaderView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initRefreshView];
    //[self registerStaticHander];
}

#pragma mark webview 配置
- (void)setWKWebViewInit{
    if (@available(iOS 9.0, *)) {
        self.wkWebView.allowsLinkPreview = NO;
    } else {
        // Fallback on earlier versions
    }
    self.wkWebView.backgroundColor = [UIColor backgroundGrayColor];
    self.wkWebView.scrollView.backgroundColor =  [UIColor backgroundGrayColor];
    self.delegate = self;
    self.wkWebView.scrollView.bounces = NO;
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
    
}

//自定义导航栏
- (void)initNavigation{
   NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:navigationView];
    navigationView.delegate = self;
}

- (void)initRefreshView {
    UIView *customeDefaultView = [UIView new];
    customeDefaultView.frame = self.view.frame;
    customeDefaultView.backgroundColor = [UIColor backgroundGrayColor];
    self.refreshView = customeDefaultView;
    
     UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"defaultpage_nowifi"];
    [customeDefaultView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 130)); make.centerY.mas_equalTo(customeDefaultView.mas_centerY).mas_offset(-65.0);
        make.centerX.mas_equalTo(customeDefaultView.mas_centerX);
        
    }];
    UILabel *label = [UILabel new];
    [customeDefaultView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.height.mas_equalTo(16.5);
    }];
    label.text = @"网络异常";
    label.font = [UIFont stateFont];
    label.textColor = HJHexColor(0xbbbbbb);
    
    UIButton *refreshBtn = [UIButton new];
    [customeDefaultView addSubview:refreshBtn];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.mas_equalTo(label.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(label.mas_centerX);
    }];
    
    [refreshBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:HJHexColor(0xFF601A) forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont stateFont];
    refreshBtn.layer.borderColor = HJHexColor(0xFF601A).CGColor;
    refreshBtn.layer.borderWidth = 0.5;
    refreshBtn.cornerRadius = 15;
    [refreshBtn addTarget:self action:@selector(reloadWebview) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Private Method

- (void)registerStaticHander {
    WeakObj(self)
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
    
    /** 更新 */
    [self.manager registerHandler:kAppCheckUpdate handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [XZYAppUpdate checkUpdate:^(NSError *error) {
            NSLog(@"____%@____%@",error,error.description);
        }];
    }];
    
    
    //清除用户信息
    [self.manager registerHandler:kAppClearUser handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [HQWYUserSharedManager deleteUserInfo];
    }];
    
    /** 注册获取app版本事件 */
    [self.manager registerHandler:kAppGetVersion handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_appVersion]]);
    }];
    
    /** 注册获取bundleID事件 */
    [self.manager registerHandler:kAppGetBundleId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_bundleName]]);
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

- (UIView *)changeRefreshView {
    UIView *customeDefaultView = [UIView new];
    customeDefaultView.frame = self.view.frame;
    customeDefaultView.backgroundColor = [UIColor backgroundGrayColor];
    self.refreshView = customeDefaultView;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"defaultpage_nowifi"];
    [customeDefaultView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 130)); make.centerY.mas_equalTo(customeDefaultView.mas_centerY).mas_offset(-65.0);
        make.centerX.mas_equalTo(customeDefaultView.mas_centerX);
        
    }];
    UILabel *label = [UILabel new];
    [customeDefaultView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.height.mas_equalTo(16.5);
    }];
    label.text = @"网络异常";
    label.font = [UIFont stateFont];
    label.textColor = HJHexColor(0xbbbbbb);
    return customeDefaultView;
}

// 定位权限
- (void)openTheAuthorizationOfLocation {
    
    NSMutableAttributedString *attributeString = [NSMutableAttributedString new];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 7;
    
    NSDictionary *topParam = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName: HJHexColor(0x333333),
                               NSParagraphStyleAttributeName: paragraphStyle
                               };
    
    NSDictionary *bottomParam = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:13],
                                  NSForegroundColorAttributeName: HJHexColor(0x666666)
                                  };
    
    NSAttributedString *topContentString =
    [[NSAttributedString alloc] initWithString:@"您的位置将被用来精准匹配贷款产品，并享受贷款优惠服务"
                                    attributes:topParam];
    
    NSAttributedString *bottomContentString =
    [[NSAttributedString alloc] initWithString:@"\n \n设置路径：设置->隐私->定位服务"
                                    attributes:bottomParam];
    
    [attributeString appendAttributedString:topContentString];
    [attributeString appendAttributedString:bottomContentString];
    
    HJAlertView *alertView =
    [[HJAlertView alloc] initWithTitle:@"请允许获取定位权限"
                      attributeMessage:attributeString
                    confirmButtonTitle:@"去设置"
                          confirmBlock:^{
                              
                              [self eventId:HQWY_Location_Seting_click];
                              NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                              if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                  if (@available(iOS 10.0, *)) {
                                      [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                                  } else {
                                      [[UIApplication sharedApplication] openURL:url];
                                  }
                              }
                              
                          }];
    
    alertView.cancelBlock = ^{
        [self eventId:HQWY_Location_Close_click];
    };
    
    alertView.revokable = YES;
    alertView.confirmColor = HJHexColor(0xff6a45);
    alertView.titleLabel.textAlignment = NSTextAlignmentLeft;
    alertView.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    alertView.titleLabel.textColor = HJHexColor(0x333333);
    
    [alertView show];
    
    return ;
}

// 对HJWebViewController 基类方法重写，去除基类定义导航栏
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (webView == self.wkWebView) {
        NSURL *URL = navigationAction.request.URL;
        if (![self externalAppRequiredToOpenURL:URL]) {
            if (!navigationAction.targetFrame) {
                [self loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        } else if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            if ([self externalAppRequiredToFileURL:URL]) {
                [self launchExternalAppWithURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}

- (NSDictionary *)jsonDicFromString:(NSString *)string {
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[ @"http", @"https" ]];
    return ![validSchemes containsObject:URL.scheme];
}

- (BOOL)externalAppRequiredToFileURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[ @"file" ]];
    return ![validSchemes containsObject:URL.scheme];
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
    // Dispose of any resources that can be recreated.
}

- (void)reloadWebview {
    if (![self externalAppRequiredToOpenURL:self.failUrl]) {
        [self.wkWebView ln_showLoadingHUDMoney];
    }
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:self.failUrl]];
}

- (void)getResoponseCode:(NSURL *)URL{
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *tmpresponse = (NSHTTPURLResponse*)response;
        NSLog(@"statusCode:%ld", (long)tmpresponse.statusCode);
        if(tmpresponse.statusCode == 400 || tmpresponse.statusCode == 403 || tmpresponse.statusCode == 404 || tmpresponse.statusCode == 500 || tmpresponse.statusCode == 503 || tmpresponse.statusCode == 505 ){
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
        
    }];//去除长按手势
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
    
}

#pragma mark 登录
- (void)presentNative:(loginFinshBlock)block{
    LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
    loginVc.forgetBlock = ^{
        [self changePasswordAction:^{
            block();
        }];
    };
    loginVc.loginBlock = ^{
        block();
    };
    [self presentViewController:loginVc animated:true completion:^{
        
    }];
}


# pragma mark 跳修改密码
- (void)changePasswordAction:(SignFinishBlock)fixBlock{
    AuthPhoneNumViewController *authPhoneNumVC = [AuthPhoneNumViewController new]; self.navigationController.navigationBar.hidden = false;
    authPhoneNumVC.finishblock = ^{
        fixBlock();
    };
    [self.navigationController pushViewController:authPhoneNumVC animated:true];
}

@end
