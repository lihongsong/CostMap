//
//  NSData+HJDeviceToken.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSData (HJDeviceToken)

/**
 将 data 类型的 deviceToken 转成 string
 */
- (NSString *)hj_deviceToken;

@end
