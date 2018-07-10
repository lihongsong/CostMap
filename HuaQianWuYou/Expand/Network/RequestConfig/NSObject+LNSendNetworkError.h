//
//  NSObject+LNSendNetworkError.h
//  Loan
//
//  Created by Jacue on 2017/11/3.
//  Copyright © 2017年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LNSendNetworkError)


/**
 向50bang发送接口错误信息

 @param error 错误信息，如果为nil，表示是服务器系统异常
 @param task 请求的任务
 */
+ (void)sendNetworkError:(NSError *)error ofTask:(NSURLSessionDataTask *)task;

@end
