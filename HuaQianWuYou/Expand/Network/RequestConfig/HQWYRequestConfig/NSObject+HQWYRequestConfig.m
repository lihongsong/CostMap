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
#import "NSObject+YYModel.h"
#import "LoginInfoModel.h"
#import "NSError+CustomError.h"

#define CONFIG_SCORE @"88"

static NSString *const kHQWYRespCodeKey     = @"respCode";
static NSString *const kHQWYRespMsgKey      = @"respMsg";
static NSString *const kHQWYBodyKey         = @"body";

@implementation NSObject (HQWYRequestConfig)


+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    //超时时间
    requestSerializer.timeoutInterval = 20;
    if ([GetUserDefault(KExample_Credit_Score) isEqualToString:CONFIG_SCORE]) {
        [self setupRequestSerializer:requestSerializer];
    }else{
        [self setRequestSerializer:requestSerializer];
    }
}

//1.0公共请求头
+ (void)setRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
    NSString *cookieString = userInfo?userInfo.cookie:@"";
    NSString *version = [UIDevice hj_appVersion];
    NSString *buddleId = [UIDevice hj_bundleIdentifier];
    [requestSerializer setValue:version forHTTPHeaderField:@"version"];
    [requestSerializer setValue:APP_ChannelId forHTTPHeaderField:@"channel"];
    [requestSerializer setValue:APP_ID forHTTPHeaderField:@"appid"];
    [requestSerializer setValue:buddleId forHTTPHeaderField:@"package-name"];
    [requestSerializer setValue:cookieString forHTTPHeaderField:@"cookie"];
}

//2.0公共请求头
+ (void)setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    //FIXME:v2.0 请求头参数设置
    //客户端统一使用小写，服务端不区分大小写
    [requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];

    [requestSerializer setValue:[RCBaseCommon getAppReleaseVersionString] forHTTPHeaderField:@"version"];

    //屏*蔽*产*品
    NSString *productHidden = GetUserDefault(KProductHidden);
    if (StrIsEmpty(productHidden)) {
        productHidden = @"N";
    }
    [requestSerializer setValue:productHidden forHTTPHeaderField:@"productHidden"];
    
    //拼接武林榜UID字符串到User-Agent尾部
    NSString *userAgent = [requestSerializer.HTTPRequestHeaders objectForKey:@"User-Agent"];
    userAgent = [userAgent stringByAppendingString:[RCBaseCommon getUIDString]];
    [requestSerializer setValue:userAgent forHTTPHeaderField:@"UserAgent"];

    [requestSerializer setValue:APP_ChannelId forHTTPHeaderField:@"channel"];
    //获取设备唯一标识符 uid
    //[RCBaseCommon getIdfaString]
    [requestSerializer setValue:[RCBaseCommon getIdfaString] forHTTPHeaderField:@"deviceNo"];

    //城市
    //FIXME:v2.0
    [requestSerializer setValue:GetUserDefault(@"locationCity") forHTTPHeaderField:@"city"];

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
    if ([GetUserDefault(KExample_Credit_Score) isEqualToString:CONFIG_SCORE]) {
        return HQWY_PRODUCT_PATH;
    }
    return HOST_PATH;
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
    //NSLog(@"______%ld",(long)error.code);
    //NSLog(@"____%@",error.description);
    
    if ([GetUserDefault(KExample_Credit_Score) isEqualToString:CONFIG_SCORE]) {
        [self ln_receiveV2ResponseObject:responseObject task:task error:error success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure];
    }else{
        [self ln_receiveConfigResponseObject:responseObject task:task error:error success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure];
    }
}

#pragma mark 解析
+ (void)ln_receiveConfigResponseObject:(id)responseObject
                            task:(NSURLSessionDataTask *)task
                           error:(NSError *)error
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (error) {
        if (failure) {
            NSError *customError = [NSError custom_systemErrorCodeString:error.code];
                failure(task, customError);
        }
        return;
    }
    NSString *code = [[responseObject objectForKey:@"code"] stringValue];
    if (code && [code isEqualToString:@"1"]) {
        if (success) {
            id response = responseObject[@"data"];
            if (response == nil) {
                response = responseObject;
            }
            success(task, [self ln_parseResponseObject:response]);
        }
        return;
    } else {
        NSError *customError = [NSError custom_errorWithDomain:CustomErrorDomain
                                                    codeString:code
                                                     errorInfo:responseObject];
        if (failure) {
            failure(task, customError);
        }
        
    }
}

#pragma mark 2.0 解析
+ (void)ln_receiveV2ResponseObject:(id)responseObject
                                  task:(NSURLSessionDataTask *)task
                                 error:(NSError *)error
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
   
    if (error) {
        
        // 断网不发送
        if (error.code != kCFURLErrorNotConnectedToInternet) {
            //发送移动武林榜接口异常监测
             NSLog(@"11111111___%@",responseObject);
            if (task != nil) {
                [self sendNetworkError:error ofObject:task];
            }else{
                [self sendNetworkError:error ofObject:responseObject];
            }
        }
        
        if (failure) {
            failure(nil, [NSError hqwy_handleSystemError:error]);
        }
        return;
    }
    
   // NSLog(@"task.currentRequest.URL=======%@", task.currentRequest.URL);
    
    NSString *respCode = [responseObject objectForKey:kHQWYRespCodeKey];
    NSLog(@"____%@",respCode);
    if (!respCode || ![respCode isKindOfClass:[NSString class]]
        || [respCode isEqual:[NSNull null]]) {
        if (failure) {
            failure(nil, [NSError hqwy_handleApiDataError]);
        }
        return;
    }
    
    if (respCode.integerValue == HQWYRESPONSECODE_SUCC) {
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
    
    NSString *respMsg = [responseObject objectForKey:kHQWYRespMsgKey];
    if (respCode && ![respCode isEqual:[NSNull null]]
        && [respCode isKindOfClass:[NSString class]]
        && respCode.integerValue == HQWYRESPONSECODE_FAIL) {
        //服务端异常，上传移动武林榜接口异常监测
        if (task != nil) {
            [self sendNetworkError:error ofObject:task];
        }else{
            [self sendNetworkError:error ofObject:responseObject];
        }
    }
    
    //业务异常
    if (failure) {
        //这里重新包装Error
        failure(nil, [NSError hqwy_handleLogicError:respMsg respCode:respCode]);
    }
    return;
}

+ (id)ln_parseResponseObject:(id)responseObject {
    if (!responseObject || [responseObject isEqual:[NSNull null]]) {
        return nil;
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        if (self != [NSString class] && self != [NSNumber class]) {
            return [NSArray yy_modelArrayWithClass:self json:responseObject];
        }else{
            return nil;
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
    return responseObject;
    
}

@end
