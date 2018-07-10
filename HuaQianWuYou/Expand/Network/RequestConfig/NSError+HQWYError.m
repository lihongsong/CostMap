//
//  NSError+HQWYError.m
//  HQWYNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年  terrywang. All rights reserved.
//

#import "NSError+HQWYError.h"
#define kToastMessageLength 20
static NSString *const kHQWYErrorCodeKey      = @"code";
static NSString *const kHQWYErrorMessageKey   = @"message";

@implementation NSError (HQWYError)

// 业务error集合,key为返回错误信息的code，value为判定该错误信息后需发送的通知
- (NSDictionary *)logicErrorCollection {
    
    NSArray *keys = @[
                      kHQWYTokenInvalidateCode,
                      kHQWYForceUpdateCode,
                      kHQWYAnquanxinxiCode,
                      kHQWYjiekuanCode
                      ];
    NSArray *objects = @[
                         KHQWYNotificationTokenInvalidate,
                         KHQWYNotificationForceUpdate,
                         KHQWYNotificationImageCodeError,
                         KHQWYNotificationJiekuan_1000
                         ];
    
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}


- (NSString *)HQWY_errorMessage {
    if (!self) {
        return nil;
    }

    NSString *message = nil;
    
    if ([self HQWY_isSystemError]) {
        if ([self HQWY_isNetworkIssueError]) {
            //网络错误
            message = HQWYSystemErrorMessageNetworkIssueMessage;
        } else if ([self HQWY_isRequestCancelled]) {
            //请求取消，不toast
            message = nil;
        } else {
            //其他http异常(包括服务端返回数据异常)
            message = HQWYSystemErrorMessageUnkownErrorMessage;
        }
    }else {
        if ([self HQWY_isAPIDataError]) {
            message = HQWYSystemErrorMessageWrongApiDataMessage;
        }

        if ([self HQWY_isLogicError]) {
            message = [self HQWY_parseLogicErrorMessage];
        }
    }

    //异常信息大于20个字符，使用alert弹窗显示
    if ([message length] > kToastMessageLength) {
        [self HQWY_showErrorAlert:message];
        return nil;
    }
    return message;
}

- (NSString *)HQWY_errorUrlString {
    NSString *urlString = self.userInfo[@"url"];
    if (!urlString || [[urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return nil;
    }
    return urlString;
}

- (NSString *)HQWY_codeString {
    return self.userInfo[@"errCode"];
}

- (void)HQWY_showErrorAlert:(NSString *)message {
    if (message) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        } title:@"" message:message cancelButtonName:@"确定" otherButtonTitles:nil, nil];

    }
}

- (BOOL)HQWY_isSystemError {
    return [self.domain isEqualToString:HQWYSystemErrorDomain];
}
    
- (BOOL)HQWY_isLogicError {
    return [self.domain isEqualToString:HQWYLogicErrorDomain];
}

- (BOOL)HQWY_isAPIDataError {
    return [self.domain isEqualToString:HQWYAPIDataErrorDomain];
}

- (BOOL)HQWY_isRequestCancelled {
    return ([self.userInfo[@"errCode"] integerValue] == NSURLErrorCancelled);
}


- (BOOL)HQWY_isNetworkIssueError {
    return ([self.userInfo[@"errCode"] integerValue] == NSURLErrorNotConnectedToInternet);
}

- (NSString *)HQWY_parseLogicErrorMessage {

    NSLog(@"HQWY_handleLogicError error %@", self.userInfo);
    if (!self.userInfo || !self.userInfo[@"message"]) {
        return HQWYSystemErrorMessageUnkownErrorMessage;
    }

    if (!self.userInfo
        || !self.userInfo[@"message"]
        || [self.userInfo[@"message"] isEqual:[NSNull null]]) {
        return HQWYSystemErrorMessageUnkownErrorMessage;
    }

    if (!self.userInfo[@"errCode"]
        || [self.userInfo[@"errCode"] isKindOfClass:[NSNull class]]
        || [self.userInfo[@"errCode"] isEqual:[NSNull null]]) {
        return self.userInfo[@"message"];
    }

    NSString *code = [self detectLogicErrorFrom:self.userInfo];

    // token失效、强制升级、借款失败（信用不足）
    if ([code isEqualToString:kHQWYTokenInvalidateCode] ||
        [code isEqualToString:kHQWYForceUpdateCode] ||
        [code isEqualToString:kHQWYjiekuanCode]) {
        return nil;
    }
    // 验证码、服务费（显示过期）无效
    if ([code isEqualToString:kHQWYAnquanxinxiCode]) {
        return self.userInfo[@"message"];
    }
    return self.userInfo[@"message"];
}

//处理系统错误，如网络异常
//注意：message为实际的错误信息，方便开发调试。当showError时，会再做一次过滤，用户看到的是过滤后的消息。

+ (NSError *)HQWY_handleLogicError:(NSDictionary *)error code:(NSString *)code {
    return [self HQWY_errorWithDomain:HQWYLogicErrorDomain codeString:code errorInfo:error];
}

