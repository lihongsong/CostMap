////
////  NSObject+LNRequest.m
////  LNNetwork
////
////  Created by terrywang on 2017/6/29.
////  Copyright © 2017年 terrywang. All rights reserved.
////
//
//#import "NSObject+LNRequestConfig.h"
//#import "NSError+LNError.h"
//#import "NSError+HQWYError.h"
//#import "YYModel.h"
//#import <RCMobClick/RCMobClick.h>
//#import <RCMobClick/RCBaseCommon.h>
//#import "DeviceHelp.h"
////#import "HQWYToolManager.h"
//#import "HQWYUserManager.h"
//#import "HQWYUserStatusManager.h"
//
//#import "NSObject+LNSendNetworkError.h"
//
////-------VIP--------BEGIN
//static NSString *const kHQWYCodeKey   = @"code";
//static NSString *const kHQWYErrorKey  = @"error";
//static NSString *const kHQWYResultKey = @"result";
////-------VIP--------END
//
//#pragma mark - 接口验证用户名密码
//#define BaseAuthenticationUserName  @"suixindai"
//#define BaseAuthenticationPassword  @"1qaz!@#$"
//
//@implementation NSObject (LNRequest)
//
//+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
//
//    requestSerializer.timeoutInterval = 20;
//    [requestSerializer setAuthorizationHeaderFieldWithUsername:BaseAuthenticationUserName
//                                                      password:BaseAuthenticationPassword];
//
//    [self setupRequestSerializer:requestSerializer];
//}
//
//+ (void)setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
//    [requestSerializer setValue:[RCBaseCommon getUIDString] forHTTPHeaderField:@"X-DeviceToken"];
//    [requestSerializer setValue:[RCBaseCommon getIdfaString] forHTTPHeaderField:@"X-Idfa"];
//    [requestSerializer setValue:[DeviceHelp getIPAddress:YES] forHTTPHeaderField:@"X-Ip"];
//    [requestSerializer setValue:@"iOS" forHTTPHeaderField:@"os"];
//    [requestSerializer setValue:[RCBaseCommon getAppReleaseVersionString] forHTTPHeaderField:@"version"];
//    //拼接武林榜UID字符串到User-Agent尾部
//    NSString *userAgent = [requestSerializer.HTTPRequestHeaders objectForKey:@"User-Agent"];
//    userAgent = [userAgent stringByAppendingString:[RCBaseCommon getUIDString]];
//    [requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
//    //注：正式版V5.7.0（马甲版5.6.0 & 5.6.2） 在所有请求header中新增【app-bundle-id】字段，用来区分正式版和马甲版。对应的是项目的bundle ID
//    [requestSerializer setValue:[RCBaseCommon getBundleIdentifier] forHTTPHeaderField:@"app-bundle-id"];
//    [requestSerializer setValue:[RCBaseCommon getBundleIdentifier] forHTTPHeaderField:@"bundleId"];
//    
//    [requestSerializer setValue:[HQWYToolManager sharedInstance].deviceNo forHTTPHeaderField:@"X-DeviceNo"];
//    [requestSerializer setValue:[HQWYUserManager sharedInstance].userToken forHTTPHeaderField:@"X-Token"];
//    //当用户信息为空，productID传-1
////    [requestSerializer setValue:[HQWYUserManager sharedInstance].userInfo ? [NSString stringWithFormat:@"%zd", [HQWYUserManager sharedInstance].userInfo.productId] : @"-1"  forHTTPHeaderField:@"productId"];
//    
//    [requestSerializer setValue:[NSString stringWithFormat:@"%ld", (long)LNProductIDJKDSZD]  forHTTPHeaderField:@"productId"];
//    [requestSerializer setValue:AppChannel forHTTPHeaderField:@"channel"];
//
//    //-------VIP--------BEGIN
//    //vip 设置请求头
//    [requestSerializer setValue:[RCBaseCommon getIdfaString] forHTTPHeaderField:@"uid"];
//    [requestSerializer setValue:@"2" forHTTPHeaderField:@"terminalId"];
//    [requestSerializer setValue:HQWYUserStatusSharedManager.token forHTTPHeaderField:@"token"];
//    //产品id 写死立即贷的产品id 是 10002
//    [requestSerializer setValue:[NSString stringWithFormat:@"%ld", (long)LNProductIDJKDSZD] forHTTPHeaderField:@"pid"];
//     [requestSerializer setValue:@"2" forHTTPHeaderField:@"groupId"];
//    
//    //-------VIP--------END
//    //fix bug wyg 移动武林榜接口异常监控请求时间
//    [requestSerializer setValue:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forHTTPHeaderField:@"requestTime"];
//    
//    // V8.0 新增
//    [requestSerializer setValue:[UIDevice hj_manufacture] forHTTPHeaderField:@"operators"];
//    [requestSerializer setValue:@"apple" forHTTPHeaderField:@"manufacture"];
//}
//
//+ (void)ln_setupResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
//    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain"]];
//}
//
//+ (NSString *)ln_APIServer {
//    return LN_BASE_URL;
//}
//
///**
// 对请求参数做签名
// 
// @param paramters 需要签名的参数字典
// @return 返回签名后的参数字典
// */
//+ (NSDictionary *)ln_signParameters:(NSDictionary *)paramters {
//    
//    return paramters;
//}
//
//+ (void)ln_receiveResponseObject:(id)responseObject
//                            task:(NSURLSessionDataTask *)task
//                           error:(NSError *)error
//                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
//
//    if (error) {
//        
//        // 断网不发送
//        if (error.code != kCFURLErrorNotConnectedToInternet) {
//            [self sendNetworkError:error ofTask:task];
//        }
//        
//        if (failure) {
//            //-------VIP--------BEGIN
//            failure(nil, [NSError HQWY_handleSystemError:error]);
//            //-------VIP--------END
//        }
//        return;
//    }
//
//    NSLog(@"task.currentRequest.URL=======%@", task.currentRequest.URL);
//
//    NSString *code = [responseObject objectForKey:kHQWYCodeKey];
//    if (code && [code isEqualToString:@"success"]) {
//        //success
//        id result = [responseObject objectForKey:kHQWYResultKey];
//        if (!result) {
//            result = nil;
//        }
//        if (success) {
//            success(task, result);
//        }
//        return;
//    }
//
//    //-------VIP--------BEGIN
//    id aError = [responseObject objectForKey:kHQWYErrorKey];
//    if (aError && ![aError isEqual:[NSNull null]]) {
//        if ([aError isKindOfClass:[NSDictionary class]]) {
//            
//            // 断网不发送
//            if (error.code != kCFURLErrorNotConnectedToInternet) {
//                
//                
//                if ([code isKindOfClass:[NSString class]]
//                    && [error.domain isEqualToString:HQWYSystemErrorDomain]
//                    ){
//                    [self sendNetworkError:nil ofTask:task];
//                }
//            }
//            
//            if (failure) {
//                //这里重新包装LNError
//                //code 为空，则代表是老接口格式，否则是新接口格式
//                failure(nil, code ? [NSError HQWY_handleLogicError:aError code:code] : [NSError ln_handleLogicError:aError]);
//            }
//        } else {
//            if (failure) {
//                failure(nil, code ? [NSError HQWY_handleApiDataError] : [NSError ln_handleApiDataError]);
//            }
//        }
//        return;
//    }
//    //-------VIP--------END
//
//    id result = [responseObject objectForKey:kHQWYResultKey];
//
//    if (!result || [result isEqual:[NSNull null]]) {
//        result = nil;
//    }
//    if (success) {
//        success(task, result);
//    }
//}
//
//+ (id)ln_parseResponseObject:(id)responseObject {
//    if (!responseObject || [responseObject isEqual:[NSNull null]]) {
//        return nil;
//    } else if ([responseObject isKindOfClass:[NSArray class]]) {
//        if (self != [NSString class] && self != [NSNumber class]) {
//            return [NSArray yy_modelArrayWithClass:self json:responseObject];
//        }
//    } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *responseDict = responseObject;
//        if (responseDict.allKeys.count > 0) {
//            return [self yy_modelWithJSON:responseObject];
//        }else{
//            return nil;
//        }
//        
//    } else if ([responseObject isKindOfClass:[NSString class]]) {
//        return responseObject;
//    }
//    return nil;
//}
//
//@end
