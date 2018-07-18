//
//  BasicConfigModel+Service.m
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BasicConfigModel+Service.h"

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
@end
