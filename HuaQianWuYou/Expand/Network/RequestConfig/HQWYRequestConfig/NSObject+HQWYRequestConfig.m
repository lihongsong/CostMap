//
//  NSObject+HQWYRequest.m
//  LNNetwork
//
//  Created by terrywang on 2017/6/29.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "NSObject+HQWYRequestConfig.h"
#import "NSError+HQWYError.h"
#import "NSObject+HQWYResponseCode.h"
#import "YYModel.h"
#import <RCMobClick/RCMobClick.h>
#import <RCMobClick/RCBaseCommon.h>
#import "HQWYUserManager.h"
#import "NSObject+HQWYSendNetworkError.h"


static NSString *const kHQWYRespCodeKey     = @"respCode";
static NSString *const kHQWYRespMsgKey      = @"respMsg";
static NSString *const kHQWYBodyKey         = @"body";

@implementation NSObject (HQWYRequestConfig)


+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {

    //超时时间
    requestSerializer.timeoutInterval = 20;

    [self setupRequestSerializer:requestSerializer];
}

//公共请求头
+ (void)setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    //FIXME:v2.0 请求头参数设置
    //客户端统一使用小写，服务端不区分大小写
    [requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];

    [requestSerializer setValue:[RCBaseCommon getAppReleaseVersionString] forHTTPHeaderField:@"version"];

    //拼接武林榜UID字符串到User-Agent尾部
    NSString *userAgent = [requestSerializer.HTTPRequestHeaders objectForKey:@"User-Agent"];
    userAgent = [userAgent stringByAppendingString:[RCBaseCommon getUIDString]];
    [requestSerializer setValue:userAgent forHTTPHeaderField:@"UserAgent"];

    [requestSerializer setValue:APP_ChannelId forHTTPHeaderField:@"channel"];
    //获取设备唯一标识符 uid
    [requestSerializer setValue:[RCBaseCommon getIdfaString] forHTTPHeaderField:@"deviceNo"];

    //城市
    //FIXME:v2.0
    [requestSerializer setValue:@"" forHTTPHeaderField:@"city"];

    [requestSerializer setValue:HQWYUserManager.sharedInstance.userToken forHTTPHeaderField:@"token"];
    //客户端统一使用小写，服务端不区分大小写
    [requestSerializer setValue:@"hqwyios" forHTTPHeaderField:@"terminalId"];
    [requestSerializer setValue:[RCBaseCommon getBundleIdentifier] forHTTPHeaderField:@"packageName"];

    //移动武林榜接口异常监控请求时间
    [requestSerializer setValue:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forHTTPHeaderField:@"requestTime"];
}

+ (void)ln_setupResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain"]];
}

+ (NSString *)ln_APIServer {
    //FIXME:v2.0
    return LN_BASE_URL;
}

/**
 对请求参数做签名

 @param paramters 需要签名的参数字典
 @return 返回签名后的参数字典
 */
+ (NSDictionary *)ln_signParameters:(NSDictionary *)paramters {

    return paramters;
}

+ (void)ln_receiveResponseObject:(id)responseObject
                            task:(NSURLSessionDataTask *)task
                           error:(NSError *)error
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    if (error) {

        // 断网不发送
        if (error.code != kCFURLErrorNotConnectedToInternet) {
            //发送移动武林榜接口异常监测
            [self sendNetworkError:error ofTask:task];
        }

        if (failure) {
            failure(nil, [NSError hqwy_handleSystemError:error]);
        }
        return;
    }

    NSLog(@"task.currentRequest.URL=======%@", task.currentRequest.URL);

    NSString *respCode = [responseObject objectForKey:kHQWYRespCodeKey];

    if (!respCode || ![respCode isKindOfClass:[NSString class]]
        || [respCode isEqual:[NSNull null]]) {
        if (failure) {
            failure(nil, [NSError hqwy_handleApiDataError]);
        }
        return;
    }

    if ([respCode isEqualToString:@"1000"]) {
        //success
        id body = [responseObject objectForKey:kHQWYBodyKey];
        if (!body) {
            body = nil;
        }
        if (success) {
            success(task, body);
        }
        return;
    }

    //业务异常
    if (failure) {
        NSString *respMsg = [responseObject objectForKey:kHQWYRespMsgKey];
        if (respCode && ![respCode isEqual:[NSNull null]]
            && [respCode isKindOfClass:[NSString class]]
            && [respCode isEqualToString:@"1001"]) {
            //服务端异常，上传移动武林榜接口异常监测
            [self sendNetworkError:nil ofTask:task];
        }
        //这里重新包装Error
        failure(nil, [NSError hqwy_handleLogicError:respMsg respCode:respCode]);
        return;
    }
}

+ (id)ln_parseResponseObject:(id)responseObject {
    if (!responseObject || [responseObject isEqual:[NSNull null]]) {
        return nil;
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        if (self != [NSString class] && self != [NSNumber class]) {
            return [NSArray yy_modelArrayWithClass:self json:responseObject];
        }
    } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = responseObject;
        if (responseDict.allKeys.count > 0) {
            return [self yy_modelWithJSON:responseObject];
        }else{
            return nil;
        }

    } else if ([responseObject isKindOfClass:[NSString class]]) {
        return responseObject;
    }
    return nil;
}

@end
