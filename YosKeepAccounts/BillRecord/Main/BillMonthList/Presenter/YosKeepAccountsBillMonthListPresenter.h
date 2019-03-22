#import "YosKeepAccountsBasePresenter.h"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsBillMonthListPresenter : YosKeepAccountsBasePresenter
@property (copy, nonatomic) NSString *year;
@property (copy, nonatomic) NSString *month;
@property (copy, nonatomic) NSString *bill_type_id;
@end
NS_ASSUME_NONNULL_END
