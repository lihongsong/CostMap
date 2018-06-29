//
//  NSDictionary+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "NSDictionary+HJLoad.h"

@implementation NSDictionary (HJLoad)

+ (NSDictionary *)hj_loadDictionary:(NSString *)name
                               type:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictionary;
}


+ (NSDictionary *)hj_loadDictionary:(NSString *)name
                               type:(NSString *)type
                             bundle:(NSBundle *)bundle{
    
    NSString *path = [bundle pathForResource:name ofType:type];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictionary;
}
@end
