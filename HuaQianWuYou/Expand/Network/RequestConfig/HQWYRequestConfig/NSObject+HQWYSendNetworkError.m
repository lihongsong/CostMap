//
//  NSObject+LNSendNetworkError.m
//  Loan
//
//  Created by Jacue on 2017/11/3.
//  Copyright © 2017年 2345. All rights reserved.
//

#import "NSObject+HQWYSendNetworkError.h"
#import "HQWYUserManager.h"
#import "NSError+HQWYError.h"
#import <RCMobClick/RCNetworkError.h>
#import <RCMobClick/RCMobClick.h>

@implementation NSObject (HQWYSendNetworkError)


+ (NSDictionary *)mapInterfaceFunctions {
    return @{
             //FIXME:v2.0
             /*
             LN_SMS_DYNAMICCODE : @"getDynamicCode",                // 获取验证码
             LN_TOKEN_PASSWORD : @"loginByPassword",                // 密码登录
             LN_TOKEN_DYNCODE : @"loginByCode",                     // 验证码登录
             IL_POST_USER_AUDIT_STATUS : @"getUserStatus",          // 获取用户状态
              */
             };
}


+ (void)sendNetworkError:(NSError *)error ofObject:(id)object{
    NSString *requestTime = @"";
    __block NSString *failingURLString = @"";
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)object;
          requestTime = [NSString stringWithFormat:@"%@", dic[@"timestamp"]];//13位毫秒级时间戳
        failingURLString = dic[@"path"];
    }else if ([object isKindOfClass:[NSURLSessionDataTask class]]){
        NSURLSessionDataTask *task = (NSURLSessionDataTask *)object;
        NSDictionary *allHeader = task.currentRequest.allHTTPHeaderFields;
        requestTime = allHeader[@"requestTime"];//10位秒级时间戳
        failingURLString = task.currentRequest.URL.absoluteString;
    }
    NSTimeInterval duration = 0;
    if ([requestTime length] == 13) {//统一毫秒计算结果
        duration = [[NSDate date] timeIntervalSince1970] * 1000.0 - requestTime.doubleValue;
    }else{
        duration = ([[NSDate date] timeIntervalSince1970] - requestTime.doubleValue) * 1000.0;
    }
    NSTimeInterval interval    =[requestTime doubleValue] / 1000.0;
    NSDate *datesss = [NSDate dateWithTimeIntervalSince1970:interval];
    NSLog(@"_____%@",datesss);
    NSLog(@"___%@",[NSDate date]);
    NSLog(@"_____%f",duration/1000.0);
    NSDate *datenow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSInteger intervalsss = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: intervalsss];
    NSLog(@"_____%@",localeDate);
    if (!failingURLString) {
        NSURL *failedURL = error.userInfo[@"NSErrorFailingURLKey"];
        if (failedURL && [failedURL isKindOfClass:[NSURL class]]) {
            failingURLString = failedURL.absoluteString;
        }
    }
    RCNetworkError *networkerror = [[RCNetworkError alloc] init];
    
    //FIXME:v2.0 手机号获取
    networkerror.mobile = [HQWYUserManager loginMobilePhone];
    //此处pid传空值
//    networkerror.pid = @"";
//    networkerror.userId = @"";

    networkerror.responseTime = [NSString stringWithFormat:@"%.0f",duration];
    if (failingURLString) {
        networkerror.requestUrl = [failingURLString stringByReplacingOccurrencesOfString:@"api/" withString:@"/"];
        networkerror.requestUrlFunction = failingURLString.lastPathComponent;
    }
    
    networkerror.errorType = [self errorTypeOf:error];
 
    if (error) {
        NSMutableString *pinyin = [error.localizedDescription mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
 
        if ([pinyin uppercaseString].length >= 100) {
            networkerror.errorContent = [[pinyin lowercaseString] substringToIndex:99];
        }else{
            networkerror.errorContent = [pinyin lowercaseString];
        }
    }else{
        networkerror.errorContent = HQWYSystemErrorDomain;
    }
 
    [RCMobClick reportError:networkerror];
}

+ (void)sendNetworkErrorDic:(NSDictionary *)errorDic{
    RCNetworkError *networkerror = [[RCNetworkError alloc] init];
    networkerror.mobile = errorDic[@"mobile"];
    networkerror.responseTime = errorDic[@"responseTime"];
    networkerror.requestUrl = errorDic[@"requestUrl"];
    networkerror.requestUrlFunction = errorDic[@"requestUrlFunction"];
    networkerror.errorType = [errorDic[@"errorType"] integerValue];
    networkerror.errorContent = errorDic[@"errorContent"];
    [RCMobClick reportError:networkerror];
}

+ (RCNetworkErrorType)errorTypeOf:(NSError *)error {
 
    //如果为nil，表示是服务器系统异常
    if (!error) {
        return RCNetworkErrorTypeServer;
    }
    
    if (error.code == kCFURLErrorTimedOut) {   //请求超时
        return RCNetworkErrorTypeTimeOut;
    }else if (error.code < 0){   //其他环境异常
        return RCNetworkErrorTypeEnvironment;
    }
    return RCNetworkErrorTypeHttpCode;   //http请求错误
}
@end
