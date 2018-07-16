//
//  BasicConfigModel+Service.m
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BasicConfigModel+Service.h"

@implementation BasicConfigModel (Service)

+ (NSString *)ln_APIServer {
    return @"http://dev-static.huaqianwy.com/api";
}


+ (NSURLSessionDataTask *_Nullable)requestBasicConfigCompletion:(nullable void (^)(BasicConfigModel *_Nullable result,
        NSError *_Nullable error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSURLSessionDataTask *task = [self ln_requestModelAPI:APPGetConfig
                                                   method:HTTP_POST
                                               parameters:dict
                                               completion:^(id _Nonnull responseObject, NSError *_Nonnull error) {
                                                   completion(responseObject, error);
                                               }];
    return task;
}
@end
