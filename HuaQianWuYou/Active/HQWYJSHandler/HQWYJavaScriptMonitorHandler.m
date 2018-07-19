//
//  HQWYJavaScriptMonitorHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/19.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptMonitorHandler.h"
#import "HQWYJavaSBridgeHandleMacros.h"
#import "NSObject+HQWYSendNetworkError.h"
@implementation HQWYJavaScriptMonitorHandler
- (NSString *)handlerName {
    return kAppUrlExceptionMonitor;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    if (![message isKindOfClass:[NSString class]]) {
        !hander?:hander([HQWYJavaScriptResponse success]);
        return ;
    }
    NSDictionary *dic = [self jsonDicFromString:message];
    [HQWYJavaScriptMonitorHandler sendNetworkErrorDic:dic];
     !hander?:hander([HQWYJavaScriptResponse success]);
}

- (NSDictionary *)jsonDicFromString:(NSString *)string {
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}

@end
