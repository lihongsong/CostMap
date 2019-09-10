#import "CostMapEditOrderToolBarCell.h"
#import "CostMapOrderEntity.h"
#import "CostMapOrderTool.h"
@interface CostMapEditOrderToolBarCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageScene;
@end
@implementation CostMapEditOrderToolBarCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setOrderType:(CostMapOrderType)orderType {
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
        image = [CostMapOrderTool typePressedImage:self.orderType];
        self.typeImageScene.tintColor = [CostMapOrderTool colorWithType:self.orderType];
    } else {
        image = [CostMapOrderTool typeImage:self.orderType];
        self.typeImageScene.tintColor = HJHexColor(0x999999);
    }
    self.typeImageScene.image = [UIImage imageNamed:image];
}
@end
