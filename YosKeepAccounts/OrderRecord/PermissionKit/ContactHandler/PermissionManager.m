//
//  PermissionManager.m
//  JiKeLoan
//
//  Created by wanglili on 16/6/13.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import "PermissionManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#import <UserNotifications/UserNotifications.h>
#import <Contacts/Contacts.h>
#import <AddressBookUI/AddressBookUI.h>
#import <HJ_UIKit/HJAlertView.h>

//#import "DeviceHelp.h"


static PermissionManager *sharedInstance;

@interface PermissionManager ()

@end
@implementation PermissionManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return  sharedInstance;
}

- (BOOL)checkCameraAuthorization {
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        HJAlertView *alert = [[HJAlertView alloc] initWithTitle:nil message:@"当前设备不支持相机，请更换设备后再试" cancelButtonTitle:@"确定" confirmButtonTitle:nil];
        alert.cancelColor = HJHexColor(0xff6a45);
        [alert show];
        return NO;
    }
    
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) {
        [self showPermissionAlertWithType:LNPermissionTypeCamera];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkMicrophoneAuthorization {
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio] == AVAuthorizationStatusDenied) {
        [self showPermissionAlertWithType:LNPermissionTypeMicrophone];
        return NO;
    }
    
    return YES;
}

- (void)checkNotificationAuthorization  {
    WEAK_SELF
    if (IOS_VERSION_10_OR_ABOVE) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            STRONG_SELF
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                [self showPermissionAlertWithType:LNPermissionTypeNotification];
            }
        }];
    } else if (IOS_VERSION_8_OR_ABOVE) {
        UIUserNotificationType currentType =[[UIApplication sharedApplication] currentUserNotificationSettings].types;
        if (currentType == UIUserNotificationTypeNone) {
            [weakSelf showPermissionAlertWithType:LNPermissionTypeNotification];
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType currentType = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (currentType == UIRemoteNotificationTypeNone) {
            [weakSelf showPermissionAlertWithType:LNPermissionTypeNotification];
        }
#pragma clang diagnostic pop
    }
}

- (BOOL)checkLocationAuthorization {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self showPermissionAlertWithType:LNPermissionTypeLocation];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkAddressBookAuthorization {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    __block BOOL accessGranted = NO;
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        accessGranted = granted;
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (accessGranted == NO) {
        [self showPermissionAlertWithType:LNPermissionTypeAddressBook];
        return NO;
    }
    
    return YES;
}

- (void)showPermissionAlertWithType:(LNPermissionType)type {
    NSString *message;
    
    switch (type) {
        case LNPermissionTypeCamera:
            message = [NSString stringWithFormat:@"请允许%@使用相机，否则会影响您的后续操作",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeMicrophone:
            message = [NSString stringWithFormat:@"请允许%@使用麦克风，否则会影响您的后续操作",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeNotification:
            message = [NSString stringWithFormat:@"请允许%@接收通知并重启应用，否则会影响您的后续操作",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeLocation:
            message = [NSString stringWithFormat:@"请允许%@访问您的位置并重启应用，否则会影响您的后续操作",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeAddressBook:
            message = [NSString stringWithFormat:@"获取通讯录权限失败，请允许%@获取您的通讯录信息",[UIDevice hj_bundleName]];
            break;
        default:
            break;
    }
    
    HJAlertView *alertView = [[HJAlertView alloc] initWithTitle:nil message:message cancelButtonTitle:@"取消" confirmButtonTitle:@"设置" cancelBlock:^{
        
    } confirmBlock:^{
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    alertView.confirmColor = HJHexColor(0xff6a45);
    [alertView show];
    
}



+ (void)checkContactPermissionWithResult:(void (^) (BOOL allow))result showAlert:(BOOL)showAlert {
    
    if (@available(iOS 9.0, *)) {
        //ios9 及以上
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                [self showContactGuideAlert:result showAlert:showAlert granted:granted];
            }];
        } else if (status == CNAuthorizationStatusDenied) {
            [self showContactGuideAlert:result showAlert:showAlert];
        } else {
            // 用户同意
            !result?:result(YES);
        }
    } else {
        //ios 8
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        if (status == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                [self showContactGuideAlert:result showAlert:showAlert granted:granted];
            });
        } else if (status == kABAuthorizationStatusDenied) {
            [self showContactGuideAlert:result showAlert:showAlert];
        } else {
            // 用户同意
            !result?:result(YES);
        }
    }
}

+ (void)showContactGuideAlert:(void (^) (BOOL allow))result showAlert:(BOOL)showAlert granted:(BOOL)granted {
    if (!granted) {
        [self showContactGuideAlert:result showAlert:showAlert];
    } else {
        // 获取到权限结果 同意
        !result?:result(YES);
    }
}

+ (void)showContactGuideAlert:(void (^) (BOOL allow))result showAlert:(BOOL)showAlert {
    if (showAlert) {
        // 获取到权限结果 被拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            // 获取到权限结果 被拒绝
            [self showContactGuideAlertConfirmClick:nil cancelClick:nil];
        });
    } else {
        !result?:result(NO);
    }
}

