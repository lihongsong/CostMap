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

@interface HQWYActionHandler()
@property(nonatomic,copy)HQWYActionHandleBlock finishHandle;

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

+ (void)handleWithActionModel:(id<HQWYActionHandlerProtocol>)launchModel finishHandle:(HQWYActionHandleBlock)completionHandle
{
    [HQWYActionHandler defauleHandle].finishHandle = completionHandle;
    [HQWYActionHandler handleWithActionModel:launchModel];
}

+ (void)handleWithActionModel:(id<HQWYActionHandlerProtocol> )launchModel
{

    NSDictionary *dic = @{launchModel.productName:@" title",launchModel.address:@"url"};
    [self eventId:[NSString stringWithFormat:@"%@%@", HQWY_StartApp_Advertisement_click,launchModel.productId]];
    if ([HQWYUserManager hasAlreadyLoggedIn] == NO) {
        [self presentNative:dic];
        [HQWYActionHandler execultHandle:NO];
        return;
    }
    [self WebViewWithDictionary:dic];
}

+ (void)execultHandle:(BOOL)isHandle {
    HQWYActionHandler *defaultHandle = [HQWYActionHandler defauleHandle];
    if (defaultHandle.finishHandle == nil) {
        
    }else{
        defaultHandle.finishHandle(isHandle);
    }
}

/*
+ (void)goToNativePage:(NSInteger)pageTag
{
    __block UIViewController *pushedVC;
    HQWYTabBarControllerItemsType rootVCType = HQWYTabBarControllerItemsTypeDefault;
    switch (pageTag) {
        default:
            break;
    }
    
    if (pushedVC == nil) {
        
    }else{
        [self pushVCWithIndex:rootVCType viewController:pushedVC];
    }
}
*/

#pragma mark 登录
+ (void)presentNative:(NSDictionary *)dic{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
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
}

+ (ThirdPartWebVC *)WebViewWithDictionary:(NSDictionary *)urlDic {
    ThirdPartWebVC *webView = [ThirdPartWebVC new];
    webView.navigationDic = urlDic;
    [webView loadURLString:urlDic[@"url"]];
    return webView;
}

//# pragma mark 跳修改密码
//- (void)changePasswordAction{
//    AuthPhoneNumViewController *authPhoneNumVC = [AuthPhoneNumViewController new]; self.navigationController.navigationBar.hidden = false;
//    [self.navigationController pushViewController:authPhoneNumVC animated:true];
//}

@end
