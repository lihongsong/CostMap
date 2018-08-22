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
#import "ThirdPartWebVC.h"
#import "AuthPhoneNumViewController.h"
#import "HQWYJavaScriptOpenSDKHandler.h"
#import "HJUIKit.h"
#import "NSString+cityInfos.h"
#import "HQWYUser.h"
#import "HQWYUser+Service.h"
#import "LoginOut.h"
#import "HQWYJavaScriptMonitorHandler.h"
#import "FBManager.h"
#import "NSObject+JsonToDictionary.h"
#import <HJ_UIKit/HJAlertView.h>
#import <CoreLocation/CLLocationManager.h>
#import "HQWYJavaScriptSourceHandler.h"
#import "TalkingData.h"
#import <Bugly/Bugly.h>

typedef NS_ENUM(NSInteger,leftNavigationItemType) {
    leftNavigationItemTypeLocation = 0,
    leftNavigationItemTypeBack = 1
};

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";

@interface ActiveViewController ()<BMKLocationManagerDelegate,NavigationViewDelegate,PopViewManagerDelegate,HQWYJavaScriptOpenNativeHandlerDelegate,WKNavigationDelegate>
@property(nonatomic,strong)BMKLocationManager *locationManager;

@property(strong,nonatomic)NavigationView *navigationView;

@property(strong,nonatomic)NSDictionary *getH5Dic;// 获取H5返回导航栏样式，点击回调H5

@property(nonatomic, strong)UIView *bottomView;
/**
 定位到的城市信息
 */

@property(strong,nonatomic) NSMutableDictionary *locatedCity;

/**
 用户选择的城市
 */
@property(copy,nonatomic) NSString *selectedLocation;

/**
 首页弹窗进三方页是否挽留
 */
@property(nonatomic,assign) NSNumber* needBackDialog;

/**
 是否第一次加载
 */
@property(nonatomic,assign) BOOL isFirstLoad;

@end

@implementation ActiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowFailToast = false;
    [self setUpSDK];
    [self initData];
    [self initNavigation];
    [self setUPWKWebView];
    [self registerHander];
    [HJJSBridgeManager enableLogging];
    
    NSNotificationCenter *notificatoinCenter = [NSNotificationCenter defaultCenter];
    [notificatoinCenter addObserver:self selector:@selector(appWillEnterForeground:) name:@"kAppWillEnterForeground" object:nil];
    
    [notificatoinCenter addObserver:self selector:@selector(topPreRecommend:) name:@"kAppClickTopPreRecommend" object:nil];
}

- (instancetype)init{
    if (self = [super init]) {
        self.isFirstLoad = YES;
        [self loadURLString:Active_Path];
    }
    return self;
}

- (void)setUpSDK{
    //设置意见反馈
    [FBManager configFB];
    //发送设备信息采集
    [DeviceManager sendDeviceinfo];
}

// 精准推*荐
- (void)topPreRecommend:(NSNotification *)notification{
   // NSLog(@"notification_____%@",notification.userInfo);
    self.getH5Dic = notification.userInfo;
    [self rightButtonItemClick];
}

- (void)initData{
    self.locatedCity = [NSMutableDictionary dictionaryWithDictionary:@{@"province":@"",@"city":@"",@"country":@""}];
}

#pragma mark webview 配置
- (void)setUPWKWebView{
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self setWKWebViewInit];
    [self.wkWebView ln_showLoadingHUDMoney];
    [self.view addSubview:self.wkWebView];
    WeakObj(self);
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self); make.top.mas_equalTo(self.view.mas_top).mas_offset(NavigationHeight);
        make.center.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
           self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    self.wkWebView.backgroundColor = [UIColor backgroundGrayColor];
    self.wkWebView.scrollView.backgroundColor =  [UIColor backgroundGrayColor];
    if ([DeviceTypes isIPhoneXSizedDevice]) {
        self.bottomView = [ZYZControl createViewWithFrame:CGRectMake(0, SHeight - 34, SWidth, 34)];
        self.bottomView.backgroundColor = [UIColor backgroundGrayColor];
        [self.view addSubview:self.bottomView];
    }
}

# pragma mark 弹框和悬浮弹框逻辑

- (void)showPopView{
    [PopViewManager sharedInstance].delegate = self;
    [PopViewManager showType:AdvertisingTypeAlert fromVC:self];
    [PopViewManager isHiddenCustomView:true withType:AdvertisingTypeAlert];
}

