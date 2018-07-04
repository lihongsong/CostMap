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
#import "LeftItemButton.h"
#import "RightItemButton.h"
#import "LocationManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";

@interface ActiveViewController ()<WKNavigationDelegate,WKUIDelegate,BMKLocationManagerDelegate>
@property(nonatomic,strong)BMKLocationManager *locationManager;
@property(nonatomic,strong)WKWebView *activeWebView;
/**
 桥接管理器
 */
@property (strong, nonatomic) HJJSBridgeManager *manager;
@property (strong, nonatomic) LeftItemButton *leftItemButton;
@property (strong, nonatomic) RightItemButton *rightItemButton;
@end

@implementation ActiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [HJJSBridgeManager new];
    [_manager setupBridge:self.wkWebView navigationDelegate:self];
    [self registerHander];
    [self initlocationService];
    [_manager callHandler:kWebViewDidLoad];
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
    self.navigationItem.title = @"首页";
    [self setNavigationItem:YES];
}

- (void)setNavigationItem:(BOOL)hidden {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftItemButton];
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18.5, 5, 3)];
    arrowView.image = [UIImage imageNamed:@"navbar_triangle"];
    UIBarButtonItem *arrowItem =[[UIBarButtonItem alloc] initWithCustomView:arrowView];
    self.navigationItem.leftBarButtonItems = @[barButtonItem,arrowItem];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(UIButton *)leftItemButton
{
    if (_leftItemButton == nil) {
        _leftItemButton = [LeftItemButton buttonWithType:UIButtonTypeCustom];
        _leftItemButton.frame = CGRectMake(0, 0, 70, 40);
        [_leftItemButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftItemButton setImage:[UIImage imageNamed:@"navbar_location_02"] forState:UIControlStateNormal];
        [_leftItemButton setTitle:@"定位中..." forState:UIControlStateNormal];
        [_leftItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _leftItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _leftItemButton;
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
//        [_manager registerHandler:kAppExecStatistic handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
//            StrongObj(self)
//            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
//            [self eventId:dic[@"eventId"]];
//            ResponseCallback([HQWYJavaScriptResponse success]);
//        }];
    
    /** 注册页面返回事件 */
    [_manager registerHandler:kAppExecBack handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        StrongObj(self)
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        ResponseCallback([HQWYJavaScriptResponse success]);
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
    //[_manager registerHandler:[JKJavaScriptOpenNativeHandler new]];
    
    /** 注册获取请求头事件 */
    //[_manager registerHandler:[JKJavaScriptGetAjaxHeaderHandler new]];
}

#pragma mark - Public Method

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message {
    [_manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

-(void)leftButtonClick{
    
}

-(void)rightButtonClick{
    
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
        [self.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
            //self.leftItemButton.locationButton.text = location.rgcData.city;
             [self.leftItemButton setTitle:location.rgcData.city forState:UIControlStateNormal];
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
    //self.leftItemButton.locationButton.text = @"定位失败";
    [self.leftItemButton setTitle:@"定位失败" forState:UIControlStateNormal];
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

@end
