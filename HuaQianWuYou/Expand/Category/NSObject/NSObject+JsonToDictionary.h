//
//  NSObject+JsonToDictionary.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/30.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsonToDictionary)

//字符串转字典
- (NSDictionary *)jsonDicFromString:(NSString *)string;

@end
