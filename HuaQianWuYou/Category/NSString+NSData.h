//
//  NSString+NSData.h
//  HuaQianWuYou
//
//  Created by jason on 2018/6/7.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSData)
+ (void)stringWithZYZData:(void(^)(NSString *str))block;
@end
