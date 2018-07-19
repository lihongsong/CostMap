//
//  HQWYJavaScriptGetAjaxHeaderHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptGetAjaxHeaderHandler.h"
#import <RCMobClick/RCBaseCommon.h>
#import "NSString+cityInfos.h"
@implementation HQWYJavaScriptGetAjaxHeaderHandler
- (NSString *)handlerName {
    return kAppGetAjaxHeader;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer new];
    NSString *userAgent = [requestSerializer.HTTPRequestHeaders objectForKey:@"User-Agent"];
    userAgent = [userAgent stringByAppendingString:[RCBaseCommon getUIDString]];
    NSString *token = HQWYUserManager.sharedInstance.userToken?:@"";
    NSString *version = [RCBaseCommon getAppReleaseVersionString]?:@"";
    NSString *cityId = GetUserDefault(@"locationCity");
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:APP_ChannelId forKey:@"channel"];
    [param setValue:cityId forKey:@"city"];
    [param setValue:@"iOS" forKey:@"os"];
    [param setValue:userAgent forKey:@"UserAgent"];
    [param setValue:[RCBaseCommon getBundleIdentifier] forKey:@"packageName"];
    [param setValue:token forKey:@"token"];
    [param setValue:version forKey:@"version"];
    [param setValue:@"hqwyios" forKey:@"terminalId"];
    [param setValue:[RCBaseCommon getIdfaString] forKey:@"deviceNo"];
    
    !hander?:hander([HQWYJavaScriptResponse result:param]);
     
}
@end
