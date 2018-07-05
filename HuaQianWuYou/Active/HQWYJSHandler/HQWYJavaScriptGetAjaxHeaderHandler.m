//
//  HQWYJavaScriptGetAjaxHeaderHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptGetAjaxHeaderHandler.h"

@implementation HQWYJavaScriptGetAjaxHeaderHandler
- (NSString *)handlerName {
    return kAppGetAjaxHeader;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    /*
    NSString *pid = @(LNProductIDJKDSZD).stringValue;
    NSString *uid = [RCBaseCommon getUIDString]?:@"";
    NSString *channel = AppChannel;
    NSString *os = @"iOS";
    NSString *token = HQWYUserStatusSharedManager.token?:@"";
    NSString *version = [UIDevice hj_appVersion]?:@"";
    NSString *useid = HQWYUserStatusSharedManager.userBaseInfo.userId?:@"";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:uid forKey:@"uid"];
    [param setValue:channel forKey:@"channel"];
    [param setValue:os forKey:@"os"];
    [param setValue:pid forKey:@"pid"];
    [param setValue:useid forKey:@"userId"];
    [param setValue:token forKey:@"token"];
    [param setValue:version forKey:@"version"];
    [param setValue:@"apple" forKey:@"manufacture"];
    [param setValue:[UIDevice hj_manufacture] forKey:@"operators"];
    
    !hander?:hander([JKJavaScriptResponse result:param]);
     */
}
@end
