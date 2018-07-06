//
//  HQWYJavaScriptResponse.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQWYJavaScriptResponse : NSObject

+ (NSString *)success;

+ (NSString *)result:(id)result;

+ (NSString *)responseCode:(NSString *)code error:(NSString *)error result:(id)result;

@end
