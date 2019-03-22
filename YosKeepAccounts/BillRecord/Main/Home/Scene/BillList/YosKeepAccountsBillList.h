#import <UIKit/UIKit.h>
#import "YosKeepAccountsBillListCell.h"
@class YosKeepAccountsBillEntity;
NS_ASSUME_NONNULL_BEGIN
typedef void (^YosKeepAccountsBillDeleteAction) (UITableViewCellEditingStyle editingStyle, YosKeepAccountsBillEntity *model);
typedef void (^YosKeepAccountsBillSelectAction) (YosKeepAccountsBillEntity *model);
@interface YosKeepAccountsBillList : UITableView
@property (assign, nonatomic) YosKeepAccountsBillTableType tableType;
@property (assign, nonatomic) BOOL enableDelete;
@property (strong, nonatomic) NSArray <YosKeepAccountsBillEntity *> *entitys;
@property (copy, nonatomic) YosKeepAccountsBillDeleteAction deleteAction;
@property (copy, nonatomic) YosKeepAccountsBillSelectAction selectAction;
@end
NS_ASSUME_NONNULL_END
