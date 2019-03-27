#import <Foundation/Foundation.h>
@interface YosKeepAccountsOrderEntity: NSObject

@property (nonatomic, copy) NSString *yka_id;
@property (nonatomic, copy) NSString *yka_time;
@property (nonatomic, copy) NSString *yka_type_name;
@property (nonatomic, copy) NSString *yka_wealth;
@property (nonatomic, copy) NSString *yka_type_id;
@property (nonatomic, copy) NSString *yka_desc;
@property (nonatomic, copy) NSString *yka_year;
@property (nonatomic, copy) NSString *yka_month;
@property (nonatomic, copy) NSString *yka_day;
@property (nonatomic, copy) NSString *yka_city;
@property (nonatomic, copy) NSString *yka_username;

- (NSString *)description;
#pragma mark 生成 typeid 用于 sTypeID
- (NSString *)getTypeID:(NSString*)type;
@end
