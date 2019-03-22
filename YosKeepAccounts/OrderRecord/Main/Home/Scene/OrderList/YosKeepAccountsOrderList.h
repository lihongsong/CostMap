#import <UIKit/UIKit.h>
#import "YosKeepAccountsOrderListCell.h"
@class YosKeepAccountsOrderEntity;
NS_ASSUME_NONNULL_BEGIN
typedef void (^YosKeepAccountsOrderDeleteAction) (UITableViewCellEditingStyle editingStyle, YosKeepAccountsOrderEntity *model);
typedef void (^YosKeepAccountsOrderSelectAction) (YosKeepAccountsOrderEntity *model);
@interface YosKeepAccountsOrderList : UITableView
@property (assign, nonatomic) YosKeepAccountsOrderTableType tableType;
@property (assign, nonatomic) BOOL enableDelete;
@property (strong, nonatomic) NSArray <YosKeepAccountsOrderEntity *> *entitys;
@property (copy, nonatomic) YosKeepAccountsOrderDeleteAction deleteAction;
@property (copy, nonatomic) YosKeepAccountsOrderSelectAction selectAction;
@end
NS_ASSUME_NONNULL_END
