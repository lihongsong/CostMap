//
//  NSURL+HJSkipBackup.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSURL+HJSkipBackup.h"

@implementation NSURL (HJSkipBackup)

- (BOOL)hj_setSkipBackupAttribute{
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: [self path]]);
    
    NSError *error = nil;
    
    NSLog(@"addSkipBackupAttributeToItemAtURL");
    
    BOOL success = [self setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    
    if(!success){
        
        NSLog(@"Error excluding %@ from backup %@", [self lastPathComponent], error);
        
    }
    
    return success;
}

@end
