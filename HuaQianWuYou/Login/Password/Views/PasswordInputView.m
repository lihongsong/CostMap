//
//  PasswordInputView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "PasswordInputView.h"
#import "UIButton+Count.h"
#import "UIButton+EnlableColor.h"
#import <HJCategories/NSString+HJNormalRegex.h>

@interface PasswordInputView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLable;
@property (weak, nonatomic) IBOutlet UITextField *firstTextFieldView;
@property (weak, nonatomic) IBOutlet UIView *firstSepView;
@property (weak, nonatomic) IBOutlet UIButton *authCodeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authCodeButtonW;
@property (weak, nonatomic) IBOutlet UIView *secondSepView;

@property (weak, nonatomic) IBOutlet UITextField *secondTextFieldView;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLable;
@end

@implementation PasswordInputView

+ (instancetype)instance{
    return [[NSBundle mainBundle] loadNibNamed:@"PasswordInputView" owner:self options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.firstTextFieldView.delegate = self;
    self.secondTextFieldView.delegate = self;
    self.userInteractionEnabled =true;
    self.firstSepView.backgroundColor = [UIColor sepreateColor];;
    self.secondSepView.backgroundColor = [UIColor sepreateColor];;
    [self.firstTextFieldView addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.secondTextFieldView addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.authCodeButton addTarget:self action:@selector(authCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.authCodeButton setTitleColor:[UIColor skinColor] forState:UIControlStateNormal];
//    [self.authCodeButton enlableColor:[UIColor skinColor] disEnlableColor:[UIColor grayColor]];
//    self.authCodeButton.enabled = YES;
  
}



- (void)authCodeAction:(UIButton *)sender{
    if (self.type == PasswordInputTypeAuthPhoneNum) {
        if (![self.firstTextFieldView.text hj_isMobileNumber] ) {
            [KeyWindow ln_showToastHUD:@"手机号错误"];
            return;
        }
        [sender startTotalTime:10 title:@"获取验证码" waitingTitle:@"后重试"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSendAuthCode)]) {
            [self.delegate didSendAuthCode];
        }

       }
}

- (void)setType:(PasswordInputType)type{
    _type = type;
    self.authCodeButtonW.constant = (type == PasswordInputTypeSet) ? 0 : 80;
    switch (type) {
        case PasswordInputTypeSet:
            self.firstTitleLable.text = nil;
            self.secondTitleLable.text = nil;
            self.firstTextFieldView.placeholder = @"6~20位数字或字母";
            self.secondTextFieldView.placeholder = @"请再输入一遍";
            self.firstTextFieldView.keyboardType = UIKeyboardTypeDefault;

            break;
        case PasswordInputTypeAuthPhoneNum:
            self.firstTitleLable.text = nil;
            self.secondTitleLable.text = nil;
            self.firstTextFieldView.keyboardType = UIKeyboardTypeNamePhonePad;
            self.firstTextFieldView.placeholder = @"请填写手机号码";
            self.secondTextFieldView.placeholder = @"请填写短信验证码";
            break;
        default:
            break;
    }
}



- (void)textFieldEditChanged:(UITextField *)textField{
  
    if ([textField isEqual:self.firstTextFieldView] ) {
        self.firstSepView.backgroundColor = textField.text.length>0 ? [UIColor skinColor] : [UIColor sepreateColor];
    }
    else{
        self.secondSepView.backgroundColor = textField.text.length>0 ? [UIColor skinColor] : [UIColor sepreateColor];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldContentdidChangeValues:secondValue:)]) {
        [self.delegate textFieldContentdidChangeValues:self.firstTextFieldView.text secondValue:self.secondTextFieldView.text];
    }
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger maxLength = 0;
    if ([textField isEqual:self.firstTextFieldView]) {
        maxLength = (self.type == PasswordInputTypeAuthPhoneNum) ? 11 : 20;
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > maxLength && range.length!=1){
            textField.text = [toBeString substringToIndex:maxLength];
            return NO;
            
        }
    }
    
    return YES;

}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    if ([textField isEqual:self.firstTextFieldView]) {
//        if (self.type == PasswordInputTypeAuthPhoneNum) {
//            self.authCodeButton.enabled = ([textField.text hj_isMobileNumber]) ? YES : NO;
//        }
//    }
//    return YES;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end