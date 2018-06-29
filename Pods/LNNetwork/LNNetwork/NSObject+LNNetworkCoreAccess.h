//
//  NSObject+LNNetworkCoreAccess.h
//  LNNetworkExample
//
//  Created by terrywang on 2017/7/12.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LNNetworkCore.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LNNetworkCoreAccess) <LNNetworkProtocol>

+ (NSURLSessionDataTask *)ln_requestAPI:(NSString *_Nonnull)api
                             parameters:(NSDictionary *_Nullable)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)ln_requestAPI:(NSString *_Nonnull)api
                                 method:(HTTP_METHOD _Nullable)method
                             parameters:(NSDictionary *_Nullable)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)ln_uploadAPI:(NSString *_Nonnull)api
                            parameters:(NSDictionary *_Nullable)parameters
             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                              progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)ln_requestJsonAPI:(NSString *_Nonnull)api
                                    headers:(NSDictionary *_Nullable)headers
                                   httpBody:(NSData *)httpBody
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
NS_ASSUME_NONNULL_END
