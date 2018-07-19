//
//  RightItemView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "LeftItemView.h"
@interface LeftItemView()
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIImageView *arrowImage;
@end

@implementation LeftItemView


 - (instancetype)initWithFrame:(CGRect)frame{
     self = [super initWithFrame:frame];
     [self setUpUI];
     return self;
 }

- (void)changeType:(NSInteger)type{
    switch (type) {
        case LeftItemViewTypeLocationAndRecommendation:
            {
                self.leftItemButton.hidden = false;
                
                self.arrowImage.hidden = false;
                self.backButton.hidden = true;
            }
            break;
        case LeftItemViewTypeBack:
            {
                self.leftItemButton.hidden = true;
                self.arrowImage.hidden = true;
                self.backButton.hidden = false;
                self.frame = CGRectMake(0, 0, 44, 44);
            }
            break;
        case LeftItemViewTypeRecommendation:
            {
                self.leftItemButton.hidden = true;
                self.arrowImage.hidden = true;
                self.backButton.hidden = true;
            }
            break;
        case LeftItemViewTypeBackAndRecommendation:
            {
                self.leftItemButton.hidden = true;
                self.arrowImage.hidden = true;
                self.backButton.hidden = false;
            }
            break;
        case LeftItemViewTypeNone:
            {
                self.leftItemButton.hidden = true;
                self.arrowImage.hidden = true;
                self.backButton.hidden = true;
            }
            break;
        case LeftItemViewTypeNoneNavigation:
            {
                self.leftItemButton.hidden = true;
                self.arrowImage.hidden = true;
                self.backButton.hidden = true;
            }
            break;
        default:
            break;
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
     //self.backButton.hidden = true;
     
 }

-(LeftItemButton *)leftItemButton
{
    if (_leftItemButton == nil) {
        _leftItemButton = [LeftItemButton buttonWithType:UIButtonTypeCustom];
        _leftItemButton.frame = CGRectMake(0, 0, 70, 40);
        [_leftItemButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_leftItemButton setImage:[UIImage imageNamed:@"navbar_location_02"] forState:UIControlStateNormal];
        [_leftItemButton setTitle:@"定位中..." forState:UIControlStateNormal];
        [_leftItemButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _leftItemButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _leftItemButton;
}

- (void)leftButtonClick{
    if ([self.delegate respondsToSelector:@selector(locationButtonClick)]) {
        [self.delegate locationButtonClick];
    }
}

- (void)backPage{
    if ([self.delegate respondsToSelector:@selector(webGoBack)]) {
        [self.delegate webGoBack];
    }
}

@end
