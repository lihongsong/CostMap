//
//  WYHQWYHQEditBillToolBarCell.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQWYHQEditBillToolBarCell.h"
#import "WYHQBillModel.h"
#import "WYHQBillTool.h"

@interface WYHQWYHQEditBillToolBarCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@end

@implementation WYHQWYHQEditBillToolBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setBillType:(WYHQBillType)billType {
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
        image = [WYHQBillTool typePressedImage:self.billType];
    } else {
        image = [WYHQBillTool typeImage:self.billType];
    }
    
    self.typeImageView.image = [UIImage imageNamed:image];
}

@end
