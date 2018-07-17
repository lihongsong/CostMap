//
//  HQWYJavaScriptOpenSDKHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptOpenSDKHandler.h"
#import "FBManager.h"

@implementation HQWYJavaScriptOpenSDKHandler
- (NSString *)handlerName {
    return kAppOpenSDK;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    
    if (![message isKindOfClass:[NSString class]]) {
        !hander?:hander([HQWYJavaScriptResponse success]);
        return ;
    }
    [self feedbackAction];
    !hander?:hander([HQWYJavaScriptResponse success]);
}

# pragma mark Action

- (void)feedbackAction{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [FBManager showFBViewController:rootVC];
}

@end
