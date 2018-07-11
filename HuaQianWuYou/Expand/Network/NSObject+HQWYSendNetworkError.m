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
             /*
             LN_SMS_DYNAMICCODE : @"getDynamicCode",                // 获取验证码
             LN_TOKEN_PASSWORD : @"loginByPassword",                // 密码登录
             LN_TOKEN_DYNCODE : @"loginByCode",                     // 验证码登录
             IL_POST_USER_AUDIT_STATUS : @"getUserStatus",          // 获取用户状态
              */
             };
}


+ (void)sendNetworkError:(NSError *)error ofTask:(NSURLSessionDataTask *)task{
 
    NSDictionary *allHeader = task.currentRequest.allHTTPHeaderFields;
    NSString *requestTime = allHeader[@"requestTime"];
    NSTimeInterval duration = ([[NSDate date] timeIntervalSince1970] - requestTime.doubleValue) * 1000.0;
 
    __block NSString *failingURLString = task.currentRequest.URL.absoluteString;
    if (!failingURLString) {
        NSURL *failedURL = error.userInfo[@"NSErrorFailingURLKey"];
        if (failedURL && [failedURL isKindOfClass:[NSURL class]]) {
            failingURLString = failedURL.absoluteString;
        }
    }

    __block BOOL shouldReport = NO;
 
    NSArray *urls = [self mapInterfaceFunctions].allKeys;
    [urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([failingURLString rangeOfString:obj].location != NSNotFound){
            shouldReport = YES;
            failingURLString = obj;
            *stop = YES;
        }
    }];
 
    if (!shouldReport) {
        return;
    }
 
    RCNetworkError *networkerror = [[RCNetworkError alloc] init];
        NSString *userId = [[HQWYUserManager sharedInstance].userInfo.userId stringValue];
        networkerror.userId = [HQWYUserManager sharedInstance].userInfo.userId ? userId :@"";
        networkerror.mobile = [HQWYUserManager sharedInstance].userInfo.mobilephone;
 
   // networkerror.pid = [@(LNProductIDHQWYDSZD) stringValue];
    
    networkerror.responseTime = [NSString stringWithFormat:@"%.0f",duration];
    networkerror.requestUrl = [failingURLString stringByReplacingOccurrencesOfString:@"api/" withString:@"/"];
    networkerror.requestUrlFunction = [self mapInterfaceFunctions][failingURLString];
 
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
