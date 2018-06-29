//
//  NSFileManager+HJPaths.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSFileManager+HJPaths.h"

@implementation NSFileManager (HJPaths)

+ (NSURL *)hj_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)hj_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)hj_documentsURL
{
    return [self hj_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)hj_documentsPath
{
    return [self hj_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)hj_libraryURL
{
    return [self hj_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)hj_libraryPath
{
    return [self hj_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)hj_cachesURL
{
    return [self hj_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)hj_cachesPath
{
    return [self hj_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)hj_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)hj_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.hj_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}


@end
