//
//  LNNetworkProtocol.h
//  LNNetworkExample
//
//  Created by terrywang on 2017/7/17.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LNNetworkProtocol <NSObject>

@optional
/** API 服务器域名
 *
 *  必须实现；例如 http://2345.com
 */
+ (NSString *)ln_APIServer;

/**
 参数签名
 
 @param paramters 需要签名的参数字典
 @return 返回签名后的参数字典
 */
+ (NSDictionary *_Nullable)ln_signParameters:(NSDictionary *_Nullable)paramters;

/**
 创建网络连接默认的参数构造函，每次网络连接都将回调该函数
 此方法可选实现
 @param requestSerializer 需要设置参数的requestSerializer
 */
+ (void)ln_setupRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer;
+ (void)ln_setupResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer;

/**
 处理server返回的response，非Model化处理

 @param responseObject server返回的response
 @param task task
 @param error error
 @param success 处理正常
 @param failure 处理异常
 */
+ (void)ln_receiveResponseObject:(id _Nullable)responseObject
                            task:(NSURLSessionDataTask *_Nullable)task
                           error:(NSError *_Nullable)error
                         success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 处理server返回的response，Model化处理

 @param responseObject server返回的response
 @return Model化的数据
 */
+ (id _Nullable)ln_parseResponseObject:(id _Nullable)responseObject;

@end

NS_ASSUME_NONNULL_END
