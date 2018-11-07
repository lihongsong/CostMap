//
//  WYHQTouchIDViewController.m
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQTouchIDViewController.h"
#import "ZYZControl.h"

#import <LocalAuthentication/LocalAuthentication.h>

@interface WYHQTouchIDViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)LAContext *context;
@end

@implementation WYHQTouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUi];
}

- (void)initUi{
    UIImageView *logoImage = [ZYZControl createImageViewFrame:CGRectMake(self.view.hj_width/2.0 - 40, 105, 80, 80) imageName:@"corner_logo"];
    logoImage.layer.cornerRadius = 8.0;
    [self.view addSubview:logoImage];
    
    UIImageView *fingerImage = [ZYZControl createImageViewFrame:CGRectMake(self.view.hj_width/2.0 - 31.5, self.view.hj_height/2.0 - 31.5, 63, 63) imageName:@"home_ic_TouchID"];
    [self.view addSubview:fingerImage];
    
    UIButton *startButton = [ZYZControl createButtonWithFrame:CGRectMake(fingerImage.center.x - 75, CGRectGetMaxY(fingerImage.frame), 150, 60) target:self SEL:@selector(startButtonClick) title:@"点击进行指纹解锁"];
    [startButton setTitleColor:[UIColor skinColor] forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    
    UIButton *bigButton = [ZYZControl createButtonWithFrame:CGRectMake(fingerImage.center.x - 75, fingerImage.frame.origin.y, 150, 123) target:self SEL:@selector(startButtonClick) title:@""];
    [self.view addSubview:bigButton];
}

#pragma mark 清除登录信息
-(void)loginOUT{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self setSwitchOff];
    self.rootStartVC(false);
    });
}

