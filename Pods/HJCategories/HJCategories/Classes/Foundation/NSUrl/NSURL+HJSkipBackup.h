//
//  NSURL+HJSkipBackup.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSURL (HJSkipBackup)

/**
 设置当前目录下的文件不会被备份到icloud
 针对比较大的并且放在 Document 目录下的文件采取这个操作可以防止被拒

 @return 是否成功
 */
- (BOOL)hj_setSkipBackupAttribute;

@end
