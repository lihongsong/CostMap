//
//  PasswordViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "PasswordViewController.h"
#import "UIButton+CountDown.h"
@interface PasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
@property (weak, nonatomic) IBOutlet UILabel *secondTypeLable;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UIButton *authCodeButton;
@property (weak, nonatomic) IBOutlet UIView *bottomSepView;
@property (weak, nonatomic) IBOutlet UIView *topSepView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authCodeWidth;

@end

@implementation PasswordViewController

+ (instancetype)instance {
    return [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = false;
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}


- (void)setUpUI{
    self.topSepView.backgroundColor = [UIColor sepreateColor];
    self.bottomSepView.backgroundColor = [UIColor sepreateColor];
    
    
    if (self.type == PasswordTypeSet) {
        self.firstLable.text = @"设置密码";
        self.secondTypeLable.text = @"确认密码";
        self.title = @"设置密码";
        self.authCodeWidth.constant = 0;
    }else{
        self.firstLable.text = @"手机号";
        self.secondTypeLable.text = @"验证码";
        self.title = @"验证手机号";
        self.authCodeWidth.constant = 62;
    }
    
}
- (IBAction)sendAuthCodeAction:(UIButton *)sender {
//    [sender startTime:10 title:@"获取验证码" waitTittle:@"后重试"];
    
}

# pragma mark textFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.firstTextField]) {
        self.topSepView.backgroundColor = [UIColor skinColor];
    }
    else{
        self.bottomSepView.backgroundColor = [UIColor skinColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.firstTextField] && StrIsEmpty(self.firstTextField.text)) {
        self.topSepView.backgroundColor = [UIColor sepreateColor];
    }else if ([textField isEqual:self.secondTextField] && StrIsEmpty(self.secondTextField.text)){
        self.bottomSepView.backgroundColor = [UIColor sepreateColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
