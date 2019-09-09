#import <Foundation/Foundation.h>
#define YosKeepAccountsOrderTypeFoodName   @"repast"
#define YosKeepAccountsOrderTypeBuyName    @"shopping"
#define YosKeepAccountsOrderTypeFriendName @"relation"
#define YosKeepAccountsOrderTypePlayName   @"play"
#define YosKeepAccountsOrderTypeHomeName   @"family"
#define YosKeepAccountsOrderTypeEducaName  @"education"
#define YosKeepAccountsOrderTypeMedicName  @"medical"
#define YosKeepAccountsOrderTypeOtherName  @"other"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsOrderTool : NSObject
+ (UIColor *)colorWithType:(YosKeepAccountsOrderType)orderType;
+ (YosKeepAccountsOrderType)typeWithTypeName:(NSString *)typeName;
+ (NSString *)typeNameWithIndex:(YosKeepAccountsOrderType)index;
+ (NSString *)typeImage:(YosKeepAccountsOrderType)orderType;
+ (NSString *)typePressedImage:(YosKeepAccountsOrderType)type;
+ (NSArray *)allOrderTypes;
+ (NSArray *)allOrderTypesName;
+ (NSArray *)allOrderShortTypesName;
+ (NSArray *)allOrderTypesColor;
+ (NSString *)orderTimeStringWithOrderTime:(NSDate *)orderTime;
+ (NSDate *)orderTimeWithOrderTimeString:(NSString *)orderTime;
@end
NS_ASSUME_NONNULL_END
