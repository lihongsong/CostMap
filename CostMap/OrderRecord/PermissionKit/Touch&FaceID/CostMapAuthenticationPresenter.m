#import "CostMapAuthenticationPresenter.h"
#import "CostMapControl.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface CostMapAuthenticationPresenter ()<UIAlertViewDelegate>
@property(nonatomic,strong)LAContext *context;
@end
@implementation CostMapAuthenticationPresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[LAContext alloc] init];
    [self initUi];
    [self checkAuthentication];
}

- (void)checkAuthentication {
    NSError *error;
    if (@available(iOS 9.0, *)) {
        if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
            
        } else {
            self.rootStartVC(YES);
        }
    } else {
        // iOS 8.0
        if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
        } else {
            self.rootStartVC(YES);
        }
    }
}

- (void)initUi{
    UIImageView *logoImage = [CostMapControl yka_createImageSceneFrame:CGRectMake(self.view.hj_width/2.0 - 40, 105, 80, 80) imageName:@"icon_76pt"];
    logoImage.layer.cornerRadius = 8.0;
    logoImage.layer.masksToBounds = YES;
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
    UIImageView *fingerImage = [CostMapControl yka_createImageSceneFrame:CGRectMake(self.view.hj_width / 2.0 - 31.5, self.view.hj_height/2.0 - 31.5, 63, 63) imageName:fingerImageName];
    [self.view addSubview:fingerImage];
    NSString *title;
    if (isFaceID) {
        title = @"Click to unlock the face";
    } else {
        title = @"Click to unlock the fingerprint";
    }
    UIButton *startButton = [CostMapControl yka_createButtonWithFrame:CGRectMake(fingerImage.center.x - 100, CGRectGetMaxY(fingerImage.frame), 200, 60) target:self SEL:@selector(startButtonClick) title:title];
    [startButton setTitleColor:[UIColor skinColor] forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    UIButton *bigButton = [CostMapControl yka_createButtonWithFrame:CGRectMake(fingerImage.center.x - 75, fingerImage.frame.origin.y, 150, 123) target:self SEL:@selector(startButtonClick) title:@""];
    [self.view addSubview:bigButton];
}

-(void)authenticationSuccess {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.rootStartVC(YES);
    });
}

- (void)startButtonClick{
    NSError *error;
    if (@available(iOS 9.0, *)) {
        if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
        {
            [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                         localizedReason:NSLocalizedString(@"Verify existing phone fingerprints with the home button", nil)
                                   reply:^(BOOL success, NSError *error)
             {
                 if (success)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.rootStartVC(true);
                     });
                 }
                 else
                 {
                     switch (error.code)
                     {
                         case LAErrorUserCancel:
                             break;
                         case LAErrorAuthenticationFailed:
                             break;
                         case LAErrorPasscodeNotSet:
                             [self authenticationSuccess];
                             break;
                         case LAErrorSystemCancel:
                             break;
                         case LAErrorUserFallback:
                             break;
                         case LAErrorTouchIDNotAvailable:
                             break;
                         default:
                             [self authenticationSuccess];
                             break;
                     }
                 }
             }];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"There is something wrong with your Touch ID Settings"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"ok"
                                                   otherButtonTitles:nil, nil];
            alert.tag = 7;
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                    alert.message = @"You have not entered your fingerprint, please turn it on after setting your fingerprint";
                    break;
                case  LAErrorTouchIDNotAvailable:
                    alert.message = @"Your device does not support fingerprint input, please switch to numeric keypad";
                    break;
                case LAErrorPasscodeNotSet:
                    alert.message = @"You have not set the password entry";
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
                         localizedReason:NSLocalizedString(@"Home key to verify existing phone fingerprint", nil)
                                   reply:^(BOOL success, NSError *error)
             {
                 if (success)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.rootStartVC(true);
                     });
                 }
                 else
                 {
                     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Prompt"
                                                                      message:@""
                                                                     delegate:self
                                                            cancelButtonTitle:@"ok"
                                                            otherButtonTitles:nil, nil];
                     alert.tag = 10;
                     switch (error.code)
                     {
                         case LAErrorUserCancel:
                             [self authenticationSuccess];
                             break;
                         case LAErrorAuthenticationFailed:
                         {
                             alert.message =  @"Too many typos";
                             [alert show];
                         }
                             break;
                         case LAErrorPasscodeNotSet:
                         {
                             alert.message =  @"Password not set";
                             [alert show];
                         }
                             break;
                         case LAErrorSystemCancel:
                         {
                             alert.message =  @"The system canceled validation";
                             [alert show];
                         }
                             break;
                         case LAErrorUserFallback:
                             [self authenticationSuccess];
                             break;
                         case LAErrorTouchIDNotAvailable:
                         {
                             alert.message =  @"The system canceled validation";
                             [alert show];
                         }
                         case  LAErrorTouchIDLockout:{
                             {
                                 alert.message =  @"TouchID failed too many times and was locked";
                                 [alert show];
                             }
                         }
                         default:
                             [self authenticationSuccess];
                             break;
                     }
                 }
             }];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"There is something wrong with your Touch ID Settings"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"known"
                                                   otherButtonTitles:nil, nil];
            alert.tag = 7;
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                    alert.message = @"You have not entered your fingerprint, please turn it on after setting your fingerprint";
                    break;
                case  LAErrorTouchIDNotAvailable:
                    alert.message = @"Your device does not support fingerprint input, please switch to numeric keypad";
                    break;
                case LAErrorPasscodeNotSet:
                    alert.message = @"You have not set the password entry";
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
            self.rootStartVC(false);
        });
    }
}

@end
