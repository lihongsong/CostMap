//
//  UnClickProductModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UnClickProductModel+Service.h"

@implementation UnClickProductModel (Service)
+ (NSURLSessionDataTask *_Nullable)getUnClickProductList:(NSNumber *)category mobilePhone:(NSString*)mobilePhone Completion:(nullable void (^)(UnClickProductModel * _Nullable, NSError * _Nullable))completion{
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:mobilePhone forKey:@"mobilePhone"];
    [params setValue:category forKey:@"category"];
    return [self ln_requestModelAPI:LN_POST_ReturnToDetain_PATH  parameters:params completion:completion];
}

@end