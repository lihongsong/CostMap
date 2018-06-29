//
//  NSObject+RequestConfig.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "NSObject+RequestConfig.h"
#import "NSObject+YYModel.h"
#import "LoginInfoModel.h"
#import "NSError+CustomError.h"

@implementation NSObject (RequestConfig)

+ (NSString *)ln_APIServer {
    return @"http://appjieqian.2345.com/index.php";
}

+ (NSDictionary *)ln_signParameters:(NSDictionary *)paramters {
    return paramters;
}

+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
    NSString *cookieString = userInfo?userInfo.cookie:@"";
    NSString *version = [UIDevice hj_appVersion];
    NSString *buddleId = [UIDevice hj_bundleIdentifier];
    [requestSerializer setValue:version forHTTPHeaderField:@"version"];
    [requestSerializer setValue:@"hqwy_ios" forHTTPHeaderField:@"channel"];
    [requestSerializer setValue:@"10001" forHTTPHeaderField:@"appid"];
    [requestSerializer setValue:buddleId forHTTPHeaderField:@"package-name"];
    [requestSerializer setValue:cookieString forHTTPHeaderField:@"cookie"];
}

+ (void)ln_receiveResponseObject:(id)responseObject
                            task:(NSURLSessionDataTask *)task
                           error:(NSError *)error
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (error) {
        if (failure) {
            failure(task, error);
            if (!error) {
                NSString *errMsg = [responseObject objectForKey:@"msg"];
                [KeyWindow ln_showToastHUD:errMsg];
            }
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

+ (id)ln_parseResponseObject:(id)responseObject {
    if (!responseObject || [responseObject isEqual:[NSNull null]]) {
        return nil;
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        if (self != [NSString class] && self != [NSNumber class]) {
            return [NSArray yy_modelArrayWithClass:self json:responseObject];
        }
    } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = responseObject;

        NSLog(@"[JSONRESPONSE] - %@", [responseDict hj_JSONString]);

        if (responseDict.allKeys.count > 0) {
            return [self yy_modelWithJSON:responseObject];
        } else {
            return nil;
        }

    } else  {
        return responseObject;
    }
    return 0;
}

@end
