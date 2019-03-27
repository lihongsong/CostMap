#import "YosKeepAccountsBasePresenter.h"
#import "YosKeepAccountsOrderEntity.h"

#import <HJMediator/HJMediator.h>
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsEditOrderPresenter : YosKeepAccountsBasePresenter <HJMediatorTargetInstance>
@property (nonatomic, strong, nullable) YosKeepAccountsOrderEntity *orderEntity;
@property (nonatomic, copy) NSString *orderTypeStr;
+ (instancetype)instance;
@end
NS_ASSUME_NONNULL_END
