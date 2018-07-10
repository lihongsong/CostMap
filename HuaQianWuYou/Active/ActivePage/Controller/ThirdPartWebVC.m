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

#define ResponseCallback(_value) \
!responseCallback?:responseCallback(_value);

static NSString * const kJSSetUpName = @"javascriptSetUp.js";
@interface ThirdPartWebVC ()<NavigationViewDelegate,HQWYReturnToDetainViewDelegate>
/**
 桥接管理器
 */
@property (strong, nonatomic) HJJSBridgeManager *manager;
@property(nonatomic,strong)HQWYReturnToDetainView *detainView;
@end

@implementation ThirdPartWebVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [HJJSBridgeManager new];
    [_manager setupBridge:self.wkWebView navigationDelegate:self];
    self.wkWebView.frame = CGRectMake(0,NavigationHeight, SWidth, SHeight - NavigationHeight + TabBarHeight - 49);
    [self initNavigation];
    [self registerHander];
    
}


//自定义导航栏
- (void)initNavigation{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:navigationView];
    navigationView.delegate = self;
    [navigationView changeNavigationType:self.navigationDic];
}

-(void)rightButtonItemClick{
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:^{

        }];
    }
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

- (HQWYReturnToDetainView *)detainView{
    if (_detainView == nil){
        _detainView = [[HQWYReturnToDetainView alloc] initWithFrame:CGRectMake(15, (SHeight - 250)/2.0, SWidth - 30, 250)];
    }
    return _detainView;
}

#pragma leftItemDelegate
- (void)webGoBack{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [[UIView alloc]init];
    [window addSubview:bgView];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [window addSubview:self.detainView];
    if (!StrIsEmpty([[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"])) {
        [self.wkWebView evaluateJavaScript:[[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (!error) { // 成功
                NSLog(@"%@",response);
            } else { // 失败
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:^{
        
        }];
    }
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
    [_manager registerHandler:kAppExecStatistic handler:^(id  _Nonnull data, HJResponseCallback  _Nullable responseCallback) {
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
    [_manager callHandler:kJSReceiveAppData data:[HQWYJavaScriptResponse result:message]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleAlertClick {
    [self.detainView removeFromSuperview];
}

- (void)nonePromptButtonClick {
    
}


@end
