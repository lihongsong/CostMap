//
//  TwoTextFieldView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "TwoTextFieldView.h"
@interface TwoTextFieldView()<UITextFieldDelegate>

@end

@implementation TwoTextFieldView

- (instancetype)init{
    if (self = [super init]){
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self firstTF];
    [self secondTF];
    [self firstLineView];
    [self secondLineView];
    [self codeButton];
    [self eyeButton];
}

- (void)setType:(TextFieldType)type{
    switch (type) {
        case TextFieldTypeCode:
            {
                self.firstTF.placeholder = @"请填写真实有效手机号";
                self.secondTF.placeholder = @"请填写短信验证码";
                self.codeButton.hidden = false;
                self.secondTF.frame = CGRectMake(LeftSpace, 70,CGRectGetMaxX(self.codeButton.frame) - self.codeButton.hj_width - 15 - LeftSpace, 50);
            }
            break;
        case TextFieldTypePassword:
        {
            self.firstTF.placeholder = @"请填写真实有效手机号";
            self.secondTF.placeholder = @"请填写登录密码";
            self.eyeButton.hidden = false;
            self.secondTF.frame = CGRectMake(LeftSpace, 70,CGRectGetMaxX(self.eyeButton.frame) - self.eyeButton.hj_width - 5 - LeftSpace, 50);
        }
            break;
        case TextFieldTypeForget:
        {
            self.firstTF.placeholder = @"6~20数字或者字母";
            self.secondTF.placeholder = @"请再输入一次";
        }
            break;
        case TextFieldTypeModify:
        {
            self.firstTF.placeholder = @"6~20数字或者字母";
            self.secondTF.placeholder = @"请再输入一次";
        }
            break;
        default:
            break;
    }
}

- (UITextField *)firstTF {
    if(!_firstTF){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, 10,SWidth - LeftSpace - 7, 50)];
        textField.textColor = [UIColor grayColor];
        textField.font = [UIFont NormalSmallTitleFont];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.delegate = self;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:textField];
        _firstTF = textField;
    }
    return _firstTF;
}
- (UITextField *)secondTF {
    if(!_secondTF){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(LeftSpace, 70,SWidth - 2 * LeftSpace, 50)];
        textField.textColor = [UIColor grayColor];
        textField.font = [UIFont NormalSmallTitleFont];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.delegate = self;
        [self addSubview:textField];
        _secondTF = textField;
    }
    return _secondTF;
}

- (UIView *)firstLineView{
    if (!_firstLineView) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_firstTF.frame), SWidth - 2 * LeftSpace, 1)];
        lineView.backgroundColor = [UIColor sepreateColor];
        [self addSubview:lineView];
        _firstLineView = lineView;
    }
    return _firstLineView;
}
- (UIView *)secondLineView{
    if (!_secondLineView) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_secondTF.frame), SWidth - 2 * LeftSpace, 1)];
        lineView.backgroundColor = [UIColor sepreateColor];
        [self addSubview:lineView];
        _secondLineView = lineView;
    }
    return _secondLineView;
}

- (UIButton*)codeButton{
    if (!_codeButton) {
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tempButton.frame = CGRectMake(SWidth - 10 - 100,self.secondTF.hj_y, 100, self.secondTF.hj_height);
        tempButton.enabled = false;
        [tempButton addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [tempButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tempButton setTitleColor:[UIColor skinColor] forState:UIControlStateSelected];
        tempButton.titleLabel.font = [UIFont NormalSmallTitleFont];
        tempButton.hidden = true;
        [self addSubview:tempButton];
        _codeButton = tempButton;
    }
    return _codeButton;
}

- (UIButton *)eyeButton{
    if (!_eyeButton) {
        UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tempButton.frame = CGRectMake(SWidth - 50, self.secondTF.hj_y, 50, self.secondTF.hj_height);
        [tempButton addTarget:self action:@selector(eyeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [tempButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
       [tempButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        tempButton.selected = false;
        tempButton.hidden = true;
        [self addSubview:tempButton];
        _eyeButton = tempButton;
    }
    return _eyeButton;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.firstTF]) {
        self.firstLineView.backgroundColor = [UIColor skinColor];
    }else{
        self.secondLineView.backgroundColor = [UIColor skinColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.firstTF] && StrIsEmpty(self.firstTF.text)) {
        self.firstLineView.backgroundColor = [UIColor sepreateColor];
    }else if ([textField isEqual:self.secondTF] && StrIsEmpty(self.secondTF.text)){
        self.secondLineView.backgroundColor = [UIColor sepreateColor];
    }
}

#pragma mark 获取验证码
- (void)codeButtonClick:(UIButton*)codeButton{
    [codeButton setTitle:@"60秒后重试" forState:UIControlStateNormal];
}

#pragma mark  是否密码可见
- (void)eyeButtonClick{
    self.eyeButton.selected = !self.eyeButton.selected;
    self.secondTF.secureTextEntry = !self.eyeButton.selected;
}


@end
