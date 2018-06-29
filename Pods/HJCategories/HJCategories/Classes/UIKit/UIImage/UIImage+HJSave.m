//
//  UIImage+HJSave.m
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import "UIImage+HJSave.h"

@implementation UIImage (HJSave)

- (void)hj_writeToFile:(NSString *)file{
    
    NSData *data = nil;
    if([file hasSuffix:@"png"]){
        data = UIImagePNGRepresentation(self);
    }else if([file hasSuffix:@"jpeg"] || [file hasSuffix:@"jpg"]){
        data = UIImageJPEGRepresentation(self, 1.0);
    }else{
        CGImageRef imgA = self.CGImage;
        CGDataProviderRef inProviderA = CGImageGetDataProvider(imgA);
        CFDataRef inBitmapDataA = CGDataProviderCopyData(inProviderA);
        data = [[NSData alloc] initWithData:(__bridge_transfer NSData *)inBitmapDataA];
    }
    
    [data writeToFile:file atomically:YES];
}

- (NSString *)hj_writeToDocument:(NSString *)name{
    
    return [self hj_writeToDocument:nil fileName:name];
}

- (NSString *)hj_writeToDocument:(NSString *)directory fileName:(NSString *)name{
    
    NSString *document = [[UIImage document] path];
    NSString *filePath = nil;
    
    if(directory && directory.length > 0){
        NSString *directoryPath = [document stringByAppendingPathComponent:directory];
        filePath = [directoryPath stringByAppendingPathComponent:name];
        
        if(![UIImage existDirectory:directoryPath]){
            [UIImage createDirectory:directoryPath];
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
