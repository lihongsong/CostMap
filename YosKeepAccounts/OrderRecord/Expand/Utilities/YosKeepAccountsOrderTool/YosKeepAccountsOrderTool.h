#import <Foundation/Foundation.h>
#define YosKeepAccountsOrderTypeFoodName   @"餐饮"
#define YosKeepAccountsOrderTypeBuyName    @"购物"
#define YosKeepAccountsOrderTypeFriendName @"人情"
#define YosKeepAccountsOrderTypePlayName   @"游玩"
#define YosKeepAccountsOrderTypeHomeName   @"居家"
#define YosKeepAccountsOrderTypeEducaName  @"教育"
#define YosKeepAccountsOrderTypeMedicName  @"医疗"
#define YosKeepAccountsOrderTypeOtherName  @"其他"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsOrderTool : NSObject
+ (UIColor *)colorWithType:(YosKeepAccountsOrderType)orderType;
+ (YosKeepAccountsOrderType)typeWithTypeName:(NSString *)typeName;
+ (NSString *)typeNameWithIndex:(YosKeepAccountsOrderType)index;
+ (NSString *)typeImage:(YosKeepAccountsOrderType)orderType;
+ (NSString *)typePressedImage:(YosKeepAccountsOrderType)type;
+ (NSArray *)allOrderTypes;
+ (NSArray *)allOrderTypesName;
+ (NSArray *)allOrderTypesColor;
+ (NSString *)orderTimeStringWithOrderTime:(NSDate *)orderTime;
+ (NSDate *)orderTimeWithOrderTimeString:(NSString *)orderTime;
@end
NS_ASSUME_NONNULL_END
