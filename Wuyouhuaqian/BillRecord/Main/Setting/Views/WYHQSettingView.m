//
//  WYHQSettingView.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQSettingView.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <LocalAuthentication/LocalAuthentication.h>

#import "WYHQPrivacyAgreementViewController.h"
#import "WYHQFeedbackViewController.h"
#import "WYHQAboutViewController.h"

#import <NSDate+HJNormalExtension.h>

static NSString *const mineHeader = @"com.wyhq.setting.mineHeader";
static CGFloat settingViewWidth = 260;

@interface WYHQSettingView ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *safeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *safeSwitchTipLabel;

@end


@implementation WYHQSettingView

+ (instancetype)settingView {
    UINib *nib = [UINib nibWithNibName:@"WYHQSettingView" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}

+ (void)showSettingViewOnSuperViewController:(UIViewController *)superVC gotoVCHandler:(WYHQSettingViewGotoVC)gotoVC {
    UIView *bgView = [[UIView alloc] initWithFrame:superVC.view.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    bgView.alpha = 0;
    [superVC.view addSubview:bgView];
    
    CGFloat height = superVC.view.bounds.size.height;
    WYHQSettingView *settingView = [WYHQSettingView settingView];
    settingView.frame = CGRectMake(0 - settingViewWidth, 0, settingViewWidth, height);
    settingView.superViewController = superVC;
    settingView.gotoViewContoller = gotoVC;
    [bgView addSubview:settingView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bgView.alpha = 1;
        settingView.frame = CGRectMake(0, 0, settingViewWidth, height);
    } completion:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:settingView action:@selector(hideSettingView)];
    [bgView addGestureRecognizer:tap];
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
    [self.headImageView addGestureRecognizer:tap];
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] valueForKey:mineHeader];
    if (imageData) {
        self.headImageView.image = [UIImage imageWithData:imageData];
    }
    
    NSDate *firstDate = UserDefaultGetObj(@"firstDay");
    NSInteger date = [NSDate hj_daysAgo:firstDate];
    date = date < 0 ? 0 : date;
    self.titleLabel.text = [NSString stringWithFormat:@"您已坚持记账%ld天",date + 1];
    
    UITapGestureRecognizer *tmpTap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tmpTap];
    
    self.safeSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCachedTouchIdStatus];
    
    self.safeSwitchTipLabel.text = safeSwitchTip;
}

- (IBAction)buttonClick:(UIButton *)sender {
    NSInteger type = sender.tag - 100;
    if (self.gotoViewContoller) {
        
        UIViewController *vc;
        if (type == 1) {
            vc = [[WYHQPrivacyAgreementViewController alloc] init];
        } else if (type == 2) {
            vc = [[WYHQFeedbackViewController alloc] init];
        } else if (type == 3) {
            vc = [[WYHQAboutViewController alloc] init];
        }
        
        [self hideSettingView:^{
            self.gotoViewContoller(vc);
        }];
    }
}

- (IBAction)switchAction:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:kCachedTouchIdStatus];
}

- (void)hideSettingView {
    [self hideSettingView:nil];
}

- (void)hideSettingView:(void (^)(void))completion {
    UIView *superView = self.superview;
    CGFloat height = self.bounds.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        superView.alpha = 0;
        self.frame = CGRectMake(0 - settingViewWidth, 0, settingViewWidth, height);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [superView removeFromSuperview];
    }];
}

- (void)selectHeadeImage {
    
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
            popoverPresentationController.sourceRect = self.headImageView.bounds;
            popoverPresentationController.sourceView = self.headImageView;
        }
    }
    
    [self.superViewController presentViewController:sheetController animated:YES completion:nil];
}

- (void)actionSheetClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            //此应用程序没有被授权访问的照片数据。可能是家长控制权限 ||
            //用户已经明确否认了这一照片数据的应用程序访问
            if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"选项中，允许花钱无忧访问你的手机相机" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 无权限 引导去开启
                    [self openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alert addAction:ok];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
                
                [alert addAction:cancle];
                
                [self.superViewController presentViewController:alert animated:true completion:nil];
            } else {
                UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                ipc.allowsEditing = YES;
                ipc.delegate = self;
                [self.superViewController presentViewController:ipc animated:YES completion:nil];
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
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相册\"选项中，允许花钱无忧访问你的手机相册" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 无权限 引导去开启
                    [self openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                
                [alert addAction:ok];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
                [alert addAction:cancle];
                
                [self.superViewController presentViewController:alert animated:true completion:nil];
            }else{
                UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                ipc.allowsEditing = YES;
                ipc.delegate = self;
                [self.superViewController presentViewController:ipc animated:YES completion:nil];
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
    
    [self.headImageView setImage:image];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:mineHeader];
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

@end
