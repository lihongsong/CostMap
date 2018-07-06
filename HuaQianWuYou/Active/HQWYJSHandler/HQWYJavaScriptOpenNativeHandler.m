//
//  HQWYJavaScriptOpenNativeHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptOpenNativeHandler.h"
#import "HQWYJavaSBridgeHandleMacros.h"

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

    if ([pageId integerValue] == 1) {
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



@end
