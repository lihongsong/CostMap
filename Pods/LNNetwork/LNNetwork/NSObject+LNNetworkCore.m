//
//  NSObject+LNNetworkCore.m
//  LNNetworkExample
//
//  Created by terrywang on 2017/7/12.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "NSObject+LNNetworkCore.h"

HTTP_METHOD const HTTP_POST   = @"POST";
HTTP_METHOD const HTTP_GET    = @"GET";
HTTP_METHOD const HTTP_PUT    = @"PUT";
HTTP_METHOD const HTTP_HEAD   = @"HEAD";
HTTP_METHOD const HTTP_DELETE = @"DELETE";
HTTP_METHOD const HTTP_PATCH  = @"PATCH";

@interface AFHTTPSessionManager (Private)

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                downloadProgress:(void (^)(NSProgress *downloadProgress))downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@implementation NSObject (LNNetworkCore)

#pragma mark - Basic
+ (AFHTTPSessionManager *)ln_sessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([self respondsToSelector:@selector(ln_setupRequestSerializer:)]) {
        [self ln_setupRequestSerializer:manager.requestSerializer];
    }
    
    if ([self respondsToSelector:@selector(ln_setupResponseSerializer:)]) {
        [self ln_setupResponseSerializer:manager.responseSerializer];
    }
    
    return manager;
}

+ (NSString *)ln_URLStringWithAPI:(NSString *)api {
    NSAssert([self respondsToSelector:@selector(ln_APIServer)], @"+[NSObject ln_APIServer:] must be implementation!");
    return [[self ln_APIServer] stringByAppendingPathComponent:api];
}

+ (NSString *)ln_URLStringForAPI:(NSString *)api
                      parameters:(NSDictionary *)parameters {
    NSString *URLString = [self ln_URLStringWithAPI:api];
    if ([self respondsToSelector:@selector(ln_signParameters:)]) {
        parameters = [self ln_signParameters:parameters];
    }
    NSMutableArray<NSURLQueryItem *> *items = [NSMutableArray arrayWithCapacity:parameters.count];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [items addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
    }];
    NSURLComponents *components = [NSURLComponents componentsWithString:URLString];
    components.queryItems = items;
    return [components string];
}

+ (NSURLSessionDataTask *)ln_requestAPI:(NSString *_Nonnull)api
                                 method:(NSString *_Nullable)method
                                headers:(NSDictionary *_Nullable)headers
                             parameters:(NSDictionary *_Nullable)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *URLString = [self ln_URLStringWithAPI:api];
    //    NSLog(@"--URLString-----%@", URLString);
    parameters = [self ln_signParameters:parameters];
    
#ifdef DEBUG
    //    static NSUInteger taskId = 0;
    //    taskId++;
    //    NSInteger curTaskId = taskId;
#endif
    
    //    NSLog(@"request(%zd) %@: %@", taskId, api, parameters);
    AFHTTPSessionManager *manager = [self ln_sessionManager];
    if (headers) {
        [headers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop){
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
            
        }];
    }
    
    NSURLSessionDataTask *dataTask;
    //    NSLog(@"--basic-URLString----%@", URLString);
    dataTask = [manager dataTaskWithHTTPMethod:method
                                     URLString:URLString
                                    parameters:parameters
                                uploadProgress:nil
                              downloadProgress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           [self ln_receiveResponseObject:response
                                                                     task:task
                                                                    error:nil
                                                                  success:success
                                                                  failure:failure];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [self ln_receiveResponseObject:nil
                                                                     task:task
                                                                    error:error
                                                                  success:success
                                                                  failure:failure];
                                       }];
    
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionDataTask *)ln_uploadAPI:(NSString *_Nonnull)api
                               headers:(NSDictionary *_Nullable)headers
                            parameters:(NSDictionary *_Nullable)parameters
             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                              progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *URLString = [self ln_URLStringWithAPI:api];
    
    parameters = [self ln_signParameters:parameters];
    
    NSLog(@"request %@: %@", api, parameters);
    AFHTTPSessionManager *manager = [self ln_sessionManager];
    if (headers) {
        [headers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop){
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }];
    }
    
    return [manager POST:URLString
              parameters:parameters
constructingBodyWithBlock:block
                progress:uploadProgress
                 success:^(NSURLSessionDataTask *task, id response) {
                     [self ln_receiveResponseObject:response
                                               task:task
                                              error:nil
                                            success:success
                                            failure:failure];
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     [self ln_receiveResponseObject:nil
                                               task:task
                                              error:error
                                            success:success
                                            failure:failure];
                 }];
}

+ (NSURLSessionDataTask *)ln_requestJsonAPI:(NSString *_Nonnull)api
                                     method:(NSString *_Nullable)method
                                    headers:(NSDictionary *_Nullable)headers
                                   httpBody:(NSData *)httpBody
                                 parameters:(NSDictionary *_Nullable)parameters
                             uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                           downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *URLString = [self ln_URLStringWithAPI:api];

    parameters = [self ln_signParameters:parameters];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPRequestSerializer *serializer = [AFJSONRequestSerializer serializer];

    if ([self respondsToSelector:@selector(ln_setupRequestSerializer:)]) {
        [self ln_setupRequestSerializer:serializer];
    }

    NSMutableURLRequest *request = [serializer requestWithMethod:method
                                                       URLString:URLString
                                                      parameters:nil error:nil];

    if (headers) {
        [headers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop){
            [request setValue:value forHTTPHeaderField:key];
        }];
    }

    [request setHTTPBody:httpBody];

    NSURLSessionDataTask *dataTask;
    dataTask = [manager dataTaskWithRequest:request
                             uploadProgress:uploadProgress
                           downloadProgress:downloadProgress
                          completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                              if (error) {
                                  if (failure) {
                                      [self ln_receiveResponseObject:responseObject
                                                                task:nil
                                                               error:error
                                                             success:success
                                                             failure:failure];
                                  }
                                  return ;
                              }
                              if (success) {
                                  [self ln_receiveResponseObject:responseObject
                                                            task:nil
                                                           error:nil
                                                         success:success
                                                         failure:failure];
                              }
                          }];
    [dataTask resume];
    return dataTask;
}

@end
