//
//  NSData+HJSave.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "NSData+HJSave.h"

@implementation NSData (HJSave)

- (void)hj_writeToFile:(NSString *)file{
    
    [self writeToFile:file atomically:YES];
}

- (NSString *)hj_writeToDocument:(NSString *)name{
    
    return [self hj_writeToDocument:nil fileName:name];
}

- (NSString *)hj_writeToDocument:(NSString *)directory fileName:(NSString *)name{
    
    NSString *document = [[NSData document] path];
    NSString *filePath = nil;
    
    if(directory && directory.length > 0){
        NSString *directoryPath = [document stringByAppendingPathComponent:directory];
        filePath = [directoryPath stringByAppendingPathComponent:name];
        
        if(![NSData existDirectory:directoryPath]){
            [NSData createDirectory:directoryPath];
        }
    }
    
    [self hj_writeToFile:filePath];
    
    return filePath;
}

+ (BOOL)createDirectory:(NSString *)path{
    
    NSError *error;
    
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                             withIntermediateDirectories:YES
                                                              attributes:nil
                                                                   error:&error];
    if(error){
        return NO;
    }
    
    return success;
    
}

+ (BOOL)existDirectory:(NSString *)directoryPath {
    BOOL isDirectory;
    return [[NSFileManager defaultManager] fileExistsAtPath:directoryPath
                                                isDirectory:&isDirectory];
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
