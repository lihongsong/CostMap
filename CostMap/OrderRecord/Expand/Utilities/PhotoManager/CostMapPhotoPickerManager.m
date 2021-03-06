#import "CostMapPhotoPickerManager.h"
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
@interface CostMapPhotoPickerManager() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (copy, nonatomic) CostMapPhotoPickerBlock photoBlock;
@end
@implementation CostMapPhotoPickerManager
static CostMapPhotoPickerManager *manager;
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [CostMapPhotoPickerManager new];
    });
    return manager;
}
- (void)photoPickerFromPresenter:(UIPresenter *)viewCotroller result:(CostMapPhotoPickerBlock)result {
    if (_photoBlock) {
        !result?:result(nil, [NSError errorWithDomain:@"正在采集图片中" code:0 userInfo:nil]);
        return ;
    }
    self.photoBlock = result;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [viewCotroller presentPresenter:alert animated:YES completion:nil];
}
- (void)photoClickFromSceneConroller:(UIPresenter *)viewController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"提示"
                                                message:@"请在设备的\"设置-隐私-相册\"选项中，允许花钱无忧访问你的手机相册"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([UIDevice currentDevice].systemVersion.integerValue >= 10.0) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    }];
                } else {
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }];
            [alert addAction:okAction];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                           }];
            [alert addAction:cancle];
            [viewController presentPresenter:alert animated:true completion:nil];
            _photoBlock?:_photoBlock(nil, [NSError errorWithDomain:@"没有权限" code:0 userInfo:nil]);
            _photoBlock = nil;
        } else {
            UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.allowsEditing = YES;
            ipc.delegate = self;
            [viewController presentPresenter:ipc animated:YES completion:nil];
        }
        return ;
    } else {
        UIAlertScene * alert = [[UIAlertScene alloc] initWithTitle:@"提示"
                                                         message:@"该设备相册不可使用"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
        [alert show];
        _photoBlock?:_photoBlock(nil, [NSError errorWithDomain:@"不可用" code:0 userInfo:nil]);
        _photoBlock = nil;
        return;
    }
}
- (void)cameraClickFromPresenter:(UIPresenter *)viewController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted ||
            authStatus == AVAuthorizationStatusDenied)   {
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"提示"
                                                message:@"请在设备的\"设置-隐私-相机\"选项中，允许无忧钱包访问你的手机相机"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ( [UIDevice currentDevice].systemVersion.integerValue >= 10.0) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    }];
                } else {
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }];
            [alert addAction:ok];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancle];
            [viewController presentPresenter:alert animated:true completion:nil];
            _photoBlock?:_photoBlock(nil, [NSError errorWithDomain:@"没有权限" code:0 userInfo:nil]);
            _photoBlock = nil;
        } else {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.allowsEditing = YES;
            ipc.delegate = self;
            [viewController presentPresenter:ipc animated:YES completion:nil];
        }
    } else {
        UIAlertScene * alert = [[UIAlertScene alloc] initWithTitle:@"提示"
                                                         message:@"该设备相机不可使用"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
        [alert show];
        _photoBlock?:_photoBlock(nil, [NSError errorWithDomain:@"不可用" code:0 userInfo:nil]);
        _photoBlock = nil;
        return;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    _photoBlock?:_photoBlock(nil, [NSError errorWithDomain:@"取消" code:0 userInfo:nil]);
    _photoBlock = nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissPresenterAnimated:YES completion:nil];
    _photoBlock?:_photoBlock(image, nil);
    _photoBlock = nil;
}
@end
