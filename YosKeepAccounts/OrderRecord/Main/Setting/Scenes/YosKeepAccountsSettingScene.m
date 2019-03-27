#import "YosKeepAccountsSettingScene.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "YosKeepAccountsPrivacyAgreementPresenter.h"
#import "YosKeepAccountsFeedbackPresenter.h"
#import "YosKeepAccountsAboutPresenter.h"
#import <NSDate+HJNormalExtension.h>
#import <UserCenter/XZYUserCenterUIHeader.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YosKeepAccountsUserManager.h"
#import <HJ_UIKit/HJAlertView.h>
#import "UIColor+YKATheme.h"


static NSString *const mineHeader = @"com.setting.mineHeader";
static CGFloat settingSceneWidth = 260;
@interface YosKeepAccountsSettingScene ()
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
XZYUserCenterProtocol
>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UIView *logoutScene;
@property (weak, nonatomic) IBOutlet UIView *aboutMeSeparatorLine;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *headImageScene;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *safeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *safeSwitchTipLabel;
@property (weak, nonatomic) IBOutlet UIView *meHeadScene;
@end
@implementation YosKeepAccountsSettingScene
+ (instancetype)settingScene {
    return [[[NSBundle mainBundle] loadNibNamed:@"YosKeepAccountsSettingScene" owner:nil options:nil] firstObject] ;
}
+ (void)showSettingSceneOnSuperPresenter:(UIViewController *)superVC gotoVCHandler:(YosKeepAccountsSettingSceneGotoVC)gotoVC {
    UIView *bgScene = [[UIView alloc] initWithFrame:superVC.view.bounds];
    bgScene.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    bgScene.alpha = 0;
    [superVC.view addSubview:bgScene];
    CGFloat height = superVC.view.bounds.size.height;
    YosKeepAccountsSettingScene *settingScene = [YosKeepAccountsSettingScene settingScene];
    settingScene.frame = CGRectMake(0 - settingSceneWidth, 0, settingSceneWidth, height);
    settingScene.superPresenter = superVC;
    settingScene.gotoSceneContoller = gotoVC;
    [bgScene addSubview:settingScene];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bgScene.alpha = 1;
        settingScene.frame = CGRectMake(0, 0, settingSceneWidth, height);
    } completion:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:settingScene action:@selector(hideSettingScene)];
    [bgScene addGestureRecognizer:tap];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    static NSString *safeSwitchTip;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            if ([LAContext new].biometryType == LABiometryTypeFaceID) {
                safeSwitchTip = @"开启后可以使用人脸打开应用";
            } else {
                safeSwitchTip = @"开启后可以使用指纹打开应用";
            }
        } else {
            safeSwitchTip = @"开启后可以使用指纹打开应用";
        }
    });
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadeImage)];
    [self.headImageScene addGestureRecognizer:tap];
    [self updateHeadIcon];
    self.headImageScene.tintColor = UIColor.yka_unselected;
    
    NSDate *firstDate = UserDefaultGetObj(@"firstDay");
    NSInteger date = [NSDate hj_daysAgo:firstDate];
    date = date < 0 ? 0 : date;
    self.titleLabel.text = [NSString stringWithFormat:@"您已坚持记账%ld天",date + 1];
    UITapGestureRecognizer *tmpTap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tmpTap];
    self.safeSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCachedTouchIdStatus];
    self.safeSwitchTipLabel.text = safeSwitchTip;
    
    [self.loginBtn addTarget:self
                      action:@selector(headerSceneTap:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.logoutBtn setTitleColor:YosKeepAccountsThemeColor forState:UIControlStateNormal];
    
    [self setUpRAC];
}

- (void)setUpRAC {
    
    WEAK_SELF
    [RACObserve([YosKeepAccountsUserManager shareInstance], logined) subscribeNext:^(NSNumber *login) {
        STRONG_SELF
        BOOL aleadyLogin = [login boolValue];
        self.loginBtn.hidden = aleadyLogin;
        self.userNameLb.hidden = !aleadyLogin;
        self.titleLabel.hidden = !aleadyLogin;
        self.aboutMeSeparatorLine.hidden = !aleadyLogin;
        self.logoutScene.hidden = !aleadyLogin;
        [self updateHeadIcon];
    }];
    
    RAC(self.userNameLb, text) = RACObserve([YosKeepAccountsUserManager shareInstance], phone);
}

- (void)updateHeadIcon {
    
    if ([YosKeepAccountsUserManager shareInstance].logined) {
        NSString *headerCacheKey = [mineHeader stringByAppendingString:[YosKeepAccountsUserManager shareInstance].phone ?: @""];
        NSData *imageData = [[NSUserDefaults standardUserDefaults] valueForKey:headerCacheKey];
        if (imageData) {
            self.headImageScene.image = [UIImage imageWithData:imageData];
        } else {
            self.headImageScene.image = [UIImage imageNamed:@"默认头像"];
        }
    } else {
        self.headImageScene.image = [UIImage imageNamed:@"默认头像"];
    }
}

