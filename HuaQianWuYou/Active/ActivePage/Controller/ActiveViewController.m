//
//  ActiveViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ActiveViewController.h"
#import "HQWYUserStatusManager.h"
#import <WebKit/WebKit.h>
#import "HQWYJavaSBridgeHandleMacros.h"
#import "HQWYJavaScriptResponse.h"
#import <RCMobClick/RCBaseCommon.h>
#import <HJJavascriptBridge/HJJSBridgeManager.h>
#import "LeftItemView.h"
#import "RightItemButton.h"
#import "LocationManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import "HQWYJavaScriptGetAjaxHeaderHandler.h"
#import "HQWYJavaScriptOpenNativeHandler.h"
#import "LeftItemButton.h"
#import "RightItemButton.h"
#import "LocationManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import "PopViewManager.h"
#import "DeviceManager.h"
#import "LoginAndRegisterViewController.h"
#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";

@interface ActiveViewController ()<WKNavigationDelegate,WKUIDelegate,BMKLocationManagerDelegate,LeftItemViewDelegate,PopViewManagerDelegate>
@property(nonatomic,strong)BMKLocationManager *locationManager;
@property(nonatomic,strong)WKWebView *wkWebView;
/**
 桥接管理器
 */
@property (strong, nonatomic) HJJSBridgeManager *manager;

@property (strong, nonatomic) RightItemButton *rightItemButton;
@property(strong,nonatomic)LeftItemView *leftItem;

@end

@implementation ActiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SWidth, SHeight)];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.17.16.79:8088/#/home"]]];
    //http://172.17.16.79:8088/#/home
    //http://172.17.106.138:8088/#/citylist
    //http://t1-static.huaqianwy.com/hqwy/dist/#/home
    //http://www.baidu.com
    [self.wkWebView setNavigationDelegate:self];
    [self.view addSubview:self.wkWebView];
    self.manager = [HJJSBridgeManager new];
    [_manager setupBridge:self.wkWebView navigationDelegate:self];
    [self registerHander];
    [self initlocationService];
    [HJJSBridgeManager enableLogging];
    [_manager callHandler:kWebViewDidLoad];
    
    //发送设备信息采集
    [DeviceManager sendDeviceinfo];
}

# pragma mark 弹框和悬浮弹框逻辑

- (void)showPopView{
    [PopViewManager sharedInstance].delegate = self;
    [PopViewManager showType:AdvertisingTypeAlert fromVC:self];
    [PopViewManager showType:AdvertisingTypeSuspensionWindow fromVC:self];
    
}

//弹框代理方法
- (void)didSelectedContentUrl:(NSString *)url popType:(AdvertisingType)type{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)initNavigation{
    self.leftItem.delegate = self; self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:self.leftItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton];
}

-(void)initlocationService{
    //初始化实例
    self.locationManager = [[BMKLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.allowsBackgroundLocationUpdates = NO;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
    self.locationManager.locationTimeout = 10;
    self.locationManager.reGeocodeTimeout = 10;
    [self.locationManager startUpdatingLocation];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_manager callHandler:kWebViewWillAppear];
    self.navigationItem.title = @"花钱无忧";
    [self initNavigation];
}

-(RightItemButton *)rightItemButton
{
    if (_rightItemButton == nil) {
        _rightItemButton = [RightItemButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.frame = CGRectMake(0, 0, 70, 40);
        [_rightItemButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightItemButton setImage:[UIImage imageNamed:@"navbar_accurate"] forState:UIControlStateNormal];
        [_rightItemButton setTitle:@"精准推荐" forState:UIControlStateNormal];
        [_rightItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _rightItemButton;
}

-(LeftItemView *)leftItem
{
    if (_leftItem == nil) {
        _leftItem = [[LeftItemView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [_leftItem changeType:LeftItemViewTypeLocationAndRecommendation];
    }
    return _leftItem;
}
    
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_manager callHandler:kWebViewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_manager callHandler:kWebViewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_manager callHandler:kWebViewDidDisappear];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _manager = nil;
}

#pragma mark - Private Method

- (void)registerHander {
    WeakObj(self)
    
    /** 注册埋点事件 */
        [_manager registerHandler:kAppExecStatistic handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
            StrongObj(self)
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            [self eventId:dic[@"eventId"]];
            ResponseCallback([HQWYJavaScriptResponse success]);
        }];
    
    /** 注册H5获取City事件 */
        [_manager registerHandler:kAppGetCity handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
            ResponseCallback([HQWYJavaScriptResponse result:self.leftItem.leftItemButton.titleLabel.text]);
        }];
    
    /** 注册Native获取City事件 */
    [_manager registerHandler:kAppGetSelectCity handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [self.leftItem.leftItemButton setTitle:[NSString stringWithFormat:@"%@",data] forState:UIControlStateNormal];
    }];
    
    /** 导航栏样式事件 */
    [_manager registerHandler:kAppGetNavigationBarStatus handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSInteger type = [NSString stringWithFormat:@"%@",data].integerValue;
        [self setNavigationStyle:type];
    }];
    
    /** 注册获取PID事件 */
//        [_manager registerHandler:kAppGetProductId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
//            NSString *productID = @(LNProductIDJKDSZD).stringValue;
//            ResponseCallback([HQWYJavaScriptResponse result:productID]);
//        }];
//
    /** 注册获取ChannelID事件 */
//        [_manager registerHandler:kAppGetChannel handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
//            ResponseCallback([HQWYJavaScriptResponse result:AppChannel]);
//        }];
    
    /** 注册获取app版本事件 */
    [_manager registerHandler:kAppGetVersion handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_appVersion]]);
    }];
    
    /** 注册获取bundleID事件 */
    [_manager registerHandler:kAppGetBundleId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[UIDevice hj_bundleName]]);
    }];
    
    /** 注册获取用户token事件 */
    [_manager registerHandler:kAppGetUserToken handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:HQWYUserStatusSharedManager.token]);
    }];
    
    /** 注册获取用户唯一id事件 */
    [_manager registerHandler:kAppGetUserId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *useid = HQWYUserStatusSharedManager.userBaseInfo.userId;
        ResponseCallback([HQWYJavaScriptResponse result:useid]);
    }];
    
    /** 注册获取手机号事件 */
    [_manager registerHandler:kAppGetMobilephone handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *phone = HQWYUserStatusSharedManager.userBaseInfo.mobilephone;
        ResponseCallback([HQWYJavaScriptResponse result:phone]);
    }];
    
    /** 注册获取用户是否登录事件 */
    [_manager registerHandler:kAppIsLogin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *isLogin = @([HQWYUserStatusManager hasAlreadyLoggedIn]).stringValue;
        ResponseCallback([HQWYJavaScriptResponse result:isLogin]);
    }];
    
    /** 注册获取设备类型事件 */
    [_manager registerHandler:kAppGetDeviceType handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:@"iOS"]);
    }];
    
    /** 注册获取设备唯一标识事件 */
    [_manager registerHandler:kAppGetDeviceUID handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:[RCBaseCommon getUIDString]]);
    }];
    
    /** 注册打开webView事件 */
   // [_manager registerHandler:[JKJavaScriptOpenWebViewHandler new]];
    
    /** 注册打开原生APP页面事件 */
    [_manager registerHandler:[HQWYJavaScriptOpenNativeHandler new]];
    
    /** 注册获取请求头事件 */
    [_manager registerHandler:[HQWYJavaScriptGetAjaxHeaderHandler new]];
}

