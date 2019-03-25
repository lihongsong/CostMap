#import <Foundation/Foundation.h>
#import "YosKeepAccountsOrderEntity.h"
typedef void(^DBResultBlock)(NSMutableArray <YosKeepAccountsOrderEntity *> *result, NSError *error);
@interface YosKeepAccountsSQLManager : NSObject
+ (instancetype)share;
- (BOOL)isTableExist:(NSString *)tableName;
- (void)creatNewDataBase:(NSString *)name;
- (void)updateData:(YosKeepAccountsOrderEntity *)model tableName:(NSString *)tableName;
- (void)insertData:(YosKeepAccountsOrderEntity *)model tableName:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsOrderEntity *> *)searchData:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsOrderEntity *> *)searchData:(YosKeepAccountsOrderEntity *)model tableName:(NSString *)tableName;
- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction;
- (void)clearData:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsOrderEntity *> *)searchAllData;
- (void)deleteData:(NSString*)tableName yka_id:(NSString *)yka_id;
@end
