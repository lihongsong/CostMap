//
//  HQWYReturnToDetainView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYReturnToDetainView.h"

@interface HQWYReturnToDetainView()
@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, strong) UIView *hudView;

@property(nonatomic,strong)UIButton *cancleButton;
@property(nonatomic,strong)UIButton *promptButton;
@end

@implementation HQWYReturnToDetainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUpUI:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)setUpUI:(CGRect)frame{
    [self addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.mas_top).mas_offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    UILabel *topLabel = [ZYZControl createLabelWithFrame:CGRectMake(45, 15, frame.size.width - 90, 30) Font:[UIFont normalFont] Text:@"下一笔钱马上来......"];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:topLabel];
    
    [self addSubview:self.countTimeLabel];
    [self.countTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancleButton.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(40);
    }];
    UILabel *bigLabel = [[UILabel alloc]init];
     [self addSubview:bigLabel];
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countTimeLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    bigLabel.text = @"申请越多，成功率越高";
    bigLabel.font = [UIFont navigationRightFont];
    bigLabel.textAlignment = NSTextAlignmentCenter;
   
    [self addSubview:self.promptButton];
    [self.promptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-45);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView =  [[UIView alloc]init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.promptButton.mas_centerX).mas_offset(0);
        make.centerY.mas_equalTo(self.promptButton.mas_centerY).mas_offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = [UIColor hj_colorWithHexString:@"#333333"];
    
}

-(UIButton *)cancleButton
{
    if (_cancleButton == nil) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancleButton setImage:[UIImage imageNamed:@"navbar_close"] forState:UIControlStateNormal];
    }
    return _cancleButton;
}

-(UIButton *)promptButton
{
    if (_promptButton == nil) {
        _promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_promptButton addTarget:self action:@selector(promptButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_promptButton setTitle:@"今日不再提示" forState:UIControlStateNormal];
        [_promptButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _promptButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _promptButton;
}

-(UILabel *)countTimeLabel
{
    if (_countTimeLabel == nil) {
        _countTimeLabel = [[UILabel alloc]init];
        //[ZYZControl createLabelWithFrame:CGRectMake(15, CGRectGetMaxY(self.cancleButton.frame) + 15, SWidth - 30 * 2, 40) Font:[UIFont NavigationTitleFont] Text:@"3"];
        _countTimeLabel.font = [UIFont NavigationTitleFont];
        _countTimeLabel.text = @"3";
        _countTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countTimeLabel;
}

#pragma mark 取消点击
- (void)cancleButtonClick{
    if ([self.delegate respondsToSelector:@selector(cancleAlertClick)]) {
        [self.delegate cancleAlertClick];
    }
}

#pragma mark 今日不再提示点击事件
- (void)promptButtonClick{
    if ([self.delegate respondsToSelector:@selector(nonePromptButtonClick)]) {
        [self.delegate nonePromptButtonClick];
    }
}

@end
