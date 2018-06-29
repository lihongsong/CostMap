//
//  DiscoverPageModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverPageModel+Service.h"
#import "NSObject+YYModel.h"

@implementation DiscoverPageModel (Service)


+ (NSURLSessionDataTask *_Nullable)requestDiscoverPageModelCompletion:(nullable void (^)(DiscoverPageModel *_Nullable result, NSError *_Nullable error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"discover" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_GET
                                          parameters:dict
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                 
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                 completion(nil,error);
                                             }];
    
    return task;
}

@end