- (void )setSelectedLocation:(NSString *)selectedLocation{
    _selectedLocation = [selectedLocation stringByReplacingOccurrencesOfString:@"location:" withString:@""];
    if (![selectedLocation containsString:@"失败"] && ![selectedLocation containsString:@"定位"] && ![selectedLocation containsString:@"未知"]){
        SetUserDefault([NSString getDistrictNoFromCity:_selectedLocation], @"locationCity");
        }else{
            SetUserDefault(@"", @"locationCity");
        }
}

- (void)appWillEnterForeground:(NSNotification *)noti {
    if ([noti.userInfo[@"TenMinutesRefresh"] integerValue]) {
        NSLog(@"activeTenMinutesRefresh");
        [self.wkWebView ln_showLoadingHUDMoney];
        [self loadURLString:Active_Path];
    }
}

//弹框代理方法
- (void)didSelectedContent:(BasicDataModel *)dataModel popType:(AdvertisingType)type{
    if ([HQWYUserManager hasAlreadyLoggedIn]) {
        [self toThirdWeb:dataModel popType:type];
    }else{
        [self presentNative:^{
           [self toThirdWeb:dataModel popType:type];
        }];
    }
}

- (void)toThirdWeb:(BasicDataModel *)dataModel popType:(AdvertisingType)type{
    ThirdPartWebVC *webView = [ThirdPartWebVC new];
    webView.navigationDic = @{@"nav" : @{@"title" : @{@"text" : dataModel.productName}, @"backKeyHide":@"0", @"right" : @{@"text" : @"精准推荐", @"callback" : @"topPreRecommend()"}}, @"category" : [NSString stringWithFormat:@"%ld",(long)type], @"needBackDialog" : self.needBackDialog, @"productId" : dataModel.productId, @"url" : dataModel.address};
    [webView loadURLString:dataModel.address];
    [self.navigationController pushViewController:webView animated:true];
}

//自定义导航栏
- (void)initNavigation{
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:self.navigationView];
    self.navigationView.delegate = self;
}

-(void)initlocationService {
    
    WeakObj(self);
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 提示定位权限用途弹窗
        [self eventId:HQWY_Location_Alert_click];
        HJAlertView *alertView =
        [[HJAlertView alloc] initWithTitle:@"请允许获取定位权限"
                                   message:@"您的位置将被用来精准匹配贷款产品，并享受贷款优惠服务"
                        confirmButtonTitle:@"确认" confirmBlock:^{
                            StrongObj(self);
                            [self startLocationService];
                                   }];
        alertView.messageLabel.textAlignment = NSTextAlignmentCenter;
        alertView.confirmColor = HJHexColor(0xff6a45);
        alertView.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        alertView.messageLabel.textColor = HJHexColor(0x333333);
        alertView.titleLabel.textColor = HJHexColor(0x333333);
        
        [alertView show];
    } else {
        [self startLocationService];
    }
}

