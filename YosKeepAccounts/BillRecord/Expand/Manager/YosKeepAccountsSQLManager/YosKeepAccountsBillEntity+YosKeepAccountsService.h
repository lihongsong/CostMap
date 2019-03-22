#import "YosKeepAccountsBillEntity.h"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsBillEntity (YosKeepAccountsService)
+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills;
+ (NSArray *)templateBillArrayWithBills:(NSArray *)bills sumMoney:(double * _Nullable)sumMoney;
@end
NS_ASSUME_NONNULL_END
