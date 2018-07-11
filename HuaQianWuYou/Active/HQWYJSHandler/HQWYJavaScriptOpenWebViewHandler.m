//
//  HQWYJavaScriptOpenWebViewHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptOpenWebViewHandler.h"
#import "HQWYJavaSBridgeHandleMacros.h"
#import "HQWYJavaScriptResponse.h"
#import "LoginAndRegisterViewController.h"
#import "ThirdPartWebVC.h"

@implementation HQWYJavaScriptOpenWebViewHandler
- (NSString *)handlerName {
    return kAppOpenWebview;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    
    if (![message isKindOfClass:[NSString class]]) {
        !hander?:hander([HQWYJavaScriptResponse success]);
        return ;
    }
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    BOOL needLogin = [dic[@"needLogin"] boolValue];
   UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (needLogin && ![HQWYUserManager hasAlreadyLoggedIn]) {
        LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
        loginVc.loginBlock = ^{
            if (rootVC.navigationController != nil) {
                [rootVC.navigationController pushViewController:[self WebViewWithDictionary:dic] animated:YES];
            }else{
                [rootVC presentViewController:[self WebViewWithDictionary:dic] animated:NO completion:nil];
            }
        };
        [rootVC presentViewController:loginVc animated:true completion:^{
            
        }];
    }else{
        if (rootVC.navigationController != nil) {
            [rootVC.navigationController pushViewController:[self WebViewWithDictionary:dic] animated:YES];
        }
        else{
            [rootVC presentViewController:[self WebViewWithDictionary:dic] animated:NO completion:nil];
        }
    }
    !hander?:hander([HQWYJavaScriptResponse success]);
}

- (ThirdPartWebVC *)WebViewWithDictionary:(NSDictionary *)urlDic {
    ThirdPartWebVC *webView = [ThirdPartWebVC new];
    webView.navigationDic = urlDic;
    [webView loadURLString:urlDic[@"url"]];
    return webView;
}

@end