- (void)startLocationService {
    
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
    if (!self.isFirstLoad && StrIsEmpty(self.wkWebView.title)) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Active_Path]]];
    }
    [self.manager callHandler:kWebViewWillAppear];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.manager callHandler:kWebViewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.manager callHandler:kWebViewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.manager callHandler:kWebViewDidDisappear];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.manager = nil;
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
            NSDictionary *dic = [self jsonDicFromString:data];
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
    
    /*退出登录 */
    [self.manager registerHandler:kAppExecLogout handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        [self loginOut:^(BOOL isOut) {
            NSString *result = [NSString stringWithFormat:@"%d",isOut]; ResponseCallback([HQWYJavaScriptResponse result:result]);
        }];
    }];
    
    /** 导航栏样式事件 */
    [self.manager registerHandler:kAppGetNavigationBarStatus handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.needBackDialog = [[self jsonDicFromString:data] objectForKey:@"needBackDialog"];
        });
        self.getH5Dic = [[self jsonDicFromString:data] objectForKey:@"nav"];
        [self setNavigationStyle:self.getH5Dic];
        if ([(NSString *)data containsString:@"location:"]) {
            if ([self.getH5Dic[@"left"] isKindOfClass:[NSDictionary class]]) {
                self.selectedLocation = self.getH5Dic[@"left"][@"text"];
            }
        }
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
    
    /** 注册获取H5获取原生定位城市 */
    [self.manager registerHandler:kAppGetLocationCity handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:self.locatedCity]);
        if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
            
        } else {
            if ([self.navigationView.leftLabel.text containsString:@"定位"]) {
                //这种场景说明没有定位成功，需要刷新在定位时候显示定位中
                self.navigationView.leftLabel.text = @"定位中...";
            }
            self.locatedCity[@"country"] = @"";
            self.locatedCity[@"city"] = @"定位中...";
            self.locatedCity[@"province"] = @"";
            [self.locationManager startUpdatingLocation];
        } 
    }];
    
    /** 首页弹窗显示 */
    [self.manager registerHandler:kAppShowHomeAdvertiseAlert handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [PopViewManager isHiddenCustomView:false withType:AdvertisingTypeAlert];
        });
    }];
    
    /** 注册获取H5获取原生定位城市 */
    [self.manager registerHandler:kAppExecLocation handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        ResponseCallback([HQWYJavaScriptResponse result:self.locatedCity]);
        if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
            [self openTheAuthorizationOfLocation];
            
        } else {
            if ([self.navigationView.leftLabel.text containsString:@"定位"]) {
                //这种场景说明没有定位成功，需要刷新在定位时候显示定位中
                self.navigationView.leftLabel.text = @"定位中...";
            }
            self.locatedCity[@"country"] = @"";
            self.locatedCity[@"city"] = @"定位中...";
            self.locatedCity[@"province"] = @"";
            [self.locationManager startUpdatingLocation];
        }
    }];

    /** 上传H5 异常信息*/
    [self.manager registerHandler:kAppUploadException handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSDictionary *dataDic = [[NSDictionary alloc]initWithDictionary:[self jsonDicFromString:data]];
        if (dataDic[@"error"]) {
            // 上报异常信息
            /**
             *    @brief 上报自定义错误
             *
             *    @param category    类型(Cocoa=3,CSharp=4,JS=5,Lua=6)
             *    @param aName       名称
             *    @param aReason     错误原因
             *    @param aStackArray 堆栈
             *    @param info        附加数据
             *    @param terminate   上报后是否退出应用进程
             */
            [Bugly reportExceptionWithCategory:5 name:@"全局H5异常捕获" reason:@"" callStack:[NSArray arrayWithObjects:dataDic[@"error"], nil] extraInfo:@{} terminateApp:NO];
        }
    }];


    /** 注册获取H5调用原生toast */
    [self.manager registerHandler:kAppToastMessage handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSDictionary *dataDic = [[NSDictionary alloc]initWithDictionary:[self jsonDicFromString:data]];
        if (dataDic[@"message"]) {
            [self.wkWebView  ln_showToastHUD:[dataDic objectForKey:@"message"]];
        }
    }];
    
    /** 注册h5离开页面统计事件 */
    [self.manager registerHandler:kAppOnPageEnd handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [TalkingData trackPageEnd:dic[@"pageName"]];
    }];
    
    /** 注册h5进入页面事件统计 */
    [self.manager registerHandler:kAppOnPageBegin handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [TalkingData trackPageBegin:dic[@"pageName"]];
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
    
    /** 注册传图片 */
    [self.manager registerHandler:[HQWYJavaScriptSourceHandler new]];
}

#pragma mark - Public Method

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message {
    [self.manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

#pragma mark setNavigationStyle
- (void)setNavigationStyle:(NSDictionary *)typeDic{
    if (typeDic != nil && [[typeDic objectForKey:@"hide"] integerValue]) {
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.1 animations:^{
            self.navigationView.hidden = true;
        }];
        [self.view layoutIfNeeded];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
             self.navigationView.hidden = false;
        }];
        [self.navigationView changeNavigationType:typeDic];
        NSString *title = @"";
        if([[typeDic objectForKey:@"title"] isKindOfClass:[NSDictionary class]]){
            title = [[typeDic objectForKey:@"title"] objectForKey:@"text"];
        }
        if ([title isEqualToString:@"首页"] || [title isEqualToString:@"贷款大全"] ||[title isEqualToString:@"猜你可贷"] || [title length] < 2) {
            self.bottomView.backgroundColor = [UIColor whiteColor];
        }else{
           self.bottomView.backgroundColor = [UIColor backgroundGrayColor];
        }
    }
}