+ (NSError *)HQWY_handleSystemError:(NSError *)error {
    NSLog(@"%@", error.description);
    return [self HQWY_errorWithDomain:HQWYSystemErrorDomain codeString:[NSString stringWithFormat:@"%zd", error.code] errorInfo:@{kHQWYErrorMessageKey : [error localizedDescription]}];
}

//处理API数据错误，如：返回的result对象类型错误
+ (NSError *)HQWY_handleApiDataError {
#if DEBUG
    NSAssert(NO, @"数据类型不匹配，请检查！");
    return [self HQWY_errorWithDomain:HQWYAPIDataErrorDomain codeString:[NSString stringWithFormat:@"%zd", HQWYSystemErrorWrongApiData] errorInfo:@{kHQWYErrorMessageKey : HQWYSystemErrorMessageWrongApiDataMessage}];
#endif
    return [self HQWY_errorWithDomain:HQWYAPIDataErrorDomain codeString:[NSString stringWithFormat:@"%zd", HQWYSystemErrorWrongApiData] errorInfo:@{kHQWYErrorMessageKey : HQWYSystemErrorMessageWrongApiDataMessage}];
}

/**
 接口异常，例如数据格式错误
 
 @return 返回重新封装的 error
 */
+ (NSError *)HQWY_handleApiNetError {
    return [self HQWY_errorWithDomain:HQWYAPIDataErrorDomain codeString:[NSString stringWithFormat:@"%zd", HQWYSystemErrorNetworkIssue] errorInfo:@{kHQWYErrorMessageKey : HQWYSystemErrorMessageUnkownErrorMessage}];
}

//封装error信息到error对象，返回error
//+ (NSError *)HQWY_errorWithDomain:(NSString *)errorDomain
//                     codeString:(NSString *)codeString
//                        message:(id)message //注意这里为了兼容强制升级的老接口，可能是字典类型
//                      urlString:(NSString *)urlString {
//    if (!message) {
//        return nil;
//    }
//
//    NSError *aError = nil;
//
//    if ([errorDomain isEqualToString:HQWYSystemErrorDomain]) {
//        NSLog(@"HQWYSystemErrorDomain -- message is [%@]", message);
//        NSDictionary *userInfo = @{@"errCode" : codeString, @"message" : message};
//        aError = [NSError errorWithDomain:HQWYSystemErrorDomain code:[codeString integerValue] userInfo:userInfo];
//    } else if ([errorDomain isEqualToString:HQWYLogicErrorDomain]) {
//        //将错误信息封装到error 中，抛到上层
//        NSDictionary *userInfo = @{@"errCode" : codeString, @"message" : message, @"url" : urlString ? urlString : @""};
//        aError = [NSError errorWithDomain:HQWYLogicErrorDomain code:HQWYSystemErrorUnknownError userInfo:userInfo];
//    }
//    return aError;
//}


//封装error信息到error对象，返回error
+ (NSError *)HQWY_errorWithDomain:(NSString *)errorDomain
                     codeString:(NSString *)codeString
                      errorInfo:(NSDictionary *)errorInfo {
    
    NSError *aError = nil;
    
    if ([errorDomain isEqualToString:HQWYSystemErrorDomain]) {
        NSLog(@"HQWYSystemErrorDomain -- message is [%@]", errorInfo[kHQWYErrorMessageKey]);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:errorInfo];
        // 兼容老系统的errCode
        [dic setValue:codeString forKey:@"errCode"];
        aError = [NSError errorWithDomain:HQWYSystemErrorDomain code:[codeString integerValue] userInfo:dic];
    } else if ([errorDomain isEqualToString:HQWYAPIDataErrorDomain]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:errorInfo];
        // 兼容老系统的errCode
        [dic setValue:codeString forKey:@"errCode"];
        aError = [NSError errorWithDomain:errorDomain code:HQWYSystemErrorWrongApiData userInfo:dic];
    }  else if ([errorDomain isEqualToString:HQWYLogicErrorDomain]) {
        //将错误信息封装到error 中，抛到上层
        NSMutableDictionary *aErrorInfo = [NSMutableDictionary dictionary];
        // 设置code
        [aErrorInfo setValue:codeString forKey:kHQWYErrorCodeKey];
        // 兼容老接口errCode
        [aErrorInfo setValue:codeString forKey:@"errCode"];
        [errorInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (key) {
                [aErrorInfo setValue:obj forKey:key];
            }
        }];
        aError = [NSError errorWithDomain:HQWYLogicErrorDomain code:HQWYSystemErrorUnknownError userInfo:aErrorInfo];
    }
    return aError;
}


/**
 判断是否包含特定的错误

 @param dictionary （待解析的）错误信息
 @return 错误信息的code
 */
- (NSString *)detectLogicErrorFrom:(NSDictionary *)dictionary {
    
    NSDictionary *logicErrors = [self logicErrorCollection];
    if ([logicErrors.allKeys containsObject:dictionary[@"errCode"]]) {
        NSString *key = dictionary[@"errCode"];
        NSString *notificationName = logicErrors[key];
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:dictionary];
        return key;
    }
    
    return nil;
}
@end
