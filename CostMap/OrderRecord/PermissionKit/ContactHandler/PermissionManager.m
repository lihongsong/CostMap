//
//  PermissionManager.m
//  
//
//  Created by wanglili on 16/6/13.
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
        HJAlertView *alert = [[HJAlertView alloc] initWithTitle:nil message:@"The current device does not support camera, please try again after changing the device" cancelButtonTitle:@"confirm" confirmButtonTitle:nil];
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

- (void)showPermissionAlertWithType:(LNPermissionType)type {
    NSString *message;
    
    switch (type) {
        case LNPermissionTypeCamera:
            message = [NSString stringWithFormat:@"Please allow %@ use the camera, otherwise it will affect your subsequent operations",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeNotification:
            message = [NSString stringWithFormat:@"Please allow %@ receive the notification and restart the application, otherwise it will affect your subsequent actions",[UIDevice hj_bundleName]];
            break;
        case LNPermissionTypeLocation:
            message = [NSString stringWithFormat:@"Please allow %@ access your location and restart the application, otherwise it will affect your subsequent actions",[UIDevice hj_bundleName]];
            break;
        default:
            break;
    }
    
    HJAlertView *alertView = [[HJAlertView alloc] initWithTitle:nil message:message cancelButtonTitle:@"cancel" confirmButtonTitle:@"setting" cancelBlock:^{
        
    } confirmBlock:^{
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    alertView.confirmColor = HJHexColor(0xff6a45);
    [alertView show];
    
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
