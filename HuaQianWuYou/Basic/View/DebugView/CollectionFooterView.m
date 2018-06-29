//
//  CollectionFooterView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CollectionFooterView.h"
#import "ZYZControl.h"
#import "UtilitiesDefine.h"

@interface CollectionFooterView()
@property(nonatomic,strong)UIButton *jumpButton;
@property(nonatomic,strong)UIButton *confirmButton;
@end

@implementation CollectionFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.jumpButton];
        [self addSubview:self.confirmButton];
    }
    return self;
}

-(UIButton*)jumpButton{
    if (!_jumpButton) {
        _jumpButton = [ZYZControl createButtonWithFrame:CGRectMake(0,0, SWidth/2.0, 40) target:self SEL:@selector(jumpButtonClick:) title:@"跳过"];
        _jumpButton.backgroundColor = [UIColor testNormalColor];
        
    }
    return _jumpButton;
}

-(UIButton*)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [ZYZControl createButtonWithFrame:CGRectMake(SWidth/2.0, 0, SWidth/2.0, 40) target:self SEL:@selector(confirmButtonClick:) title:@"确认"];
        _confirmButton.backgroundColor = [UIColor testSelectColor];
        
    }
    return _confirmButton;
}

#pragma mark--确认
-(void)confirmButtonClick:(UIButton*)but{
    if ([self.delegate respondsToSelector:@selector(footerConfirmClick)]) {
        but.enabled = false;
        [self.delegate footerConfirmClick];
    }
}

#pragma mark--确认
-(void)jumpButtonClick:(UIButton*)but{
    if ([self.delegate respondsToSelector:@selector(footerJumpClick)]) {
        but.enabled = false;
        [self.delegate footerJumpClick];
    }
}


@end
