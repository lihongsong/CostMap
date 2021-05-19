#import "CostMapBasePresenter.h"
#import "CostMapOrderEntity.h"

#import <HJMediator/HJMediator.h>
NS_ASSUME_NONNULL_BEGIN
@interface CostMapEditOrderPresenter : CostMapBasePresenter <HJMediatorTargetInstance>
@property (nonatomic, strong, nullable) CostMapOrderEntity *orderEntity;
@property (nonatomic, copy) NSString *orderTypeStr;
+ (instancetype)instance;
@end
NS_ASSUME_NONNULL_END
