//
//  ImageCodeModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/16.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ImageCodeModel+Service.h"

@implementation ImageCodeModel (Service)

+ (NSString *)ln_APIServer {
    return HQWY_MEMBER_HOST_PATH;
}

+ (NSURLSessionDataTask *)requsetImageCodeCompletion:(void (^)(ImageCodeModel * _Nullable, NSError * _Nullable))completion{
    return [self ln_requestModelAPI:IMAGE_CODE parameters:nil completion:completion];
}

@end
