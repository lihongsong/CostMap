//
//  NSData+HJSave.h
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import <Foundation/Foundation.h>

@interface NSData (HJSave)

/**
 将 data 写到 Document 中的某一个 directory 下 （文件夹不存在会自动创建）
 
 @param directory 文件夹名字
 @param name 文件名
 @return 文件全路径
 */
- (NSString *)hj_writeToDocument:(NSString *)directory fileName:(NSString *)name;

/**
 将 data 写到 Document 中
 
 @param name 文件名
 @return 文件全路径
 */
- (NSString *)hj_writeToDocument:(NSString *)name;

@end
