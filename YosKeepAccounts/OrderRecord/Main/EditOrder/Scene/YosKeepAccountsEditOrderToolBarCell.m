#import "YosKeepAccountsEditOrderToolBarCell.h"
#import "YosKeepAccountsOrderEntity.h"
#import "YosKeepAccountsOrderTool.h"
@interface YosKeepAccountsEditOrderToolBarCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageScene;
@end
@implementation YosKeepAccountsEditOrderToolBarCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setOrderType:(YosKeepAccountsOrderType)orderType {
    _orderType = orderType;
    [self updateImage];
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImage];
}
- (void)updateImage {
    NSString *image;
    if (self.selected) {
        image = [YosKeepAccountsOrderTool typePressedImage:self.orderType];
    } else {
        image = [YosKeepAccountsOrderTool typeImage:self.orderType];
    }
    self.typeImageScene.image = [UIImage imageNamed:image];
}
@end
