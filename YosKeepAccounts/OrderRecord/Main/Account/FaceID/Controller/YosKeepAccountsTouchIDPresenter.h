#import "YosKeepAccountsBasePresenter.h"
@interface YosKeepAccountsTouchIDPresenter : YosKeepAccountsBasePresenter
@property (nonatomic,copy) void(^rootStartVC)(BOOL isCheckPass);
@end
