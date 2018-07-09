//
//  HQWYJavaScriptOpenNativeHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptOpenNativeHandler.h"
#import "HQWYJavaSBridgeHandleMacros.h"
#import "LoginAndRegisterViewController.h"
#import "FBManager.h"

@implementation HQWYJavaScriptOpenNativeHandler

- (NSString *)handlerName {
    return kAppOpenNative;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    
    if (![message isKindOfClass:[NSString class]]) {
        !hander?:hander([HQWYJavaScriptResponse success]);
        return ;
    }

    NSDictionary *dic = [self jsonDicFromString:message];
    NSString *pageId = dic[@"pageId"];

    if ([pageId integerValue] == 2) {
        if ([self.delegate respondsToSelector:@selector(presentNative)]) {
            [self.delegate presentNative];
        }
    }else if([pageId integerValue] == 3){
        
    }else if([pageId integerValue] == 4){
        
    }else if([pageId integerValue] == 5){
        [self feedbackAction];
    }

    !hander?:hander([HQWYJavaScriptResponse success]);
}

- (NSDictionary *)jsonDicFromString:(NSString *)string {
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}


# pragma mark Action

- (void)feedbackAction{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [FBManager showFBViewController:rootVC];
}

#pragma mark 跳登录

- (void)junpToSignIn{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    LoginAndRegisterViewController *loginVc = [[LoginAndRegisterViewController alloc]init];
    loginVc.navigationController.navigationBar.hidden = true;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [rootVC presentViewController:loginVc animated:true completion:^{
        
    }];
       // [rootVC presentViewController:nav animated:true completion:nil];
}


@end
