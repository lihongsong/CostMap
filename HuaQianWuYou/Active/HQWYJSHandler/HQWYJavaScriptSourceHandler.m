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

    NSString *banner = [self getImageBase64:@"banner" withType:@"png"];
    NSString *defaultIcon = [self getImageBase64:@"default" withType:@"png"];
    NSString *defaultban = [self getImageBase64:@"defaultban" withType:@"png"];
    NSString *loadfail = [self getImageBase64:@"defaultpage_nowifi" withType:@"png"];
    NSString *loading = [self getImageBase64:@"MBProgressloading" withType:@"gif"];
    NSString *loggedin = [self getImageBase64:@"loggedin" withType:@"png"];
    NSString *nodata = [self getImageBase64:@"nodata" withType:@"png"];
    NSString *notloggedin = [self getImageBase64:@"notloggedin" withType:@"png"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:banner forKey:@"banner"];
     [param setValue:defaultIcon forKey:@"default"];
    [param setValue:defaultban forKey:@"defaultban"];
    [param setValue:loadfail forKey:@"loadfail"];
    [param setValue:loading forKey:@"loading"];
    [param setValue:loggedin forKey:@"loggedin"];
    [param setValue:nodata forKey:@"nodata"];
    [param setValue:notloggedin forKey:@"notloggedin"];

    !hander?:hander([HQWYJavaScriptResponse result:param]);
}

- (NSString *)getImageBase64:(NSString *)name withType:(NSString *)type{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]];
    NSLog(@"_____%@",[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];//base64 等分换行
}

@end
