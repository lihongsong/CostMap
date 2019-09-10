#import "CostMapSQLManager.h"
#import <FMDB/FMDB.h>
#import <YYModel/YYModel.h>
@interface CostMapSQLManager()
@property(nonatomic, strong) FMDatabase *fmdb;
@property(nonatomic, strong) FMDatabaseQueue *queue;
@end
@implementation CostMapSQLManager
- (instancetype)initWithPrivate
{
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}
+ (instancetype)share
{
    static CostMapSQLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager =[[CostMapSQLManager alloc] initWithPrivate];
        }
    });
    return manager;
}
- (void)createDataBase {
    if (!self.fmdb) {
        self.fmdb = [[FMDatabase alloc] initWithPath:[self getDBPath]];
    }
}
- (BOOL)isTableExist:(NSString *)tableName {
    FMResultSet *rs = [self.fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", [self setTableName:tableName]];
    while ([rs next])
    {
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
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (yka_id integer primary key AUTOINCREMENT,yka_time Text, yka_type_name Text, yka_wealth Text, yka_type_id Text, yka_desc Text, yka_year Text,yka_month Text, yka_day Text, yka_city Text, yka_username Text,yka_firend_name Text,yka_firend_phone Text);", [self setTableName:name]];
    [self.fmdb executeUpdate:sql];
}
- (void)creatNewDataBase:(NSString *)name{
    if(![self.fmdb open]) {
        return;
    }
    if (![self isTableExist:name]) {
        [self defaultData:name];
    }
}
- (void)updateData:(CostMapOrderEntity *)model tableName:(NSString *)tableName  {
    if(![self.fmdb open]) {
        return;
    }
    if (![self isTableExist:tableName]) {
        [self creatNewDataBase:tableName];
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET yka_time = '%@', yka_type_name = '%@' ,yka_wealth = '%@', yka_type_id = '%@', yka_desc = '%@', yka_year = '%@', yka_month = '%@', yka_day = '%@', yka_city = '%@', yka_username = '%@', yka_firend_name = '%@', yka_firend_phone = '%@' WHERE yka_id = %@", [self setTableName:tableName],
                     model.yka_time ,
                     model.yka_type_name,
                     model.yka_wealth,
                     model.yka_type_id,
                     model.yka_desc ,
                     model.yka_year,
                     model.yka_month,
                     model.yka_day,
                     model.yka_city,
                     model.yka_username,
                     model.yka_firend_name,
                     model.yka_firend_phone,
                     model.yka_id];
  BOOL updateSucess = [self.fmdb executeUpdate:sql];
    if (!updateSucess) {
        NSLog(@"error = %@", [self.fmdb lastErrorMessage]);
    }
}
- (void)insertData:(CostMapOrderEntity *)model tableName:(NSString *)tableName {
    
//    if (StrIsEmpty(model.yka_username)) {
//        return ;
//    }
    
    if([self.fmdb open]){
        if (![self isTableExist:tableName]) {
            [self creatNewDataBase:tableName];
        }
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (yka_time, yka_type_name, yka_wealth, yka_type_id, yka_desc ,yka_year ,yka_month, yka_day, yka_city, yka_username, yka_firend_name, yka_firend_phone) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [self setTableName:tableName]];
        __unused BOOL result =
        [self.fmdb executeUpdate:sql,model.yka_time ,
         model.yka_type_name,
         model.yka_wealth,
         model.yka_type_id,
         model.yka_desc,
         model.yka_year,
         model.yka_month,
         model.yka_day,
         model.yka_city,
         model.yka_username,
         model.yka_firend_name,
         model.yka_firend_phone];
    }
}
- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction {
    if(![self.fmdb open]) {
        return;
    }
    NSMutableString *sqlString = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE ", [self setTableName:tableName]];
    if (!year && !month && !day) {
        !resultAction?:resultAction( nil, [NSError errorWithDomain:@"error" code:0 userInfo:nil]);
        return ;
    }
    if (year) {
        [sqlString appendString:[NSString stringWithFormat:@"yka_year= %@",year]];
    }
    if (month) {
        if (year) {
            [sqlString appendString:@" AND "];
        }
        [sqlString appendString:[NSString stringWithFormat:@"yka_month= %@",month]];
    }
    if (day) {
        if (year || month) {
            [sqlString appendString:@" AND "];
        }
        [sqlString appendString:[NSString stringWithFormat:@"yka_day= %@",day]];
    }
    FMResultSet *resultSet = [self.fmdb executeQuery:sqlString];
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        CostMapOrderEntity *model = [[CostMapOrderEntity alloc] init];
        model.yka_id =  @([resultSet intForColumn:@"yka_id"]).stringValue;
        model.yka_time =  [resultSet stringForColumn:@"yka_time"];
        model.yka_type_name =  [resultSet stringForColumn:@"yka_type_name"];
        model.yka_wealth =  [resultSet stringForColumn:@"yka_wealth"];
        model.yka_type_id =  [resultSet stringForColumn:@"yka_type_id"];
        model.yka_desc =  [resultSet stringForColumn:@"yka_desc"];
        model.yka_year =  [resultSet stringForColumn:@"yka_year"];
        model.yka_month =  [resultSet stringForColumn:@"yka_month"];
        model.yka_day =  [resultSet stringForColumn:@"yka_day"];
        model.yka_city = [resultSet stringForColumn:@"yka_city"];
        model.yka_username = [resultSet stringForColumn:@"yka_username"];
        model.yka_firend_name = [resultSet stringForColumn:@"yka_firend_name"];
        model.yka_firend_phone = [resultSet stringForColumn:@"yka_firend_phone"];
        [dataArr addObject:model];
    }
    if (resultAction) {
        resultAction(dataArr, nil);
    }
}
- (void)deleteData:(NSString *)tableName yka_id:(NSString *)yka_id {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where yka_id=%@",[self setTableName:tableName],yka_id];
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
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath =[[documentsPath firstObject] stringByAppendingPathComponent:@"WuYouQianBao.db"];
    NSLog(@"%@", dbPath);
    return dbPath;
}
- (NSMutableArray<CostMapOrderEntity *> *)searchData:(CostMapOrderEntity *)model tableName:(NSString *)tableName {
    
//    if (StrIsEmpty(model.yka_username)) {
//        return [NSMutableArray array];
//    }
    
    if(![self.fmdb open]) {
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
            [searchValue appendString:@" AND "];
        }
    }
    
    if (!StrIsEmpty(searchValue)) {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", [self setTableName:tableName], searchValue];
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@", [self setTableName:tableName]];
    }
    
    FMResultSet *resultSet = [self.fmdb executeQuery:sql];
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    while ([resultSet next]) {
        CostMapOrderEntity *model = [[CostMapOrderEntity alloc] init];
        model.yka_id =  @([resultSet intForColumn:@"yka_id"]).stringValue;
        model.yka_time =  [resultSet stringForColumn:@"yka_time"];
        model.yka_type_name =  [resultSet stringForColumn:@"yka_type_name"];
        model.yka_wealth =  [resultSet stringForColumn:@"yka_wealth"];
        model.yka_type_id =  [resultSet stringForColumn:@"yka_type_id"];
        model.yka_desc =  [resultSet stringForColumn:@"yka_desc"];
        model.yka_year =  [resultSet stringForColumn:@"yka_year"];
        model.yka_month =  [resultSet stringForColumn:@"yka_month"];
        model.yka_day =  [resultSet stringForColumn:@"yka_day"];
        model.yka_city = [resultSet stringForColumn:@"yka_city"];
        model.yka_username = [resultSet stringForColumn:@"yka_username"];
        model.yka_firend_name = [resultSet stringForColumn:@"yka_firend_name"];
        model.yka_firend_phone = [resultSet stringForColumn:@"yka_firend_phone"];
        [dataArr addObject:model];
    }
    return dataArr;
}
- (NSMutableArray<CostMapOrderEntity *> *)searchData:(NSString *)tableName {
    return [self searchData:nil tableName:tableName];
}
- (NSMutableArray <CostMapOrderEntity *> *)searchAllData {
    if ([self.fmdb open]) {
        FMResultSet *resultSet = nil;
        resultSet = [self.fmdb executeQuery:@"SELECT * FROM sqlite_master where type='table';"];
        NSMutableArray *tableNames = [NSMutableArray array];
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