-(void)rightButtonItemClick{
    if ([[self.getH5Dic objectForKey:@"right"] isKindOfClass:[NSDictionary class]]) {
        if (!StrIsEmpty([[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"])) {
            [self.wkWebView evaluateJavaScript:[[self.getH5Dic objectForKey:@"right"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                if (!error) { // 成功
                    NSLog(@"____sucess____%@",response);
                } else { // 失败
                    NSLog(@"__right____%@",error.localizedDescription);
                }
            }];
        }
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
        self.navigationView.leftLabel.text = @"定位失败";
        self.locatedCity[@"country"] = @"";
        self.locatedCity[@"city"] = @"定位失败";
        self.locatedCity[@"province"] = @"";
    }
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSString *locationStr = [NSString stringWithFormat:@"%f,%f", location.location.coordinate.latitude, location.location.coordinate.longitude];
            UserDefaultSetObj(locationStr, @"LocationLatitudeLongitude");
        }
        
        if (location.rgcData) {
              NSString *cityString = location.rgcData.city;
            if ([location.rgcData.country containsString:@"中国"]) {
                if([cityString containsString:@"香港"] || [cityString containsString:@"澳门"] || [location.rgcData.province containsString:@"台湾"]){
                    self.navigationView.leftLabel.text = @"未知位置";
                }else{
                   self.navigationView.leftLabel.text = cityString;
                }
            }else{
                self.navigationView.leftLabel.text = @"未知位置";
            }
            self.locatedCity[@"country"] = location.rgcData.country;
            self.locatedCity[@"city"] = cityString;
            self.locatedCity[@"province"] = location.rgcData.province;
            self.selectedLocation = [cityString stringByReplacingOccurrencesOfString:@"市" withString:@""];
            [self.locationManager stopUpdatingLocation];
        }
    }
}

/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error{
    self.navigationView.leftLabel.text = @"定位失败";
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //NSLog(@"locStatus:{%d};",status);
    if(status == kCLAuthorizationStatusDenied){
        [self openTheAuthorizationOfLocation];
    }
}

#pragma leftItemDelegate
- (void)locationButtonClick {
    [self leftClick:leftNavigationItemTypeLocation];
}

#pragma leftItemDelegate
- (void)webGoBack{
    [self leftClick:leftNavigationItemTypeBack];
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
        if (!error) { // 成功
            NSLog(@"%@",response);
        } else { // 失败
        }
    }];
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

#pragma mark 退出登录
- (void)loginOut:(loginOutBlock)outBlock{
    
    [KeyWindow ln_showLoadingHUDCommon];
    
    [LoginOut signOUT:^(id _Nullable result, NSError * _Nullable error) {
        
        if (error) {
            if(error.hqwy_respCode == HQWYRESPONSECODE_UN_AUTHORIZATION){//这种退出登录成功处理
                [KeyWindow ln_hideProgressHUD];
                [HQWYUserSharedManager deleteUserInfo];
                outBlock(true);
            }else{
                outBlock(false);
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                      message:error.hqwy_errorMessage];
            }
            return ;
        } else {
            [KeyWindow ln_hideProgressHUD];
        }
        [HQWYUserSharedManager deleteUserInfo];
        outBlock(true);
        return;
    }];
}

- (void)webView:(HJWebViewController *)webViewController didFinishLoadingURL:(NSURL *)URL {
    self.isShowFailToast = false;
    [self getResoponseCode:URL];
    [self setWkwebviewGesture];
    [self.wkWebView ln_hideProgressHUD];
    self.isFirstLoad = NO;
}

- (void)webView:(HJWebViewController *)webViewController didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    self.isFirstLoad = NO;
    if(self.isShowFailToast){
          [self.wkWebView  ln_hideProgressHUD:LNMBProgressHUDAnimationToast message:@"网络异常~"];
    }
    self.isShowFailToast = true;
    [self setWkwebviewGesture];
    [self.wkWebView ln_hideProgressHUD];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"______******Received memory warning*****______");
    [self.wkWebView ln_showLoadingHUDMoney];
    [self loadURLString:Active_Path];
}

// 此方法适用iOS9.0以上     iOS8用监听另行处理
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    NSLog(@"进程被终止");
    NSLog(@"%@",webView.URL);
    [self loadURLString:Active_Path];
    
}

#pragma mark - KVO

// 防止白屏，单web应用，后面路由切换不会加载
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"URL"])
    {
        NSURL *newUrl = [change objectForKey:NSKeyValueChangeNewKey];
        NSURL *oldUrl = [change objectForKey:NSKeyValueChangeOldKey];
        
        if (ObjIsNilOrNull(newUrl) && !ObjIsNilOrNull(oldUrl)) {
            [self loadURLString:Active_Path];
        }
    }
}

@end