#pragma mark 开启指纹识别
- (void)startButtonClick{
    self.context = [[LAContext alloc] init];
    //self.context.localizedFallbackTitle = @"输入登陆密码";
    NSError *error;
    
    if (@available(iOS 9.0, *)) {
        if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
        {
            [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                         localizedReason:NSLocalizedString(@"Home键验证已有手机指纹", nil)
                                   reply:^(BOOL success, NSError *error)
             {
                 if (success)
                 {
                     NSLog(@"验证通过");
                     dispatch_async(dispatch_get_main_queue(), ^{
                         //[KeyWindow ln_showToastHUD:@"验证通过"];
                         self.rootStartVC(true);
                     });
                     
                 }
                 else
                 {
                     switch (error.code)
                     {
                             
                         case LAErrorUserCancel:
                             //认证被用户取消.例如点击了 cancel 按钮.
                             NSLog(@"密码取消");
                                 [self loginOUT];
                             break;
                             
                         case LAErrorAuthenticationFailed:
                             // 此处会自动消失，然后下一次弹出的时候，又需要验证数字
                             // 认证没有成功,因为用户没有成功的提供一个有效的认证资格
                             NSLog(@"连输三次后，密码失败");
                             [self loginOUT];
                             break;
                             
                         case LAErrorPasscodeNotSet:
                             // 认证不能开始,因为此台设备没有设置密码.
                             NSLog(@"密码没有设置");
                             [self loginOUT];
                             break;
                             
                         case LAErrorSystemCancel:
                             //认证被系统取消了(例如其他的应用程序到前台了)
                             NSLog(@"系统取消了验证");
                             [self loginOUT];
                             break;
                             
                         case LAErrorUserFallback:
                             //当输入觉的会有问题的时候输入
                             NSLog(@"登陆");
                             break;
                         case LAErrorTouchIDNotAvailable:
                             //认证不能开始,因为 touch id 在此台设备尚是无效的.
                             NSLog(@"touch ID 无效");
                             [self loginOUT];
                         default:
                             NSLog(@"您不能访问私有内容——————%ld____%@",(long)error.code,error);
                             [self loginOUT];
                             break;
                     }
                 }
             }];
        }
        else
        {
            
            NSLog(@"——————%ld____%@",(long)error.code,error);
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您的Touch ID 设置 有问题" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag = 7;
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                    alert.message = @"您还没有进行指纹输入，请指纹设定后打开";
                    break;
                case  LAErrorTouchIDNotAvailable:
                    alert.message = @"您的设备不支持指纹输入，请切换为数字键盘";
                    break;
                case LAErrorPasscodeNotSet:
                    alert.message = @"您还没有设置密码输入";
                    break;
                default:
                    break;
            }
            [alert show];
            
            
        }
    } else {
        if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
        {
            [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                         localizedReason:NSLocalizedString(@"Home键验证已有手机指纹", nil)
                                   reply:^(BOOL success, NSError *error)
             {
                 if (success)
                 {
                     NSLog(@"验证通过");
                     dispatch_async(dispatch_get_main_queue(), ^{
                       
                         //[KeyWindow ln_showToastHUD:@"验证通过"];
                           self.rootStartVC(true);
                     });
                     
                 }
                 else
                 {
                     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     alert.tag = 10;
                     switch (error.code)
                     {
                             
                         case LAErrorUserCancel:
                             //认证被用户取消.例如点击了 cancel 按钮.
                             NSLog(@"密码取消");
                             [self loginOUT];
                             break;
                             
                         case LAErrorAuthenticationFailed:
                             // 此处会自动消失，然后下一次弹出的时候，又需要验证数字
                             // 认证没有成功,因为用户没有成功的提供一个有效的认证资格
                         {
                             NSLog(@"连输三次后，密码失败");
                             alert.message =  @"输入错误次数过多";
                             [alert show];
                         }
                             break;
                             
                         case LAErrorPasscodeNotSet:
                             // 认证不能开始,因为此台设备没有设置密码.
                             
                         {
                             NSLog(@"密码没有设置");
                             alert.message =  @"密码没有设置";
                             [alert show];
                         }
                             break;
                             
                         case LAErrorSystemCancel:
                             //认证被系统取消了(例如其他的应用程序到前台了)
                         {
                             alert.message =  @"系统取消了验证";
                             [alert show];
                             NSLog(@"系统取消了验证");
                         }
                             break;
                             
                         case LAErrorUserFallback:
                             //当输入觉的会有问题的时候输入
                             NSLog(@"登陆");
                             [self loginOUT];
                             break;
                         case LAErrorTouchIDNotAvailable:
                             //认证不能开始,因为 touch id 在此台设备尚是无效的.
                         {
                             alert.message =  @"系统取消了验证";
                             [alert show];
                             NSLog(@"touch ID 无效");
                         }
                         case  LAErrorTouchIDLockout:{
                             {
                                 alert.message =  @"TouchID失败次数过多被锁定";
                                 [alert show];
                                 NSLog(@"TouchID失败次数过多被锁定");
                             }
                         }
                         default:
                             NSLog(@"您不能访问私有内容——————%ld____%@",(long)error.code,error);
                             [self loginOUT];
                             break;
                     }
                 }
             }];
        }
        else
        {
            
            NSLog(@"——————%ld____%@",(long)error.code,error);
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您的Touch ID 设置 有问题" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag = 7;
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                    alert.message = @"您还没有进行指纹输入，请指纹设定后打开";
                    break;
                case  LAErrorTouchIDNotAvailable:
                    alert.message = @"您的设备不支持指纹输入，请切换为数字键盘";
                    break;
                case LAErrorPasscodeNotSet:
                    alert.message = @"您还没有设置密码输入";
                    break;
                default:
                    break;
            }
            [alert show];
            
            
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 7 || alertView.tag == 10){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setSwitchOff];
            self.rootStartVC(false);
        });
    }
}

-(void)setSwitchOff{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:false forKey:@"kCachedTouchIdStatus"];
    [userDefault synchronize];
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
