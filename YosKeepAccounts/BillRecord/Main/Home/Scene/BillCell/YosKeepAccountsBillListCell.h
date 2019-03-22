#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YosKeepAccountsBillTableType) {
    YosKeepAccountsBillTableTypeMonth = 0,
    YosKeepAccountsBillTableTypeDay = 1,
    YosKeepAccountsBillTableTypeMonth_Type = 2,
};
NS_ASSUME_NONNULL_BEGIN
@class YosKeepAccountsBillEntity;
@interface YosKeepAccountsBillListCell : UITableViewCell
@property (strong, nonatomic) YosKeepAccountsBillEntity *entity;
@property (assign, nonatomic) YosKeepAccountsBillTableType tableType;
+ (NSString *)cellID;
+ (UINib *)cellNib;
+ (YosKeepAccountsBillListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
