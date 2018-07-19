//
//  HQWYActionHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYActionHandler.h"
#import "ThirdPartWebVC.h"
#import "LoginAndRegisterViewController.h"
#import "AuthPhoneNumViewController.h"

@interface HQWYActionHandler()
@property(nonatomic,copy)HQWYActionHandleBlock finishHandle;
@property(nonatomic,strong)UIViewController *rootViewController;
/**
 事件是否被处理
 */
@property(nonatomic,assign)BOOL isHandled;


@end


@implementation HQWYActionHandler
+ (instancetype)defauleHandle
{
    static HQWYActionHandler *_defaultHandle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultHandle = [[HQWYActionHandler alloc]init];
    });
    return _defaultHandle;
}

//+ (void)handleWithActionModel:(id<HQWYActionHandlerProtocol>)launchModel finishHandle:(HQWYActionHandleBlock)completionHandle
//{
//    [HQWYActionHandler defauleHandle].finishHandle = completionHandle;
//    [HQWYActionHandler handleWithActionModel:launchModel fromVC:nil];
//}

+ (void)handleWithActionModel:(id<HQWYActionHandlerProtocol> )launchModel fromVC:(UIViewController *)rootVC
{

    [HQWYActionHandler defauleHandle].rootViewController = rootVC;
    NSDictionary *dic = @{@"nav" :@{@"title" : @{@"text" : launchModel.productName},
                                     @"backKeyHide" : @"0"},
                          @"url" : launchModel.address,
                          @"productId" : launchModel.productId};
    [self eventId:[NSString stringWithFormat:@"%@%@", HQWY_StartApp_Advertisement_click,launchModel.productId]];
    if ([HQWYUserManager hasAlreadyLoggedIn] == NO) {
        [self presentNative:dic];
        [HQWYActionHandler execultHandle:NO];
        return;
    }
    [self jumpControllerAction:[self WebViewWithDictionary:dic]];
}

+ (void)execultHandle:(BOOL)isHandle {
    HQWYActionHandler *defaultHandle = [HQWYActionHandler defauleHandle];
    if (defaultHandle.finishHandle == nil) {
        
    }else{
        defaultHandle.finishHandle(isHandle);
    }
}

#pragma mark 登录
+ (void)presentNative:(NSDictionary *)dic{
        LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
        loginVc.loginBlock = ^{
            [self jumpControllerAction:[self WebViewWithDictionary:dic]];
        };
    loginVc.forgetBlock = ^{
        [self changePasswordAction:dic];
    };
        [[HQWYActionHandler defauleHandle].rootViewController presentViewController:loginVc animated:true completion:^{
            
        }];
}

+ (ThirdPartWebVC *)WebViewWithDictionary:(NSDictionary *)urlDic {
    ThirdPartWebVC *webView = [ThirdPartWebVC new];
    webView.navigationDic = urlDic;
    [webView loadURLString:urlDic[@"url"]];
    return webView;
}

# pragma mark 跳修改密码
+ (void)jumpControllerAction:(UIViewController*)vc{
    if ([[HQWYActionHandler defauleHandle].rootViewController isKindOfClass:[UINavigationController class]]) {
        ((UINavigationController *)[HQWYActionHandler defauleHandle].rootViewController).navigationBar.hidden = false;
        [(UINavigationController *)[HQWYActionHandler defauleHandle].rootViewController pushViewController:vc animated:true];
    }else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [[HQWYActionHandler defauleHandle].rootViewController presentViewController:nav animated:true completion:^{
            
        }];
    }
}

# pragma mark 跳修改密码
+ (void)changePasswordAction:(NSDictionary *)dic{
    AuthPhoneNumViewController *authPhoneNumVC = [AuthPhoneNumViewController new];
    authPhoneNumVC.finishblock = ^{
        [self jumpControllerAction:[self WebViewWithDictionary:dic]];
    };
    [self jumpControllerAction:authPhoneNumVC];
   
}

@end
