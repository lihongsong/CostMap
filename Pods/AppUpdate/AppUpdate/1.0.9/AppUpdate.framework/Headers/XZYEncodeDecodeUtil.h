//
//  AUEncodeDecodeUtil.h
//  AppUpdateDemo
//
//  Created by zhangnan on 15/11/2.
//  Copyright © 2015年 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  加密解密，主要用于服务器返回的数据的解密，和请求路径的加密
 */
@interface XZYEncodeDecodeUtil : NSObject

/**
 *	根据加密key对数据加密并编码
 */
+(NSString *)encodeDataWithSrc:(NSString *)src;

@end
