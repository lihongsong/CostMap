#import <Foundation/Foundation.h>
#define CostMapOrderTypeFoodName   @"repast"
#define CostMapOrderTypeBuyName    @"shopping"
#define CostMapOrderTypeFriendName @"relation"
#define CostMapOrderTypePlayName   @"play"
#define CostMapOrderTypeHomeName   @"family"
#define CostMapOrderTypeEducaName  @"education"
#define CostMapOrderTypeMedicName  @"medical"
#define CostMapOrderTypeOtherName  @"other"
NS_ASSUME_NONNULL_BEGIN
@interface CostMapOrderTool : NSObject
+ (UIColor *)colorWithType:(CostMapOrderType)orderType;
+ (CostMapOrderType)typeWithTypeName:(NSString *)typeName;
+ (NSString *)typeNameWithIndex:(CostMapOrderType)index;
+ (NSString *)typeImage:(CostMapOrderType)orderType;
+ (NSString *)typePressedImage:(CostMapOrderType)type;
+ (NSArray *)allOrderTypes;
+ (NSArray *)allOrderTypesName;
+ (NSArray *)allOrderShortTypesName;
+ (NSArray *)allOrderTypesColor;
+ (NSString *)orderTimeStringWithOrderTime:(NSDate *)orderTime;
+ (NSDate *)orderTimeWithOrderTimeString:(NSString *)orderTime;
@end
NS_ASSUME_NONNULL_END
