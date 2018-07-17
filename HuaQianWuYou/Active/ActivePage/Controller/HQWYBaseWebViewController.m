//
//  HQWYBaseWebViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYBaseWebViewController.h"

@interface HQWYBaseWebViewController ()<NavigationViewDelegate>

@end

@implementation HQWYBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = true;
    self.backButtonItem = nil;
    self.closeButtonItem = nil;
    self.customHeaderView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
}

//自定义导航栏
- (void)initNavigation{
   NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,StatusBarHeight, SWidth, 44)];
    [self.view addSubview:navigationView];
    navigationView.delegate = self;
}

// 定位权限
- (void)openTheAuthorizationOfLocation{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未开启定位权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
    [alert addAction:ok];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self eventId:HQWY_Location_Close_click];
    }];
    [alert addAction:cancle];
    [self presentViewController:alert animated:true completion:^{
        
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
