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

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";

@interface ActiveViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView *activeWebView;
/**
 桥接管理器
 */
@property (strong, nonatomic) HJJSBridgeManager *manager;
@end

@implementation ActiveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [HJJSBridgeManager new];
    [_manager setupBridge:self.wkWebView navigationDelegate:self];
    
    [self registerHander];
    //[self setUpUI];
    
    [_manager callHandler:kWebViewDidLoad];
    }
    
    - (void)viewWillAppear:(BOOL)animated {
        [super viewWillAppear:animated];
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
    /*
    - (void)setUpUI {
        
        self.progressView.progressTintColor = RGBCOLORV(k0xff9d00);
        //自定义加载失败页面
        JKRefreshView *refreshView = [[JKRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        refreshView.block = ^{
            [self loadURL:self.failUrl];
        };
        self.refreshView = refreshView;
    }
     */

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
@end
