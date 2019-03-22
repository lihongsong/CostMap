#import <Foundation/Foundation.h>
#define YosKeepAccountsBillTypeFoodName   @"餐饮"
#define YosKeepAccountsBillTypeBuyName    @"购物"
#define YosKeepAccountsBillTypeFriendName @"交友"
#define YosKeepAccountsBillTypePlayName   @"游玩"
#define YosKeepAccountsBillTypeHomeName   @"居家"
#define YosKeepAccountsBillTypeEducaName  @"教育"
#define YosKeepAccountsBillTypeMedicName  @"医疗"
#define YosKeepAccountsBillTypeOtherName  @"其他"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsBillTool : NSObject
+ (UIColor *)colorWithType:(YosKeepAccountsBillType)billType;
+ (YosKeepAccountsBillType)typeWithTypeName:(NSString *)typeName;
+ (NSString *)typeNameWithIndex:(YosKeepAccountsBillType)index;
+ (NSString *)typeImage:(YosKeepAccountsBillType)billType;
+ (NSString *)typePressedImage:(YosKeepAccountsBillType)type;
+ (NSArray *)allBillTypes;
+ (NSArray *)allBillTypesName;
+ (NSArray *)allBillTypesColor;
+ (NSString *)billTimeStringWithBillTime:(NSDate *)billTime;
+ (NSDate *)billTimeWithBillTimeString:(NSString *)billTime;
@end
NS_ASSUME_NONNULL_END
