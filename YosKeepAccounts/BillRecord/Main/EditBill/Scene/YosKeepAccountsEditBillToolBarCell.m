#import "YosKeepAccountsEditBillToolBarCell.h"
#import "YosKeepAccountsBillEntity.h"
#import "YosKeepAccountsBillTool.h"
@interface YosKeepAccountsEditBillToolBarCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageScene;
@end
@implementation YosKeepAccountsEditBillToolBarCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setBillType:(YosKeepAccountsBillType)billType {
    _billType = billType;
    [self updateImage];
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImage];
}
- (void)updateImage {
    NSString *image;
    if (self.selected) {
        image = [YosKeepAccountsBillTool typePressedImage:self.billType];
    } else {
        image = [YosKeepAccountsBillTool typeImage:self.billType];
    }
    self.typeImageScene.image = [UIImage imageNamed:image];
}
@end
