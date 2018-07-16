//
//  SelectTheLoginModeView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "SelectTheLoginModeView.h"

@interface SelectTheLoginModeView()
@property(nonatomic,strong)UIView *lineView;
@end

@implementation SelectTheLoginModeView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI:frame];
    }
    return self;
}

- (void)setUpUI:(CGRect)frame{
    UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame = CGRectMake(frame.size.width/2.0 - 20 - 100, 30, 100, 40);
    [codeButton addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [codeButton setTitle:@"验证码登录" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor skinColor] forState:UIControlStateSelected];
    codeButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    codeButton.selected = true;
    codeButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
    codeButton.tag = 5000;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(codeButton.center.x - 50, codeButton.center.y+15, 100, 1)];
    self.lineView.backgroundColor = [UIColor skinColor];
    [self addSubview:codeButton];
    [self addSubview:self.lineView];
    
    
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordButton.frame = CGRectMake(frame.size.width/2.0 + 20, 30, 100, 40);
    [passwordButton addTarget:self action:@selector(passwordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [passwordButton setTitle:@"密码登录" forState:UIControlStateNormal];
    [passwordButton setTitleColor:[UIColor hj_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [passwordButton setTitleColor:[UIColor skinColor] forState:UIControlStateSelected];
    passwordButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    passwordButton.tag = 5001;
    [self addSubview:passwordButton];
    
}

- (void)codeButtonClick:(UIButton*)codeButton{
    [self eventId:HQWY_Login_Code_click];
    if (!codeButton.selected) {
        if ([self.delegate respondsToSelector:@selector(selectTheLoginModeCode)]) {
            [self.delegate selectTheLoginModeCode];
        }
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            codeButton.selected = !codeButton.selected;
            codeButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
            self.lineView.transform = CGAffineTransformIdentity;
            UIButton *passwordButton = [self viewWithTag:5001];
            passwordButton.transform =CGAffineTransformIdentity;
            passwordButton.selected = false;
        } completion:^(BOOL finished) {
    
        }];
    }
    
    
}

- (void)passwordButtonClick:(UIButton*)passwordButton{
    [self eventId:HQWY_Login_Password_click];
    if (!passwordButton.selected) {
        if ([self.delegate respondsToSelector:@selector(selectTheLoginModePassword)]) {
            [self.delegate selectTheLoginModePassword];
        }
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            passwordButton.selected = !passwordButton.selected;
                passwordButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
            CGAffineTransform t1 = CGAffineTransformMakeTranslation(175, 0);
             CGAffineTransform t2 = CGAffineTransformMakeScale(0.8, 1.0);
            self.lineView.transform =  CGAffineTransformConcat(t1, t2);
            [self bringSubviewToFront:self.lineView];
                UIButton *codeButton = [self viewWithTag:5000];
                codeButton.transform =CGAffineTransformIdentity;
                codeButton.selected = false;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
