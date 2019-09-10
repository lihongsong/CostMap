#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CostMapOrderTableType) {
    CostMapOrderTableTypeMonth = 0,
    CostMapOrderTableTypeDay = 1,
    CostMapOrderTableTypeMonth_Type = 2,
};
NS_ASSUME_NONNULL_BEGIN
@class CostMapOrderEntity;
@interface CostMapOrderListCell : UITableViewCell
@property (strong, nonatomic) CostMapOrderEntity *entity;
@property (assign, nonatomic) CostMapOrderTableType tableType;
+ (NSString *)cellID;
+ (UINib *)cellNib;
+ (CostMapOrderListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
