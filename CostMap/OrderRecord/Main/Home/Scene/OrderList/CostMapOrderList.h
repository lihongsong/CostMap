#import <UIKit/UIKit.h>
#import "CostMapOrderListCell.h"
@class CostMapOrderEntity;
NS_ASSUME_NONNULL_BEGIN
typedef void (^CostMapOrderDeleteAction) (UITableViewCellEditingStyle editingStyle, CostMapOrderEntity *model);
typedef void (^CostMapOrderSelectAction) (CostMapOrderEntity *model);
@interface CostMapOrderList : UITableView
@property (assign, nonatomic) CostMapOrderTableType tableType;
@property (assign, nonatomic) BOOL enableDelete;
@property (strong, nonatomic) NSArray <CostMapOrderEntity *> *entitys;
@property (copy, nonatomic) CostMapOrderDeleteAction deleteAction;
@property (copy, nonatomic) CostMapOrderSelectAction selectAction;
@end
NS_ASSUME_NONNULL_END
