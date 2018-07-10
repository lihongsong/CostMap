//
//  NSError+LNError.m
//  LNNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "NSError+LNError.h"

@implementation NSError (LNError)

- (NSString *)ln_errorMessage {
    if (!self) {
        return nil;
    }
    
    NSString *message = nil;
    
    if ([self ln_isSystemError]) {
        if ([self ln_isNetworkIssueError]) {
            //网络错误
            message = LNSystemErrorMessageNetworkIssueMessage;
        } else if ([self ln_isRequestCancelled]) {
            //请求取消，不toast
            message = nil;
        } else {
            //其他http异常(包括服务端返回数据异常)
            message = LNSystemErrorMessageUnkownErrorMessage;
        }
    }else {
        if ([self ln_isAPIDataError]) {
            message = LNSystemErrorMessageWrongApiDataMessage;
        }
        
        if ([self ln_isLogicError]) {
            message = [self ln_parseLogicErrorMessage];
        }
    }
    
    //异常信息大于20个字符，使用alert弹窗显示
    if ([message length] > 20) {
        [self ln_showErrorAlert:message];
        return nil;
    }
    return message;
}

- (void)ln_showErrorAlert:(NSString *)message {
    if (message) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        } title:@"" message:message cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    }
}

- (BOOL)ln_isSystemError {
    return [self.domain isEqualToString:LNSystemErrorDomain];
}

- (BOOL)ln_isLogicError {
    return [self.domain isEqualToString:LNLogicErrorDomain];
}

- (BOOL)ln_isAPIDataError {
    return [self.domain isEqualToString:LNAPIDataErrorDomain];
}

- (BOOL)ln_isRequestCancelled {
    return ([self.userInfo[@"errCode"] integerValue] == NSURLErrorCancelled);
}


- (BOOL)ln_isNetworkIssueError {
    return ([self.userInfo[@"errCode"] integerValue] == NSURLErrorNotConnectedToInternet);
}

- (NSString *)ln_parseLogicErrorMessage {
    
    NSLog(@"ln_handleLogicError error %@", self.userInfo);
    if (!self.userInfo || !self.userInfo[@"message"]) {
        return LNSystemErrorMessageUnkownErrorMessage;
    }
    
    if (!self.userInfo
        || !self.userInfo[@"message"]
        || [self.userInfo[@"message"] isEqual:[NSNull null]]) {
        return LNSystemErrorMessageUnkownErrorMessage;
    }
    
    if (!self.userInfo[@"errCode"] || [self.userInfo[@"errCode"] isKindOfClass:[NSNull class]] || [self.userInfo[@"errCode"] isEqual:[NSNull null]]) {
        return self.userInfo[@"message"];
    }
    //处理token失效
    if ([self ln_handleInvalidateToken:self.userInfo]) {
        return nil;
    }
    
    //处理强制升级
    if ([self ln_handleForceUpdate:self.userInfo]) {
        return nil;
    }
    
    //anquanxinxi_0034
    if ([self ln_handleImageCodeError:self.userInfo]) {
        return self.userInfo[@"message"];
    }
    
    if ([self ln_handleJiekuan1000:self.userInfo]) {
        return nil;
    }
    
    //当message 不是NSString类型时，直接返回
    if (![self.userInfo[@"message"] isKindOfClass:[NSString class]]) {
        return LNSystemErrorMessageUnkownErrorMessage;
    }
    
    return self.userInfo[@"message"];
}

//处理系统错误，如网络异常
//注意：message为实际的错误信息，方便开发调试。当showError时，会再做一次过滤，用户看到的是过滤后的消息。

+ (NSError *)ln_handleLogicError:(NSDictionary *)error {
    return [self ln_errorWithDomain:LNLogicErrorDomain
                         codeString:error[@"errCode"]
                            message:error[@"message"]];
}

+ (NSError *)ln_handleSystemError:(NSError *)error {
    NSLog(@"%@", error.description);
    return [self ln_errorWithDomain:LNSystemErrorDomain
                         codeString:[NSString stringWithFormat:@"%zd", error.code]
                            message:[error localizedDescription]];
}

//处理API数据错误，如：返回的result对象类型错误
+ (NSError *)ln_handleApiDataError {
#if DEBUG
    NSAssert(NO, @"数据类型不匹配，请检查！");
    return [self ln_errorWithDomain:LNAPIDataErrorDomain
                         codeString:[NSString stringWithFormat:@"%zd",LNSystemErrorWrongApiData]
                            message:LNSystemErrorMessageWrongApiDataMessage];;
#endif
    
    return [self ln_errorWithDomain:LNAPIDataErrorDomain
                         codeString:[NSString stringWithFormat:@"%zd",LNSystemErrorWrongApiData]
                            message:LNSystemErrorMessageWrongApiDataMessage];
}

//封装error信息到error对象，返回error
+ (NSError *)ln_errorWithDomain:(NSString *)errorDomain codeString:(NSString *)codeString message:(id)message {
    if (!message) {
        return nil;
    }
    
    NSError *aError = nil;
    
    if ([errorDomain isEqualToString:LNSystemErrorDomain]) {
        NSLog(@"LNSystemErrorDomain -- message is [%@]", message);
        NSDictionary *userInfo = @{@"errCode" : codeString, @"message" : message};
        aError = [NSError errorWithDomain:LNSystemErrorDomain code:[codeString integerValue] userInfo:userInfo];
    } else if ([errorDomain isEqualToString:LNLogicErrorDomain]) {
        //将错误信息封装到error 中，抛到上层
        NSDictionary *userInfo = @{@"errCode" : codeString, @"message" : message};
        aError = [NSError errorWithDomain:LNLogicErrorDomain code:LNSystemErrorUnknownError userInfo:userInfo];
    }
    return aError;
}

/**
 处理token失效或者用户抢登的情况
 
 @return YES：common_0001 NO：其他code
 */
- (BOOL)ln_handleInvalidateToken:(NSDictionary *)dictionary {
    if (![dictionary[@"errCode"] isEqualToString:kTokenInvalidateCode]) {
        return NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationCommon_0001 object:nil userInfo:dictionary];
    return YES;
}

/**
 借款失败，信用不足
 
 @return YES：jiekuan_1000 NO：其他code
 */
- (BOOL)ln_handleJiekuan1000:(NSDictionary *)dictionary {
    if (![dictionary[@"errCode"] isEqualToString:kjiekuanCode]) {
        return NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationJiekuan_1000 object:nil userInfo:dictionary];
    return YES;
}


/**
 处理强制升级
 
 @return YES：common_0035 NO：其他code
 */
- (BOOL)ln_handleForceUpdate:(NSDictionary *)dictionary {
    if (![dictionary[@"errCode"] isEqualToString:kForceUpdateCode]) {
        return NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationCommon_0035 object:nil userInfo:dictionary];
    return YES;
}

//验证码
- (BOOL)ln_handleImageCodeError:(NSDictionary *)dictionary {
    if (![dictionary[@"errCode"] isEqualToString:kAnquanxinxiCode]) {
        return NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationImageCodeError object:nil userInfo:dictionary];
    return YES;
}

@end