//获取通讯录权限
+ (void)showContactGuideAlertConfirmClick:(void (^) (void))confirmClick
                              cancelClick:(void (^) (void))cancelClick {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showGuideAlertWithTitle:@"请允许获取通讯录权限"
                           topContent:@"当前操作需要通讯录权限，请打开权限"
                        bottomContent:@"\n \n设置路径：设置->隐私->通讯录"
                              confirm:@"去设置"
                         confirmClick:^{
                             // 跳转去设置
                             [self skipToSetting];
                             !confirmClick?:confirmClick();
                         }
                          cancelClick:^{
                              !cancelClick?:cancelClick();
                          }];
    });
}

//获取录音权限
+ (void)showVoiceGuideAlertConfirmClick:(void (^) (void))confirmClick
                              cancelClick:(void (^) (void))cancelClick {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showGuideAlertWithTitle:@"请允许获取录音权限"
                           topContent:@"当前操作需要录音权限，请打开权限"
                        bottomContent:@"\n \n设置路径：设置->隐私->录音"
                              confirm:@"去设置"
                         confirmClick:^{
                             // 跳转去设置
                             [self skipToSetting];
                             !confirmClick?:confirmClick();
                         }
                          cancelClick:^{
                              !cancelClick?:cancelClick();
                          }];
    });
}

+ (void)skipToSetting {
    
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

+ (void)showGuideAlertWithTitle:(NSString *)title
                     topContent:(NSString *)topContent
                  bottomContent:(NSString *)bottomContent
                        confirm:(NSString *)confirm
                   confirmClick:(void (^) (void))confirmClick
                    cancelClick:(void (^) (void))cancelClick {
    
    NSMutableAttributedString *attributeString = [NSMutableAttributedString new];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 7;
    
    NSDictionary *topParam = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName: HJHexColor(0x333333),
                               NSParagraphStyleAttributeName: paragraphStyle
                               };
    
    NSDictionary *bottomParam = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:13],
                                  NSForegroundColorAttributeName: HJHexColor(0x666666)
                                  };
    
    NSAttributedString *topContentString =
    [[NSAttributedString alloc] initWithString:topContent
                                    attributes:topParam];
    
    NSAttributedString *bottomContentString =
    [[NSAttributedString alloc] initWithString:bottomContent
                                    attributes:bottomParam];
    
    [attributeString appendAttributedString:topContentString];
    [attributeString appendAttributedString:bottomContentString];
    
    HJAlertView *alertView =
    [[HJAlertView alloc] initWithTitle:title
                      attributeMessage:attributeString
                    confirmButtonTitle:confirm
                          confirmBlock:^{
                              !confirmClick?:confirmClick();
                          }];
    
    alertView.cancelBlock = ^{
        !cancelClick?:cancelClick();
    };
    
    alertView.revokable = YES;
    alertView.confirmColor = HJHexColor(0x3097fd);
    alertView.titleLabel.textAlignment = NSTextAlignmentLeft;
    alertView.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    alertView.titleLabel.textColor = HJHexColor(0x333333);
    
    [alertView show];
    
    return ;
}
@end
