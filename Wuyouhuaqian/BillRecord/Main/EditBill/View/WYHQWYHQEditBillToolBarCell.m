//
//  WYHQWYHQEditBillToolBarCell.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQWYHQEditBillToolBarCell.h"
#import "WYHQBillModel.h"

@interface WYHQWYHQEditBillToolBarCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@end

@implementation WYHQWYHQEditBillToolBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTypeStr:(NSString *)typeStr {
    _typeStr = typeStr.copy;
    [self updateImage];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImage];
}

- (void)updateImage {
    NSString *image;
    if (self.selected) {
        image = [WYHQBillModel getTypePressedImage:self.typeStr];
    } else {
        image = [WYHQBillModel getTypeImage:self.typeStr];
    }
    
    self.typeImageView.image = [UIImage imageNamed:image];
}

@end
