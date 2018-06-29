//
//  NSObject+LNNetworkModelAccess.h
//  LNNetworkExample
//
//  Created by terrywang on 2017/7/12.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LNNetworkCore.h"

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (LNNetworkModelAccess)

+ (NSURLSessionDataTask *)ln_requestModelAPI:(NSString *_Nonnull)api
                                  parameters:(NSDictionary *_Nullable)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion;

+ (NSURLSessionDataTask *)ln_requestModelAPI:(NSString *_Nonnull)api
                                      method:(HTTP_METHOD)method
                                  parameters:(NSDictionary *_Nullable)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion;

+ (NSURLSessionDataTask *)ln_requestModelAPI:(NSString *_Nonnull)api
                                      method:(HTTP_METHOD _Nonnull)method
                                     headers:(NSDictionary *_Nullable)headers
                                  parameters:(NSDictionary *_Nullable)parameters
                                  completion:(void (^)(id responseObject, NSError *error))completion;

+ (NSURLSessionDataTask *)ln_uploadModelAPI:(NSString *_Nonnull)api
                                    headers:(NSDictionary *_Nullable)headers
                                 parameters:(NSDictionary *_Nullable)parameters
                  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                   progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                 completion:(void (^)(id responseObject, NSError *error))completion;

+ (NSURLSessionDataTask *)ln_requestJsonModelAPI:(NSString *_Nonnull)api
                                         headers:(NSDictionary *_Nullable)headers
                                        httpBody:(NSData *)httpBody
                                      completion:(void (^)(id responseObject, NSError *error))completion;

@end
NS_ASSUME_NONNULL_END
