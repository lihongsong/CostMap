#import <Foundation/Foundation.h>
@interface YosKeepAccountsOrderEntity: NSObject
@property (nonatomic, copy) NSString *s_id;
@property (nonatomic, copy) NSString *s_time;
@property (nonatomic, copy) NSString *s_type_name;
@property (nonatomic, copy) NSString *s_wealth;
@property (nonatomic, copy) NSString *s_type_id;
@property (nonatomic, copy) NSString *s_desc;
@property (nonatomic, copy) NSString *s_year;
@property (nonatomic, copy) NSString *s_month;
@property (nonatomic, copy) NSString *s_day;
@property (nonatomic, retain) NSString *s_city;
- (NSString *)description;
#pragma mark 生成 typeid 用于 sTypeID
- (NSString *)getTypeID:(NSString*)type;
@end
