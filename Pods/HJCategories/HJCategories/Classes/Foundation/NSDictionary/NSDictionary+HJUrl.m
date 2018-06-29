//
//  NSDictionary+HJUrl.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSDictionary+HJUrl.h"

@implementation NSDictionary (HJUrl)

+ (NSDictionary *)hj_dictionaryWithURLQuery:(NSString *)query{
    
    NSArray *items = [query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    for (NSString *item in items) {
        
        NSArray *array = [item componentsSeparatedByString:@"="];
        
        NSString *key = [array firstObject];
        
        NSString *tempValue = [array lastObject];
        
        if(!key || !tempValue){
            continue;
        }
        
        // OC 中的 urlDecode操作 默认用 utf-8
        NSString *value = [tempValue stringByRemovingPercentEncoding];
        
        [tempDic setValue:value forKey:key];
        
    }
    return [tempDic mutableCopy];
}

- (NSString *)hj_URLQueryString{
    
    __block NSMutableString *tempString = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *temp = [NSString stringWithFormat:@"%@=%@&",key,obj];
        
        // OC 中的 urlEncode操作
        CFStringRef cf_query = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                (CFStringRef)temp,
                                                NULL,
                                                (CFStringRef)CFSTR("!*'();:@&=+$,/?%#[]"),
                                                kCFStringEncodingUTF8);
        
        NSString *queryString = (__bridge NSString *)cf_query;
        [tempString appendString:queryString];
    }];
    
    [tempString deleteCharactersInRange:NSMakeRange(tempString.length - 1, 1)];
    
    return [tempString mutableCopy];
}

@end
