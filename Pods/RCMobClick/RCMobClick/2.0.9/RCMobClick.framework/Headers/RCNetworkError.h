//
//  RCRequestError.h
//  Pods
//
//  Created by Jacue on 2017/11/2.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RCNetworkErrorType) {
    /// 请求超时
    RCNetworkErrorTypeTimeOut = 10,
    /// 其他环境异常
    RCNetworkErrorTypeEnvironment = 11,
    /// http状态码异常
    RCNetworkErrorTypeHttpCode = 20,
    /// 服务器系统异常
    RCNetworkErrorTypeServer = 30
};


@interface RCNetworkError : NSObject

// 用户id
@property (nonatomic, nullable, copy) NSString *userId;
// 产品id
@property (nonatomic, nullable, copy) NSString *pid;
// 用户手机号
@property (nonatomic, nullable, copy) NSString *mobile;
// 请求响应时间（ms）
@property (nonatomic, nullable, copy) NSString *responseTime;
// 请求url
@property (nonatomic, nonnull, copy) NSString *requestUrl;
// 请求的url对应的功能
@property (nonatomic, nonnull, copy) NSString *requestUrlFunction;
// 错误类型
@property (nonatomic, assign) RCNetworkErrorType errorType;
// 发生错误时对应的详细信息
@property (nonatomic, nonnull, copy) NSString *errorContent;

@end
