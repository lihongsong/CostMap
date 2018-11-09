//
//  SQLDataManager.m
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/28.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQSQLManager.h"

#import <FMDB/FMDB.h>
#import <YYModel/YYModel.h>


@interface WYHQSQLManager()
@property(nonatomic, strong) FMDatabase *fmdb;
@property(nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation WYHQSQLManager

- (instancetype)initWithPrivate
{
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}

+ (instancetype)share
{
    static WYHQSQLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager =[[WYHQSQLManager alloc] initWithPrivate];
        }
    });
    return manager;
}

- (void)createDataBase {
    if (!self.fmdb) {
        self.fmdb = [[FMDatabase alloc] initWithPath:[self getDBPath]];
    }
}

// 查询是否存在
- (BOOL)isTableExist:(NSString *)tableName {
    FMResultSet *rs = [self.fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", [self setTableName:tableName]];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);
        
        if (0 == count){
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

- (void)defaultData:(NSString *)name {

    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (s_id integer primary key AUTOINCREMENT,s_time Text, s_type_name Text, s_money Text, s_type_id Text, s_desc Text, s_year Text,s_month Text, s_day Text, s_city Text);", [self setTableName:name]];
    
    [self.fmdb executeUpdate:sql];

}

// 创建新表
- (void)creatNewDataBase:(NSString *)name{
    
    if(![self.fmdb open]) {
        NSLog(@"打开数据库失败!!!");
        return;
    }
    if (![self isTableExist:name]) {
        [self defaultData:name];
        
    }
}

// 更新单条数据
- (void)updateData:(WYHQBillModel *)model tableName:(NSString *)tableName  {
    
    if(![self.fmdb open]) {
        NSLog(@"打开数据库失败!!!");
        return;
    }
    if (![self isTableExist:tableName]) {
        [self creatNewDataBase:tableName];
    }
    //NSLog(@"___%@,%@",model,model.sTypeName);
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET s_time = '%@', s_type_name = '%@' ,s_money = '%@', s_type_id = '%@', s_desc = '%@', s_year = '%@', s_month = '%@', s_day = '%@', s_city = '%@' WHERE s_id = %@;", [self setTableName:tableName], model.s_time , model.s_type_name, model.s_money, model.s_type_id, model.s_desc , model.s_year, model.s_month, model.s_day, model.s_city, model.s_id];
  BOOL updateSucess = [self.fmdb executeUpdate:sql];
    if (!updateSucess) {
        NSLog(@"error = %@", [self.fmdb lastErrorMessage]);
    }
}

// 插入单条数据
- (void)insertData:(WYHQBillModel *)model tableName:(NSString *)tableName {
    
    if([self.fmdb open]){
        if (![self isTableExist:tableName]) {
            [self creatNewDataBase:tableName];
        }
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (s_time, s_type_name, s_money, s_type_id, s_desc ,s_year ,s_month, s_day, s_city) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)", [self setTableName:tableName]];
        __unused BOOL result =
        [self.fmdb executeUpdate:sql,model.s_time ,
         model.s_type_name,
         model.s_money,
         model.s_type_id,
         model.s_desc,
         model.s_year,
         model.s_month,
         model.s_day,
         model.s_city];
        
        //[self.fmdb close];
    }
}

- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction {
    
    if(![self.fmdb open]) {
        NSLog(@"打开数据库失败!!!");
        return;
    }
    
    NSMutableString *sqlString = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE ", [self setTableName:tableName]];
    
    if (!year && !month && !day) {
        !resultAction?:resultAction( nil, [NSError errorWithDomain:@"错误" code:0 userInfo:nil]);
        return ;
    }
    
    if (year) {
        [sqlString appendString:[NSString stringWithFormat:@"s_year= %@",year]];
    }
    
    if (month) {
        if (year) {
            [sqlString appendString:@" AND "];
        }
        [sqlString appendString:[NSString stringWithFormat:@"s_month= %@",month]];
    }
    
    if (day) {
        if (year || month) {
            [sqlString appendString:@" AND "];
        }
        [sqlString appendString:[NSString stringWithFormat:@"s_day= %@",day]];
    }
    
    // 1.执行查询语句
    FMResultSet *resultSet = [self.fmdb executeQuery:sqlString];
    
    // 2.遍历结果
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        WYHQBillModel *model = [[WYHQBillModel alloc] init];
        
        model.s_id =  @([resultSet intForColumn:@"s_id"]).stringValue;
        model.s_time =  [resultSet stringForColumn:@"s_time"];
        model.s_type_name =  [resultSet stringForColumn:@"s_type_name"];
        model.s_money =  [resultSet stringForColumn:@"s_money"];
        model.s_type_id =  [resultSet stringForColumn:@"s_type_id"];
        model.s_desc =  [resultSet stringForColumn:@"s_desc"];
        model.s_year =  [resultSet stringForColumn:@"s_year"];
        model.s_month =  [resultSet stringForColumn:@"s_month"];
        model.s_day =  [resultSet stringForColumn:@"s_day"];
        model.s_city = [resultSet stringForColumn:@"s_city"];
        [dataArr addObject:model];
        
    }
    if (resultAction) {
        resultAction(dataArr, nil);
    }
}

- (void)deleteData:(NSString *)tableName s_id:(NSString *)s_id {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where s_id=%@",[self setTableName:tableName],s_id];
        [self.fmdb stringForQuery:sql];
        [self.fmdb close];
    }
}

