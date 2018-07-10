//
//  NSObject+LNSendNetworkError.m
//  Loan
//
//  Created by Jacue on 2017/11/3.
//  Copyright © 2017年 2345. All rights reserved.
//

#import "NSObject+LNSendNetworkError.h"
#import <RCMobClick/RCNetworkError.h>
#import <RCMobClick/RCMobClick.h>

@implementation NSObject (LNSendNetworkError)
/* TODO:这里需要的时候再打开
+ (NSDictionary *)mapInterfaceFunctions {
    return @{
             LN_POST_GET_ISREGISTERED : @"isRegister",  // 点击下一步
             LN_POST_GET_LOGIN_CODE : @"signInGetCode", // 获取验证啊吗
             LN_POST_GET_BORROWPASSWORDCHECK_PATH : @"borrowGetCode", // 借款获取验证码
             LN_POST_GET_BOCCODE_SHB_PATH : @"addBankGetCode", //
             LN_POST_LOGIN_PATH : @"signInOld",
             LN_POST_LOGIN_WITH_CODE : @"signInNew",

             LN_POST_RETRIEVEUSER_PATH : @"getUserInfo",
             LN_POST_AUTH_PATH : @"openAccount",
             LN_POST_BORROW_PROTOCOL_PATH : @"getProtocol",
             LN_POST_BORROW_PATH : @"borrow",
             LN_POST_BORROW_SHB_PATH : @"borrow",
             LN_POST_BORROW_PLUS_PATH : @"borrow",

             LN_POST_REPAYMENT_PATH : @"repay",
             LN_POST_REPAYMENT_SHB_PATH : @"repay",
             LN_POST_REPAYMENT_QUERY_PATH : @"repayQuery",
             LN_POST_REPAYMENT_QUERY_SHB_PATH : @"repayQuery",
             LN_POST_ARREAR_QUERY_SHB_PATH : @"repayQuery",
             
             LN_POST_BORROW_QUERY_PATH : @"borrowQuery",
             LN_POST_BORROW_QUERY_SHB_PATH : @"borrowQuery",
             LN_POST_NEEDPAYORDER_PATH : @"wxGetAmount",
             LN_PREORDER_ACTION_PATCH : @"wxCreateOrder",
             LN_POST_UPLOAD_IDCARD_INFO : @"addRealName",
             
             LN_BIND_DEBIT_CARD_PATH : @"addBank",
             LN_POST_USER_BASIC_INFO : @"addBasicInfo",
             LN_POST_USER_BASIC_CONTACTS : @"addBasicContacts",
             LN_POST_UPLOAD_MEDIA : @"addMedia",
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
    
    networkerror.userId = [LNUserManager sharedInstance].userInfo.userId.stringValue ?:@"";
    networkerror.pid = [LNUserManager sharedInstance].userInfo ? [NSString stringWithFormat:@"%zd", [LNUserManager sharedInstance].userInfo.productId] : @"";
    networkerror.mobile = [LNUserManager sharedInstance].userInfo.mobilephone ?:@"";
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
        networkerror.errorContent = @"syserror_0001";
    }
    
    [RCMobClick reportError:networkerror];
}

+ (RCNetworkErrorType)errorTypeOf:(NSError *)error {
    
    // 如果为nil，表示是服务器系统异常
    if (!error) {
        return RCNetworkErrorTypeServer;
    }
    if (error.code == -1001) {  // 请求超时
        return RCNetworkErrorTypeTimeOut;
    }else if (error.code < 0){  // 其他环境异常
        return RCNetworkErrorTypeEnvironment;
    }
    return RCNetworkErrorTypeHttpCode;  // http请求错误
}
*/
@end
