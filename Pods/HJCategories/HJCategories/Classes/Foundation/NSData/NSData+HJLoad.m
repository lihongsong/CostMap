//
//  NSData+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "NSData+HJLoad.h"

@implementation NSData (HJLoad)

+ (NSData *)hj_loadData:(NSString *)name type:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSData *)hj_loadData:(NSString *)name type:(NSString *)type bundle:(NSBundle *)bundle{
    
    NSString *path = [bundle pathForResource:name ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSData *)hj_loadDocumentData:(NSString *)name
                           type:(NSString *)type{
    
    NSString *fileName = name;
    
    if(type){
        fileName = [NSString stringWithFormat:@"%@.%@",name,type];
    }
    
    NSString *path = [[NSData document].path stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSURL *)document
{
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSDocumentDirectory
                                             inDomains:NSUserDomainMask];
    NSURL* dir = nil;
    
    
    if ([possibleURLs count] >= 1) {
        dir = [possibleURLs objectAtIndex:0];
    }
    return dir;
}

@end
