//
//  NSData+HJLoad.h
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import <Foundation/Foundation.h>

@interface NSData (HJLoad)

/**
 根据文件名字读取数据 mainBundle 下

 @param name 文件名
 @param type 类型
 @return data
 */
+ (NSData *)hj_loadData:(NSString *)name
                   type:(NSString *)type;

/**
 根据文件名字读取数据

 @param name 文件名
 @param type 类型
 @param bundle 文件目录
 @return data
 */
+ (NSData *)hj_loadData:(NSString *)name
                   type:(NSString *)type
                 bundle:(NSBundle *)bundle;

/**
 根据文件名字读取数据 在沙盒Document文件夹下

 @param name 文件名
 @param type 类型
 @return data
 */
+ (NSData *)hj_loadDocumentData:(NSString *)name
                           type:(NSString *)type;

@end
