#import <Foundation/Foundation.h>
#import "CostMapOrderEntity.h"
typedef void(^DBResultBlock)(NSMutableArray <CostMapOrderEntity *> *result, NSError *error);
@interface CostMapSQLManager : NSObject
+ (instancetype)share;
- (BOOL)isTableExist:(NSString *)tableName;
- (void)creatNewDataBase:(NSString *)name;
- (void)updateData:(CostMapOrderEntity *)model tableName:(NSString *)tableName;
- (void)insertData:(CostMapOrderEntity *)model tableName:(NSString *)tableName;
- (NSMutableArray <CostMapOrderEntity *> *)searchData:(NSString *)tableName;
- (NSMutableArray <CostMapOrderEntity *> *)searchData:(CostMapOrderEntity *)model tableName:(NSString *)tableName;
- (void)searchData:(NSString *)tableName
              year:(NSString *)year
             month:(NSString *)month
               day:(NSString *)day
            result:(DBResultBlock)resultAction;
- (void)clearData:(NSString *)tableName;
- (NSMutableArray <CostMapOrderEntity *> *)searchAllData;
- (void)deleteData:(NSString*)tableName yka_id:(NSString *)yka_id;
@end
