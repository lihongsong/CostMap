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
@interface ThirdPartWebVC ()<NavigationViewDelegate,HQWYReturnToDetainViewDelegate,WKNavigationDelegate,WKUIDelegate>
/**
 桥接管理器
 */
@property (strong, nonatomic)HJJSBridgeManager *manager;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)NSInteger countTime;
@property(nonatomic, strong)NSArray *listArr;
@property(nonatomic, assign)NSInteger productIndex;
@property(nonatomic, strong)NavigationView *navigationView;
@property(nonatomic, assign)BOOL isShowAlert;//是否弹挽留或者回列表
@end

@implementation ThirdPartWebVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArr = [[NSArray alloc]init];
    self.isShowAlert = true;
    self.manager = [HJJSBridgeManager new];
    [_manager setupBridge:self.wkWebView navigationDelegate:self];
    self.wkWebView.frame = CGRectMake(0,NavigationHeight, SWidth, SHeight - NavigationHeight + TabBarHeight - 49);
    [self initNavigation];
    [self registerHander];
    if (self.navigationDic != nil && [[NSString stringWithFormat:@"%@",self.navigationDic[@"productId"]] length] > 0) {
        [self uploadData:self.navigationDic[@"productId"]];
    }
    [self initData];
    
    [KeyWindow ln_showLoadingHUD];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [KeyWindow ln_hideProgressHUD];
}

#pragma mark 上报数据
- (void)uploadData:(NSNumber *)productId {
    
    [KeyWindow ln_showLoadingHUD];
    
    [UploadProductModel uploadProduct:self.navigationDic[@"category"] mobilePhone:[HQWYUserManager loginMobilePhone] productID:productId Completion:^(UploadProductModel * _Nullable result, NSError * _Nullable error) {
        [KeyWindow ln_hideProgressHUD];
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
        
        [KeyWindow ln_showLoadingHUD];
        
        self.productIndex = 0;
        
        [UnClickProductModel getUnClickProductList:self.navigationDic[@"category"] mobilePhone:[HQWYUserManager loginMobilePhone] Completion:^(id _Nullable result, NSError * _Nullable error) {
            StrongObj(self);
            if (error) {
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                      message:error.hqwy_errorMessage];
                return;
            } else {
                [KeyWindow ln_hideProgressHUD];
            }
            self.listArr = result;
        }];
    }
}

-(void)rightButtonItemClick{
    [self eventId:HQWY_ThirdPart_Back_click];
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
           
            } else { // 失败
;
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
        NSLog(@"____%@",product[@"address"]);
        [self.navigationView.titleButton setTitle:product[@"name"] forState:UIControlStateNormal];
        self.productIndex ++;
    }else{
        [HQWYReturnToDetainView countTime:[NSString stringWithFormat:@"%ld",(long)self.countTime]];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _manager = nil;
    [self.timer invalidate];
    self.timer = nil;
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
    [HQWYReturnToDetainView  dismiss];
}

- (NSString *)getToday{
    return [NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [KeyWindow ln_hideProgressHUD];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [KeyWindow ln_hideProgressHUD];
}



@end
