#import "YosKeepAccountsTouchIDPresenter.h"
#import "ZYZControl.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface YosKeepAccountsTouchIDPresenter ()<UIAlertViewDelegate>
@property(nonatomic,strong)LAContext *context;
@end
@implementation YosKeepAccountsTouchIDPresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[LAContext alloc] init];
    [self initUi];
}
- (void)initUi{
    UIImageView *logoImage = [ZYZControl createImageSceneFrame:CGRectMake(self.view.hj_width/2.0 - 40, 105, 80, 80) imageName:@"corner_logo"];
    logoImage.layer.cornerRadius = 8.0;
    [self.view addSubview:logoImage];
    BOOL isFaceID = NO;
    if (@available(iOS 11.0, *)) {
        if (self.context.biometryType == LABiometryTypeFaceID) {
            isFaceID = YES;
        }
    }
    NSString *fingerImageName;
    if (isFaceID) {
        fingerImageName = @"home_ic_FaceID";
    } else {
        fingerImageName = @"home_ic_TouchID";
    }
    UIImageView *fingerImage = [ZYZControl createImageSceneFrame:CGRectMake(self.view.hj_width/2.0 - 31.5, self.view.hj_height/2.0 - 31.5, 63, 63) imageName:fingerImageName];
    [self.view addSubview:fingerImage];
    NSString *title;
    if (isFaceID) {
        title = @"点击进行人脸解锁";
    } else {
        title = @"点击进行指纹解锁";
    }
    UIButton *startButton = [ZYZControl createButtonWithFrame:CGRectMake(fingerImage.center.x - 75, CGRectGetMaxY(fingerImage.frame), 150, 60) target:self SEL:@selector(startButtonClick) title:title];
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
                         self.rootStartVC(true);
                     });
                 }
                 else
                 {
                     switch (error.code)
                     {
                         case LAErrorUserCancel:
                             NSLog(@"密码取消");
                             [self loginOUT];
                             break;
                         case LAErrorAuthenticationFailed:
                             NSLog(@"连输三次后，密码失败");
                             [self loginOUT];
                             break;
                         case LAErrorPasscodeNotSet:
                             NSLog(@"密码没有设置");
                             [self loginOUT];
                             break;
                         case LAErrorSystemCancel:
                             NSLog(@"系统取消了验证");
                             [self loginOUT];
                             break;
                         case LAErrorUserFallback:
                             NSLog(@"登陆");
                             break;
                         case LAErrorTouchIDNotAvailable:
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
                             NSLog(@"密码取消");
                             [self loginOUT];
                             break;
                         case LAErrorAuthenticationFailed:
                         {
                             NSLog(@"连输三次后，密码失败");
                             alert.message =  @"输入错误次数过多";
                             [alert show];
                         }
                             break;
                         case LAErrorPasscodeNotSet:
                         {
                             NSLog(@"密码没有设置");
                             alert.message =  @"密码没有设置";
                             [alert show];
                         }
                             break;
                         case LAErrorSystemCancel:
                         {
                             alert.message =  @"系统取消了验证";
                             [alert show];
                             NSLog(@"系统取消了验证");
                         }
                             break;
                         case LAErrorUserFallback:
                             NSLog(@"登陆");
                             [self loginOUT];
                             break;
                         case LAErrorTouchIDNotAvailable:
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
- (void)alertScene:(UIAlertView *)alertScene clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertScene.tag == 7 || alertScene.tag == 10){
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
}
@end
