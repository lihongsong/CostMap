//
//  NSDictionary+HJJSON.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSDictionary+HJJSON.h"

@implementation NSDictionary (HJJSON)

/**
 *  NSDictionary转换成JSON字符串
 */
-(NSString *)hj_JSONString{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error){
        NSLog(@" json 2 string error : %@",error);
        return @"";
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
