//
//  NSString+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "NSString+HJLoad.h"

@implementation NSString (HJLoad)

+ (NSString *)hj_loadString:(NSString *)name
                       type:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    NSError *error;
    
    NSString *string = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    return string;
}

+ (NSString *)hj_loadString:(NSString *)name
                       type:(NSString *)type
                     bundle:(NSBundle *)bundle{
    
    NSString *path = [bundle pathForResource:name ofType:type];
    
    NSError *error;
    
    NSString *string = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    return string;
}

@end
