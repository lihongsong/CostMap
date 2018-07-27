//
//  NavigationView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "NavigationView.h"
#import "RightItemButton.h"

@interface NavigationView()
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIImageView *arrowImage;
@property (strong, nonatomic) RightItemButton *rightItemButton;

@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUpUI];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)changeNavigationType:(NSDictionary *)typeDic{
    if(!StrIsEmpty([typeDic objectForKey:@"bgColor"])){
        self.backgroundColor = [UIColor hj_colorWithHexString:[typeDic objectForKey:@"bgColor"]];
    }
    if ([[typeDic objectForKey:@"backKeyHide"] integerValue]) {
        NSDictionary *leftDic = [typeDic objectForKey:@"left"];
        self.backButton.hidden = true;
        if(leftDic != nil && !StrIsEmpty([leftDic objectForKey:@"text"])){
            self.leftItemButton.hidden = false;
            self.arrowImage.hidden = false;
            NSString *leftTitle = [[leftDic objectForKey:@"text"] stringByReplacingOccurrencesOfString:@"location:" withString:@""];
            if (leftTitle.length > 0) {
                self.leftLabel.text = leftTitle;
//                [self.leftItemButton setTitle:leftTitle forState:UIControlStateNormal];
            }else{
                leftTitle = self.leftItemButton.titleLabel.text;
            }
            if (!StrIsEmpty([leftDic objectForKey:@"textColor"])) {
//                [self.leftItemButton setTitleColor:[UIColor hj_colorWithHexString:[leftDic objectForKey:@"textColor"]] forState:UIControlStateNormal];
                self.leftLabel.textColor = [UIColor hj_colorWithHexString:[leftDic objectForKey:@"textColor"]];
            }
        }else{
            self.leftItemButton.hidden = true;
            self.arrowImage.hidden = true;
        }
    }else{
        self.leftItemButton.hidden = true;
        self.arrowImage.hidden = true;
        self.backButton.hidden = false;
    }
    
    NSDictionary *rightDic = [typeDic objectForKey:@"right"];
    if (rightDic != nil && !StrIsEmpty([rightDic objectForKey:@"text"])) {
        self.rightItemButton.hidden = false;
        [self.rightItemButton setTitle:[rightDic objectForKey:@"text"] forState:UIControlStateNormal];
        if (![[rightDic objectForKey:@"text"] isEqualToString:@"精准推荐"]){
            [self.rightItemButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if (!StrIsEmpty([rightDic objectForKey:@"textColor"])) {
            [self.rightItemButton setTitleColor:[UIColor hj_colorWithHexString:[rightDic objectForKey:@"textColor"]] forState:UIControlStateNormal];
        }
    }else{
        self.rightItemButton.hidden = true;
    }
    
    NSDictionary *titleDic = [typeDic objectForKey:@"title"];
    if(titleDic != nil && !StrIsEmpty([titleDic objectForKey:@"text"])){
        [self.titleButton setTitle:[titleDic objectForKey:@"text"] forState:UIControlStateNormal];
        if (!StrIsEmpty([titleDic objectForKey:@"textColor"])) {
            [self.titleButton setTitleColor:[UIColor hj_colorWithHexString:[titleDic objectForKey:@"textColor"]] forState:UIControlStateNormal];
        }
    }
}

-(void)setUpUI{
    WeakObj(self);
    [self addSubview:self.leftItemButton];
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
//        make.width.mas_greaterThanOrEqualTo(55);
//        make.width.mas_greaterThanOrEqualTo(80);
    }];
//    [self.leftItemButton setTitle:@"定位中" forState:UIControlStateNormal];
    
    UIImageView *locateIcon = [UIImageView new];
    [self.leftItemButton addSubview:locateIcon];
    [locateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 13));
        make.centerY.left.mas_equalTo(self.leftItemButton);
    }];
    
//    UILabel *leftT = [UILabel new];
    self.leftLabel = [UILabel new];
    [self.leftItemButton addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locateIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    self.leftLabel.text = @"定位中...";
    self.leftLabel.textColor = HJHexColor(0x333333);
    self.leftLabel.font = [UIFont systemFontOfSize:13];
    
    locateIcon.image = [UIImage imageNamed:@"navbar_location_02"];
    
    self.arrowImage = [UIImageView new];
    [self addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.leftLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5, 3));
    }];
    self.arrowImage.image = [UIImage imageNamed:@"navbar_triangle"];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];
    
    self.backButton = [UIButton new];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.mas_equalTo(self.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.hidden = true;
    [self addSubview:self.rightItemButton];
    [self addSubview:self.titleButton];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
}

-(LeftItemButton *)leftItemButton
{
    if (_leftItemButton == nil) {
        _leftItemButton = [LeftItemButton buttonWithType:UIButtonTypeCustom];
        [_leftItemButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItemButton;
}


-(RightItemButton *)rightItemButton
{
    if (_rightItemButton == nil) {
        _rightItemButton = [RightItemButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.frame = CGRectMake(SWidth - 70 - 10, 0, 70, 44);
        [_rightItemButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rightItemButton setImage:[UIImage imageNamed:@"navbar_accurate"] forState:UIControlStateNormal];
        [_rightItemButton setTitle:@"精准推荐" forState:UIControlStateNormal];
        [_rightItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _rightItemButton;
}

-(UIButton *)titleButton
{
    if (_titleButton == nil) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _titleButton.frame = CGRectMake(CGRectGetMaxX(self.leftItemButton.frame), 0, self.rightItemButton.hj_x -CGRectGetMaxX(self.leftItemButton.frame), 44);
        [_titleButton setTitle:@"" forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont NavigationTitleFont];
        [_titleButton.titleLabel setAdjustsFontSizeToFitWidth:true];

    }
    return _titleButton;
}

#pragma mark 定位点击
- (void)leftButtonClick{
    if ([self.delegate respondsToSelector:@selector(locationButtonClick)]) {
        [self.delegate locationButtonClick];
    }
}

#pragma mark 返回点击
- (void)backPage{
    if ([self.delegate respondsToSelector:@selector(webGoBack)]) {
        [self.delegate webGoBack];
    }
}

#pragma mark 导航栏右边点击事件
- (void)rightButtonClick{
    if ([self.delegate respondsToSelector:@selector(rightButtonItemClick)]) {
        [self.delegate rightButtonItemClick];
    }
}

@end
