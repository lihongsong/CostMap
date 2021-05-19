#import <Foundation/Foundation.h>
@interface CostMapOrderEntity: NSObject

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
@property (nonatomic, copy) NSString *yka_firend_name;
@property (nonatomic, copy) NSString *yka_firend_phone;


- (NSString *)description;
@end
