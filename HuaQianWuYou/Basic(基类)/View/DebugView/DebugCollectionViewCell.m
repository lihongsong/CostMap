//
//  DebugCollectionViewCell.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/7.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DebugCollectionViewCell.h"

@implementation DebugCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)stateButtonClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            sender.backgroundColor = [UIColor testSelectColor];
        }else{
            sender.backgroundColor = [UIColor testNormalColor];
        }
        if ([self.delegate respondsToSelector:@selector(selectApi:)]) {
            [self.delegate selectApi:sender.tag];
        }
    }
}



@end
