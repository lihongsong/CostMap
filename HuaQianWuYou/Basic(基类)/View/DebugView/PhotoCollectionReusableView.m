//
//  PhotoCollectionReusableView.m
//  zhifuERP
//
//  Created by AsiaZhang on 2017/5/16.
//  Copyright © 2017年 zhifu360. All rights reserved.
//

#import "PhotoCollectionReusableView.h"
@interface PhotoCollectionReusableView()

@end

@implementation PhotoCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)addButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addTakePhotoClick:)]) {
        [self.delegate addTakePhotoClick:sender.tag];
    }
}

@end
