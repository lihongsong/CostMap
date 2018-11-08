//
//  SQLDataManager.h
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/28.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WYHQBillModel.h"

typedef void(^DBResultBlock)(NSMutableArray <WYHQBillModel *> *result, NSError *error);

@interface WYHQSQLManager : NSObject
/*
 初始化
 */
+ (instancetype)share;

/**
 查询表是否存在
 */
- (BOOL)isTableExist:(NSString *)tableName;


/**
 创建新表
 */
- (void)creatNewDataBase:(NSString *)name;

/**
 更新单条数据
 */
- (void)updateData:(WYHQBillModel *)model tableName:(NSString *)tableName;

/**
 插入单条数据
 **/
- (void)insertData:(WYHQBillModel *)model tableName:(NSString *)tableName;

/**
 获取表内所有数据
 */
- (NSMutableArray <WYHQBillModel *> *)searchData:(NSString *)tableName;


/**
 获取表内数据 条件查询
 */
- (NSMutableArray <WYHQBillModel *> *)searchData:(WYHQBillModel *)model tableName:(NSString *)tableName;

/**
 查询数据 根据年月日
 */
- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction;

/**
 清空数据库和缓存
 */
- (void)clearData:(NSString *)tableName;

/**
 获取所有表数据
 */
- (NSMutableArray <WYHQBillModel *> *)searchAllData;

/**
 删除表里某条数据
 */
- (void)deleteData:(NSString*)tableName s_id:(NSString *)s_id;
@end
