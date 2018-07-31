//
//  NSObject+JsonToDictionary.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/30.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "NSObject+JsonToDictionary.h"

@implementation NSObject (JsonToDictionary)
- (NSDictionary *)jsonDicFromString:(NSString *)string {
    
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}
@end