- (IBAction)logoutBtnClick:(id)sender {
    
    HJAlertView *alert = [[HJAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要退出登录么？" cancelBlock:nil confirmBlock:^{
        [[YosKeepAccountsUserManager shareInstance] logout];
    }];
    alert.messageLabel.textAlignment = NSTextAlignmentCenter;
    alert.confirmColor = YosKeepAccountsThemeColor;
    
    [alert show];
}

- (void)headerSceneTap:(UIButton *)tap {
    XZYLoginViewController *controller = [[XZYLoginViewController alloc] init];
    controller.delegate = self;
    XZYConfigInstance.registerType = RegisterTypeQuick;
    self.gotoSceneContoller(controller);
}

- (IBAction)buttonClick:(UIButton *)sender {
    NSInteger type = sender.tag - 100;
    if (self.gotoSceneContoller) {
        UIViewController *vc;
        if (type == 1) {
            vc = [[YosKeepAccountsPrivacyAgreementPresenter alloc] init];
        } else if (type == 2) {
            vc = [[YosKeepAccountsFeedbackPresenter alloc] init];
        } else if (type == 3) {
            vc = [[YosKeepAccountsAboutPresenter alloc] init];
        }
        self.gotoSceneContoller(vc);
    }
}
- (IBAction)switchAction:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:kCachedTouchIdStatus];
}
- (void)hideSettingScene {
    [self hideSettingScene:nil];
}
- (void)hideSettingScene:(void (^)(void))completion {
    UIView *superScene = self.superview;
    CGFloat height = self.bounds.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        superScene.alpha = 0;
        self.frame = CGRectMake(0 - settingSceneWidth, 0, settingSceneWidth, height);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [superScene removeFromSuperview];
    }];
}
- (void)selectHeadeImage {
    
    if (![YosKeepAccountsUserManager shareInstance].logined) {
        XZYLoginViewController *controller = [[XZYLoginViewController alloc] init];
        controller.delegate = self;
        XZYConfigInstance.registerType = RegisterTypeQuick;
        self.gotoSceneContoller(controller);
        return ;
    }
    
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [sheetController addAction:[UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheetClickedButtonAtIndex:0];
    }]];
    [sheetController addAction:[UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionSheetClickedButtonAtIndex:1];
    }]];
    [sheetController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    if (UIDevice.hj_deviceType == HJDeviceIPad) {
        UIPopoverPresentationController *popoverPresentationController = [sheetController popoverPresentationController];
        if (popoverPresentationController) {
            popoverPresentationController.sourceRect = self.headImageScene.bounds;
            popoverPresentationController.sourceView = self.headImageScene;
        }
    }
    [self.superPresenter presentViewController:sheetController animated:YES completion:nil];
}
- (void)actionSheetClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"选项中，允许章鱼记账访问你的手机相机" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alert addAction:ok];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
                [alert addAction:cancle];
                [self.superPresenter presentViewController:alert animated:true completion:nil];
            } else {
                UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                ipc.allowsEditing = YES;
                ipc.delegate = self;
                [self.superPresenter presentViewController:ipc animated:YES completion:nil];
            }
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备相机不可使用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author ==ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相册\"选项中，允许章鱼记账访问你的手机相册" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alert addAction:ok];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
                [alert addAction:cancle];
                [self.superPresenter presentViewController:alert animated:true completion:nil];
            }else{
                UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                ipc.allowsEditing = YES;
                ipc.delegate = self;
                [self.superPresenter presentViewController:ipc animated:YES completion:nil];
            }
            return ;
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备相册不可使用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    } else {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self.headImageScene setImage:image];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *headerCacheKey = [mineHeader stringByAppendingString:[YosKeepAccountsUserManager shareInstance].phone];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:headerCacheKey];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)openURL:(NSURL *)url {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {}];
    } else {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (void)loginFinished:(NSDictionary *)statusDict {
    NSString *statusString = statusDict[@"code"];
    switch (statusString.integerValue) {
        case LoginStatusFailed: {
            
        }
            break;
            
        case LoginStatusSuccess: {
            [self.superPresenter.navigationController popToRootViewControllerAnimated:YES];
            
            // 避免接口返回的字典解析各字段为空对象，赋值时发生crash
            NSDictionary *userInfo = @{@"passid":XZYUserInfoInstance.passid ? XZYUserInfoInstance.passid : @"" ,
                                       @"username":XZYUserInfoInstance.username ? XZYUserInfoInstance.username : @"",
                                       @"phone":XZYUserInfoInstance.phone ? XZYUserInfoInstance.phone : @"" ,
                                       @"email":XZYUserInfoInstance.email ? XZYUserInfoInstance.email : @"",
                                       @"cookie":XZYUserInfoInstance.cookie ? XZYUserInfoInstance.cookie : @""};
            [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[YosKeepAccountsUserManager shareInstance] refresh];
        }
            break;
            
        default:
            break;
    }
}

@end
