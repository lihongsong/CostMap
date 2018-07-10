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
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger countTime;
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
    if (!StrIsEmpty([[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"])) {
        [self.wkWebView evaluateJavaScript:[[self.navigationDic objectForKey:@"left"] objectForKey:@"callback"] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            if (!error) { // 成功
                NSLog(@"%@",response);
            } else { // 失败
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
    if ([GetUserDefault(@"isShowPromptToday") isEqualToString:[self getToday]]) {
        self.countTime = 3;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        [HQWYReturnToDetainView showController:self];
        [HQWYReturnToDetainView countTime:@"3"];
    }else{
        [self toBeforeViewController];
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
        [self loadURLString:@"http://www.baidu.com"];
      
    }else{
        [HQWYReturnToDetainView countTime:[NSString stringWithFormat:@"%ld",(long)self.countTime]];
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

#pragma mark HQWYReturnToDetainViewDelegate
- (void)cancleAlertClick {
    [self toBeforeViewController];
    [HQWYReturnToDetainView  dismiss];
}

#pragma mark HQWYReturnToDetainViewDelegate
- (void)nonePromptButtonClick {
    SetUserDefault([self getToday],@"isShowPromptToday");
    [self toBeforeViewController];
}

- (NSString *)getToday{
    return [NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"];
}

@end
