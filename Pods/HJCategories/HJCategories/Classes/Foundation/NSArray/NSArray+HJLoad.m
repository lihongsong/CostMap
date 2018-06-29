//
//  NSArray+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "NSArray+HJLoad.h"

@implementation NSArray (HJLoad)

+ (NSArray *)hj_loadArray:(NSString *)name
                     type:(NSString *)type{
    return [self hj_loadArray:name
                         type:type
                       bundle:[NSBundle mainBundle]];
}

+ (NSArray *)hj_loadArray:(NSString *)name
                     type:(NSString *)type
                   bundle:(NSBundle *)bundle{
    
    NSString *path = [bundle pathForResource:name ofType:type];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

@end
