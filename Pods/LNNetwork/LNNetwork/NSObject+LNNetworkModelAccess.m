//
//  NSObject+LNNetworkModelAccess.m
//  LNNetworkExample
//
//  Created by terrywang on 2017/7/12.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "NSObject+LNNetworkModelAccess.h"

@implementation NSObject (LNNetworkModelAccess)

#pragma mark - Model

+ (NSURLSessionDataTask *)ln_requestModelAPI:(nonnull NSString *)api
                                  parameters:(nullable NSDictionary *)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_requestModelAPI:api method:HTTP_POST parameters:parameters completion:completion];
}

+ (NSURLSessionDataTask *)ln_requestModelAPI:(NSString *_Nonnull)api
                                      method:(HTTP_METHOD)method
                                  parameters:(NSDictionary *_Nullable)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_requestModelAPI:api method:method headers:nil parameters:parameters completion:completion];
}

+ (NSURLSessionDataTask *)ln_requestModelAPI:(nonnull NSString *)api
                                      method:(nonnull HTTP_METHOD)method
                                     headers:(nullable NSDictionary *)headers
                                  parameters:(nullable NSDictionary *)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_requestAPI:api
                        method:method
                       headers:headers
                    parameters:parameters
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull data) {
                           if (completion) {
                               completion([self ln_parseResponseObject:data], nil);
                           }
                       } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                           if (completion) {
                               completion(nil, error);
                           }
                       }];
}

+ (NSURLSessionDataTask *)ln_uploadModelAPI:(NSString *)api
                                    headers:(NSDictionary *)headers
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                 completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_uploadAPI:api
                      headers:headers
                   parameters:parameters
    constructingBodyWithBlock:block
                     progress:uploadProgress
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull data) {
                          if (completion) {
                              completion([self ln_parseResponseObject:data], nil);
                          }
                      } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                          if (completion) {
                              completion(nil, error);
                          }
                      }];
}

+ (NSURLSessionDataTask *)ln_requestJsonModelAPI:(NSString *_Nonnull)api
                                         headers:(NSDictionary *_Nullable)headers
                                        httpBody:(NSData *)httpBody
                                      completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_requestJsonModelAPI:api
                                headers:headers
                               httpBody:httpBody
                             parameters:nil
                         uploadProgress:nil
                       downloadProgress:nil
                             completion:completion];
}

+ (NSURLSessionDataTask *)ln_requestJsonModelAPI:(NSString *_Nonnull)api
                                         headers:(NSDictionary *_Nullable)headers
                                        httpBody:(NSData *)httpBody
                                      parameters:(NSDictionary *_Nullable)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                      completion:(void (^)(id responseObject, NSError *error))completion {
    return [self ln_requestJsonAPI:api
                            method:HTTP_POST
                           headers:headers
                          httpBody:httpBody
                        parameters:parameters
                    uploadProgress:uploadProgress
                  downloadProgress:downloadProgress
                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull data) {
                               if (completion) {
                                   completion([self ln_parseResponseObject:data], nil);
                               }
                           } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                               if (completion) {
                                   completion(nil, error);
                               }
                           }];
}


@end