#pragma mark - Public Method

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message {
    [_manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

#pragma mark setNavigationStyle
- (void)setNavigationStyle:(NSInteger)type{
    self.wkWebView.frame =CGRectMake(0, 0, SWidth, SHeight); self.navigationController.navigationBar.hidden = false;
    [self.leftItem changeType:type];
    if ((type == LeftItemViewTypeLocationAndRecommendation) || (type == LeftItemViewTypeBackAndRecommendation || type == LeftItemViewTypeRecommendation)) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton];;
    }else if (type == LeftItemViewTypeNoneNavigation){
        self.wkWebView.frame =CGRectMake(0, -StatusBarHeight - 20, SWidth, SHeight + 20 + StatusBarHeight); self.navigationController.navigationBar.hidden = true;
        
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}



-(void)rightButtonClick{
    [_manager callHandler:kTopPreRecommend];
}

#pragma - mark BMKLocationManagerDelegate

/**
 *用户位置更新后，会调用此函数
 *
 */

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error

{
    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        //self.leftItemButton.locationButton.text = @"定位失败";
        [self.leftItem.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
            //self.leftItemButton.locationButton.text = location.rgcData.city;
             [self.leftItem.leftItemButton setTitle:location.rgcData.city forState:UIControlStateNormal];
        }
    }
}

/*
- (void)checkWebViewCanGoBack{
    if (_wkWebView && [_wkWebView canGoBack]) {
        [self addSpaceButton];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        [self checkWebViewCanGoBack];
        
        [self updateNavigationBarState];
        
        self.progressBar.isLoading = NO;
        
        // 如果在首页且无法后退，则隐藏后退item
        if (![webView canGoBack] && self.navigationController.viewControllers.count == 1) {
            self.navigationItem.leftBarButtonItems = @[];
        }
        
        if([self.delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
            [self.delegate webBrowser:self didFinishLoadingURL:self.wkWebView.URL];
        }
    }
}
 */

/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error{
    NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    //self.leftItemButton.locationButton.text = @"定位失败";
    [self.leftItem.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"locStatus:{%d};",status);
    if(status == kCLAuthorizationStatusDenied){
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未开启定位权限" preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *ok = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
           if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
             [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
             [[UIApplication sharedApplication] openURL:url];
            }
           }
          }];
          [alert addAction:ok];
          UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
          }];
          [alert addAction:cancle];
          [self presentViewController:alert animated:true completion:^{
        
          }];
    }
}

#pragma leftItemDelegate
- (void)locationButtonClick{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.17.106.138:8088/#/citylist"]]];
    //http://172.17.106.138:8088/#/citylist
    //http://t1-static.huaqianwy.com/hqwy/dist/#/home
    //http://www.baidu.com
}

#pragma leftItemDelegate
- (void)webGoBack{
    if ([self.wkWebView canGoBack]){
        [self.wkWebView goBack];
    }
}

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

    
- (void)jumpToLogin{
    LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:true];
}

@end
