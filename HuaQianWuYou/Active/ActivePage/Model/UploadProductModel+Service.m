//
//  UploadProductModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UploadProductModel+Service.h"

@implementation UploadProductModel (Service)

+ (NSString *)ln_APIServer {
    return HQWY_PRODUCT_PATH;
}

+ (NSURLSessionDataTask *_Nullable)uploadProduct:(NSNumber *)category mobilePhone:(NSString*)mobilePhone productID:(NSNumber *)productId Completion:(nullable void (^)(UploadProductModel * _Nullable, NSError * _Nullable))completion{
    NSMutableDictionary *params = [@{} mutableCopy];
    [params setValue:mobilePhone forKey:@"mobilePhone"];
    [params setValue:category forKey:@"category"];
     [params setValue:productId forKey:@"productId"];
    return [self ln_requestModelAPI: LN_POST_ProductUpload_PATH parameters:params completion:completion];
}
@end
