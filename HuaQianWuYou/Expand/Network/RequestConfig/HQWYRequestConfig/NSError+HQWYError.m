//
//  NSError+HQWYError.m
//  HQWYNetwork
//
//  Created by terrywang on 2017/6/27.
//  Copyright © 2017年  terrywang. All rights reserved.
//

#import "NSError+HQWYError.h"

static NSString *const kHQWYErrorRespCodeKey      = @"respCode";
static NSString *const kHQWYErrorRespMsgKey       = @"respMsg";

@implementation NSError (HQWYError)

- (NSString *)hqwy_errorMessage {
    if (!self) {
        return nil;
    }

    NSString *message = nil;
    
    if ([self hqwy_isSystemError]) {
        if ([self hqwy_isNetworkIssueError]) {
            //网络错误
            message = HQWYSystemErrorMessageNetworkIssueMessage;
        } else if ([self hqwy_isRequestCancelled]) {
            //请求取消，不toast
            message = nil;
        } else {
            //其他http异常(包括服务端返回数据异常)
            message = HQWYSystemErrorMessageUnkownErrorMessage;
        }
    }else {
        if ([self hqwy_isAPIDataError]) {
            message = HQWYSystemErrorMessageWrongApiDataMessage;
        }

        if ([self hqwy_isLogicError]) {
            message = [self hqwy_parseLogicErrorMessage];
        }
    }

    return message;
}

- (HQWYRESPONSECODE)hqwy_respCode {
    return !self.userInfo[kHQWYErrorRespCodeKey] ? HQWYRESPONSECODE_UNKNOW : [self.userInfo[kHQWYErrorRespCodeKey] integerValue];
}


- (BOOL)hqwy_isSystemError {
    return [self.domain isEqualToString:HQWYSystemErrorDomain];
}

- (BOOL)hqwy_isLogicError {
    return [self.domain isEqualToString:HQWYLogicErrorDomain];
}

- (BOOL)hqwy_isAPIDataError {
    return [self.domain isEqualToString:HQWYAPIDataErrorDomain];
}

- (BOOL)hqwy_isRequestCancelled {
    return ([self.userInfo[kHQWYErrorRespCodeKey] integerValue] == NSURLErrorCancelled);
}


- (BOOL)hqwy_isNetworkIssueError {
    return ([self.userInfo[kHQWYErrorRespCodeKey] integerValue] == NSURLErrorNotConnectedToInternet);
}

- (NSString *)hqwy_parseLogicErrorMessage {

    NSLog(@"HQWY_handleLogicError error %@", self.userInfo);
    if (!self.userInfo || !self.userInfo[kHQWYErrorRespMsgKey]) {
        return HQWYSystemErrorMessageUnkownErrorMessage;
    }

    if (!self.userInfo
        || !self.userInfo[kHQWYErrorRespMsgKey]
        || [self.userInfo[kHQWYErrorRespMsgKey] isEqual:[NSNull null]]) {
        return HQWYSystemErrorMessageUnkownErrorMessage;
    }

    if (!self.userInfo[kHQWYErrorRespCodeKey]
        || [self.userInfo[kHQWYErrorRespCodeKey] isKindOfClass:[NSNull class]]
        || [self.userInfo[kHQWYErrorRespCodeKey] isEqual:[NSNull null]]) {
        return self.userInfo[kHQWYErrorRespMsgKey];
    }

    return self.userInfo[kHQWYErrorRespMsgKey];
}

//处理系统错误，如网络异常
//注意：message为实际的错误信息，方便开发调试。当showError时，会再做一次过滤，用户看到的是过滤后的消息。

+ (NSError *)hqwy_handleLogicError:(NSString *)respMsg respCode:(NSString *)respCode {
    return [NSError errorWithDomain:HQWYLogicErrorDomain
                               code:[respCode integerValue]
                           userInfo:@{kHQWYErrorRespMsgKey : respMsg, kHQWYErrorRespCodeKey : respCode}];
}

+ (NSError *)hqwy_handleSystemError:(NSError *)error {
    NSLog(@"%@", error.description);
    return [NSError errorWithDomain:HQWYSystemErrorDomain
                               code:error.code
                           userInfo:@{kHQWYErrorRespMsgKey : HQWYSystemErrorMessageUnkownErrorMessage,
                                      kHQWYErrorRespCodeKey : [NSString stringWithFormat:@"%ld", (long)error.code]}];
}

//处理API数据错误，如：返回的result对象类型错误
+ (NSError *)hqwy_handleApiDataError {
#if DEBUG
    NSAssert(NO, @"数据类型不匹配，请检查！");
#endif
    return [NSError errorWithDomain:HQWYAPIDataErrorDomain
                               code:HQWYSystemErrorWrongApiData
                           userInfo:@{kHQWYErrorRespMsgKey : HQWYSystemErrorMessageWrongApiDataMessage,
                                      kHQWYErrorRespCodeKey : [NSString stringWithFormat:@"%d", HQWYSystemErrorWrongApiData]}];
}

@end
