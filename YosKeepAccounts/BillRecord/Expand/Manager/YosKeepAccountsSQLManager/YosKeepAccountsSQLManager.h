#import <Foundation/Foundation.h>
#import "YosKeepAccountsBillEntity.h"
typedef void(^DBResultBlock)(NSMutableArray <YosKeepAccountsBillEntity *> *result, NSError *error);
@interface YosKeepAccountsSQLManager : NSObject
+ (instancetype)share;
- (BOOL)isTableExist:(NSString *)tableName;
- (void)creatNewDataBase:(NSString *)name;
- (void)updateData:(YosKeepAccountsBillEntity *)model tableName:(NSString *)tableName;
- (void)insertData:(YosKeepAccountsBillEntity *)model tableName:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsBillEntity *> *)searchData:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsBillEntity *> *)searchData:(YosKeepAccountsBillEntity *)model tableName:(NSString *)tableName;
- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction;
- (void)clearData:(NSString *)tableName;
- (NSMutableArray <YosKeepAccountsBillEntity *> *)searchAllData;
- (void)deleteData:(NSString*)tableName s_id:(NSString *)s_id;
@end
