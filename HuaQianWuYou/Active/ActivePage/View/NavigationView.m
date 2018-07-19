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
@property(strong,nonatomic)UIButton *titleButton;
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
                [self.leftItemButton setTitle:leftTitle forState:UIControlStateNormal];
            }else{
                leftTitle = self.leftItemButton.titleLabel.text;
            }
            //NSLog(@"____%f___",[leftTitle hj_sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToWidth:SWidth].width);
            if([leftTitle hj_sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToWidth:SWidth].width >= 40 && [leftTitle hj_sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToWidth:SWidth].width <45){
                self.leftItemButton.frame = CGRectMake(10, 0, 60, 44);
            }else if ([leftTitle hj_sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToWidth:SWidth].width < 40 && [leftTitle hj_sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToWidth:SWidth].width > 20){
                self.leftItemButton.frame = CGRectMake(10, 0, 48, 44);
            }else{
                self.leftItemButton.frame = CGRectMake(10, 0, 70, 44);
            }
            self.arrowImage.frame = CGRectMake(CGRectGetMaxX(self.leftItemButton.frame) + 5, 18.5, 5, 3);
            
            if (!StrIsEmpty([leftDic objectForKey:@"textColor"])) {
                [self.leftItemButton setTitleColor:[UIColor hj_colorWithHexString:[leftDic objectForKey:@"textColor"]] forState:UIControlStateNormal];
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
    [self addSubview:self.leftItemButton];
    self.arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftItemButton.frame) + 5, 18.5, 5, 3)];
    self.arrowImage.image = [UIImage imageNamed:@"navbar_triangle"];
    [self addSubview:self.leftItemButton];
    [self addSubview:self.arrowImage];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateHighlighted];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self addSubview:self.backButton];
    
    [self.backButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.hidden = true;
    [self addSubview:self.rightItemButton];
    [self addSubview:self.titleButton];
}

-(LeftItemButton *)leftItemButton
{
    if (_leftItemButton == nil) {
        _leftItemButton = [LeftItemButton buttonWithType:UIButtonTypeCustom];
        _leftItemButton.frame = CGRectMake(10, 0, 70, 44);
        [_leftItemButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftItemButton setImage:[UIImage imageNamed:@"navbar_location_02"] forState:UIControlStateNormal];
        [_leftItemButton setTitle:@"定位中..." forState:UIControlStateNormal];
        [_leftItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _leftItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        _leftItemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
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
        _titleButton.frame = CGRectMake(CGRectGetMaxX(self.leftItemButton.frame), 0, self.rightItemButton.hj_x -CGRectGetMaxX(self.leftItemButton.frame), 44);
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
