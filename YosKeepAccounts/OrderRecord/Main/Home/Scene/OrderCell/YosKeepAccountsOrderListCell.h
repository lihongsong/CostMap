#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YosKeepAccountsOrderTableType) {
    YosKeepAccountsOrderTableTypeMonth = 0,
    YosKeepAccountsOrderTableTypeDay = 1,
    YosKeepAccountsOrderTableTypeMonth_Type = 2,
};
NS_ASSUME_NONNULL_BEGIN
@class YosKeepAccountsOrderEntity;
@interface YosKeepAccountsOrderListCell : UITableViewCell
@property (strong, nonatomic) YosKeepAccountsOrderEntity *entity;
@property (assign, nonatomic) YosKeepAccountsOrderTableType tableType;
+ (NSString *)cellID;
+ (UINib *)cellNib;
+ (YosKeepAccountsOrderListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
