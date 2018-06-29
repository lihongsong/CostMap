//
//  NSArray+HJLoad.h
//  HJCategories
//
//  Created by yoser on 2018/1/5.
//

#import <Foundation/Foundation.h>

@interface NSArray (HJLoad)

/**
 读取本地的保存在 mainBundle 中的 NSArray
 
 @param name 文件名
 @param type 文件类型
 @return 数组实例
 */
+ (NSArray *)hj_loadArray:(NSString *)name
                     type:(NSString *)type;

/**
 读取本地的保存在本地中的 NSArray
 
 @param name 文件名
 @param type 文件类型
 @param bundle 文件目录
 @return 数组实例
 */
+ (NSArray *)hj_loadArray:(NSString *)name
                      type:(NSString *)type
                    bundle:(NSBundle *)bundle;


@end
