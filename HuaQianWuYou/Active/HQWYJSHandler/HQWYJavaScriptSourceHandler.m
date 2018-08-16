//
//  HQWYJavaScriptSourceHandler.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/30.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptSourceHandler.h"
#import "NSObject+JsonToDictionary.h"

@implementation HQWYJavaScriptSourceHandler
- (NSString *)handlerName {
    return kAppGetImageSource;
}

- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander {

    NSString *banner = [self getImageBase64:@"bannerIcon" withType:@"png"];
    NSString *logoDefault = [self getImageBase64:@"productIcon" withType:@"png"];
    NSString *middleBanner = [self getImageBase64:@"middleBannerIcon" withType:@"png"];
    NSString *loadfail = [self getImageBase64:@"loadFailIcon" withType:@"png"];
    NSString *loading = [self getImageBase64:@"MBProgressloading" withType:@"gif"];
    NSString *loginAvatar = [self getImageBase64:@"loginAvatar" withType:@"png"];
    NSString *nodata = [self getImageBase64:@"noDataIcon" withType:@"png"];
    NSString *logoutAvatar = [self getImageBase64:@"logoutAvatar" withType:@"png"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:banner forKey:@"bannerIcon"];
     [param setValue:logoDefault forKey:@"productIcon"];
    [param setValue:middleBanner forKey:@"middleBannerIcon"];
    [param setValue:loadfail forKey:@"loadFailIcon"];
    [param setValue:loading forKey:@"loadingIcon"];
    [param setValue: loginAvatar forKey:@"loginAvatar"];
    [param setValue:nodata forKey:@"noDataIcon"];
    [param setValue: logoutAvatar forKey:@"logoutAvatar"];

    !hander?:hander([HQWYJavaScriptResponse result:param]);
}

- (NSString *)getImageBase64:(NSString *)name withType:(NSString *)type{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];//base64 等分换行
}

@end
