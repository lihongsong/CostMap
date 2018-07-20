//
//  BasicConfigModel+Service.m
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BasicConfigModel+Service.h"
#import "NSObject+YYModel.h"
#import "LoginInfoModel.h"
#import "NSError+CustomError.h"

@implementation BasicConfigModel (Service)

+ (NSURLSessionDataTask *_Nullable)requestBasicConfigCompletion:(nullable void (^)(BasicConfigModel *_Nullable result,
                                                                                   NSError *_Nullable error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"homeSet" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    NSURLSessionDataTask *task = [self ln_requestModelAPI:@""
                                                   method:HTTP_POST
                                               parameters:dict
                                               completion:^(id _Nonnull responseObject, NSError *_Nonnull error) {
                                                   completion(responseObject, error);
                                               }];
    return task;
}


+ (NSString *)ln_APIServer {
    return HQWY_MAJIA_PATH;
}

+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    //超时时间
    requestSerializer.timeoutInterval = 15;
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

@end
