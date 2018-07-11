//
//  ActiveViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ActiveViewController.h"
#import "HQWYUserManager.h"
#import <WebKit/WebKit.h>
#import "HQWYJavaSBridgeHandleMacros.h"
#import "HQWYJavaScriptResponse.h"
#import <RCMobClick/RCBaseCommon.h>
#import <HJJavascriptBridge/HJJSBridgeManager.h>
#import "NavigationView.h"
#import "LocationManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import "HQWYJavaScriptGetAjaxHeaderHandler.h"
#import "HQWYJavaScriptOpenNativeHandler.h"
#import "LocationManager.h"
#import "PopViewManager.h"
#import "DeviceManager.h"
#import "LoginAndRegisterViewController.h"
#import "HQWYJavaScriptOpenWebViewHandler.h"
#import <AppUpdate/XZYAppUpdate.h>
#import "AuthPhoneNumViewController.h"

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";

@interface ActiveViewController ()<WKNavigationDelegate,WKUIDelegate,BMKLocationManagerDelegate,NavigationViewDelegate,PopViewManagerDelegate,HQWYJavaScriptOpenNativeHandlerDelegate>
@property(nonatomic,strong)BMKLocationManager *locationManager;
/**
 桥接管理器
 */
@property (strong, nonatomic) HJJSBridgeManager *manager;


@property(strong,nonatomic)NavigationView *navigationView;

@property(strong,nonatomic)NSDictionary *getH5Dic;// 获取H5返回导航栏样式，点击回调H5

@end

@implementation ActiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero];
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
     [self initNavigation];
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

//自定义导航栏
- (void)initNavigation{
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:self.navigationView];
    self.navigationView.delegate = self;
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
    self.navigationController.navigationBar.hidden = true;
    [_manager callHandler:kWebViewWillAppear];
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
    
    /** 更新 */
    [_manager registerHandler:kAppCheckUpdate handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [XZYAppUpdate checkUpdate:^(NSError *error) {
            
        }];
    }];
    
    /*退出登录 */
    [_manager registerHandler:kAppExecLogout handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        
    }];
    
    /** 导航栏样式事件 */
    [_manager registerHandler:kAppGetNavigationBarStatus handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        self.getH5Dic = [[self jsonDicFromString:data] objectForKey:@"nav"];
        [self setNavigationStyle:self.getH5Dic];
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
        ResponseCallback([HQWYJavaScriptResponse result:HQWYUserSharedManager.userToken]);
    }];
    
    /** 注册获取用户唯一id事件 */
//    [_manager registerHandler:kAppGetUserId handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
//        NSString *useid = HQWYUserStatusSharedManager.userBaseInfo.userId;
//        ResponseCallback([HQWYJavaScriptResponse result:useid]);
//    }];
    
    /** 注册获取手机号事件 */
    [_manager registerHandler:kAppGetMobilephone handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *phone = HQWYUserSharedManager.userInfo.mobilephone;
        ResponseCallback([HQWYJavaScriptResponse result:phone]);
    }];
    
    /** 注册获取用户是否登录事件 */
    [_manager registerHandler:kAppIsLogin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSString *isLogin = @([HQWYUserManager hasAlreadyLoggedIn]).stringValue;
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
    [_manager registerHandler:[HQWYJavaScriptOpenWebViewHandler new]];
    
    /** 注册打开原生APP页面事件 */
    HQWYJavaScriptOpenNativeHandler *handler = [HQWYJavaScriptOpenNativeHandler new];
    handler.delegate = self;
    [_manager registerHandler:handler];
    
    /** 注册获取请求头事件 */
    
    [_manager registerHandler:[HQWYJavaScriptGetAjaxHeaderHandler new]];
}

#pragma mark - Public Method

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message {
    [_manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

#pragma mark setNavigationStyle
- (void)setNavigationStyle:(NSDictionary *)typeDic{
    if (typeDic != nil && [[typeDic objectForKey:@"hide"] integerValue]) {
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.hidden = true;
            self.wkWebView.frame = CGRectMake(0,-StatusBarHeight, SWidth, SHeight + TabBarHeight - 49 + StatusBarHeight);
        }];
        [self.view layoutIfNeeded];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
             self.navigationView.hidden = false;
            self.wkWebView.frame = CGRectMake(0,NavigationHeight, SWidth, SHeight - NavigationHeight + TabBarHeight - 49);
        }];
        [self.navigationView changeNavigationType:typeDic];
    }
}

-(void)rightButtonItemClick{
    if (!StrIsEmpty([[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"])) {
        [self.wkWebView evaluateJavaScript:[[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (!error) { // 成功
                NSLog(@"%@",response);
            } else { // 失败
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
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
        [self.navigationView.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
    }
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
             [self.navigationView.leftItemButton setTitle:location.rgcData.city forState:UIControlStateNormal];
        }
    }
}

/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error{
    NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    [self.navigationView.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"locStatus:{%d};",status);
    if(status == kCLAuthorizationStatusDenied){
        [self openTheAuthorizationOfLocation];
    }
}

#pragma leftItemDelegate
- (void)locationButtonClick{
     if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
         [self openTheAuthorizationOfLocation];
    }else{
        [self leftClick];
    }
}

#pragma leftItemDelegate
- (void)webGoBack{
    if (StrIsEmpty([[self.getH5Dic objectForKey:@"left"] objectForKey:@"callback"])) {
        if ([self.wkWebView canGoBack]){
            [self.wkWebView goBack];
        }
    }else{
        [self leftClick];
    }
}

- (void)leftClick{
    if (!StrIsEmpty([[self.getH5Dic objectForKey:@"left"] objectForKey:@"callback"])) {
        [self.wkWebView evaluateJavaScript:[[self.getH5Dic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (!error) { // 成功
                NSLog(@"%@",response);
            } else { // 失败
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
}

#pragma mark 登录
- (void)presentNative{
    LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
    loginVc.forgetBlock = ^{
        [self changePasswordAction];
    };
    [self presentViewController:loginVc animated:true completion:^{

    }];
}

# pragma mark 跳修改密码
- (void)changePasswordAction{
    AuthPhoneNumViewController *authPhoneNumVC = [AuthPhoneNumViewController new]; self.navigationController.navigationBar.hidden = false;
    [self.navigationController pushViewController:authPhoneNumVC animated:true];
}
@end