- (void)clearData:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE '%@'", [self setTableName:tableName]];
    [self.fmdb executeUpdate:sql];
}

- (NSString *)toJSONByMap:(NSDictionary *)dict {
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)toMapByJson:(NSString *)json {
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:NSJSONReadingMutableContainers
                                             error:&err];
}

- (NSString *)getDBPath {
    //获取沙箱路径下的Documen436tts
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath =[[documentsPath firstObject] stringByAppendingPathComponent:@"WuYouQianBao.db"];
    NSLog(@"%@", dbPath);
    return dbPath;
}

- (NSMutableArray<WYHQBillModel *> *)searchData:(WYHQBillModel *)model tableName:(NSString *)tableName {
    
    if(![self.fmdb open]) {
        NSLog(@"打开数据库失败!!!");
        return [NSMutableArray array];
    }
    NSString *sql;
    
    NSDictionary *modelDic = (NSDictionary *)[model yy_modelToJSONObject];
    
    NSMutableString *searchValue = [NSMutableString stringWithString:@""];
    
    for (int i = 0 ; i < modelDic.allKeys.count; i++) {
        
        NSString *key = modelDic.allKeys[i];
        NSString *value = modelDic[key];
        
        [searchValue appendString:[NSString stringWithFormat:@"%@= %@",key, value]];
        
        if (i < modelDic.allKeys.count - 1) {
            [searchValue appendString:@" AND"];
        }
    }
    
    sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", [self setTableName:tableName], searchValue];
    
    // 1.执行查询语句
    FMResultSet *resultSet = [self.fmdb executeQuery:sql];
    
    // 2.遍历结果
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        WYHQBillModel *model = [[WYHQBillModel alloc] init];
        
        model.s_id =  @([resultSet intForColumn:@"s_id"]).stringValue;
        model.s_time =  [resultSet stringForColumn:@"s_time"];
        model.s_type_name =  [resultSet stringForColumn:@"s_type_name"];
        model.s_money =  [resultSet stringForColumn:@"s_money"];
        model.s_type_id =  [resultSet stringForColumn:@"s_type_id"];
        model.s_desc =  [resultSet stringForColumn:@"s_desc"];
        model.s_year =  [resultSet stringForColumn:@"s_year"];
        model.s_month =  [resultSet stringForColumn:@"s_month"];
        model.s_day =  [resultSet stringForColumn:@"s_day"];
        model.s_city = [resultSet stringForColumn:@"s_city"];
        [dataArr addObject:model];
        
    }
    
    return dataArr;
}


- (NSMutableArray<WYHQBillModel *> *)searchData:(NSString *)tableName {
    return [self searchData:nil tableName:tableName];
}

- (NSMutableArray <WYHQBillModel *> *)searchAllData {
    if ([self.fmdb open]) {
        
        // 根据请求参数查询数据
        FMResultSet *resultSet = nil;
        
        resultSet = [self.fmdb executeQuery:@"SELECT * FROM sqlite_master where type='table';"];
        
        NSMutableArray *tableNames = [NSMutableArray array];
        
        // 遍历查询结果
        while (resultSet.next) {
            
            NSString *str1 = [resultSet stringForColumnIndex:1];
            NSLog(@"_____%@",str1);
            [tableNames addObject:str1];
        }
        
        NSMutableArray *resultArr = [NSMutableArray array];
        
        for (int i = 0; i < tableNames.count; i++) {
            NSString *tableName = tableNames[i];
            
            NSArray *results = [self searchData:tableName];
            [resultArr addObjectsFromArray:results];
            if (i == tableNames.count - 1) {
               return resultArr;
            }
        }
        return resultArr;
    }else{
        return nil;
    }
}

- (NSString *)setTableName:(NSString *)name {
    return [NSString stringWithFormat:@"ZYZ%@",name];
}

@end
