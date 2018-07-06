//
//  PopView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "PopView.h"
@interface PopView ()

@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;


@end

@implementation PopView


- (void)awakeFromNib{
    [super awakeFromNib];
    _closeImageView.userInteractionEnabled = YES;
    _contentImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
    [_closeImageView addGestureRecognizer:tap];
    UITapGestureRecognizer *contentImageTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentImageViewAction)];
    [_contentImageView addGestureRecognizer:contentImageTap];
}


# pragma mark 关闭

- (void)closeAction{
    [self removeFromSuperview];
}

- (void)tapContentImageViewAction{
    if (self.block != nil) {
        self.block();
    }
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
