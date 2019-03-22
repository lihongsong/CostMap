#import "YosKeepAccountsBasePresenter.h"
#import "YosKeepAccountsBillEntity.h"
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsEditBillPresenter : YosKeepAccountsBasePresenter<HJMediatorTargetInstance>
@property (nonatomic, strong, nullable) YosKeepAccountsBillEntity *billEntity;
@property (nonatomic, copy) NSString *billTypeStr;
@end
NS_ASSUME_NONNULL_END
