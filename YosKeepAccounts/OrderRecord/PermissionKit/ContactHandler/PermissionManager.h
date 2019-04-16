//
//  PermissionManager.h
//  JiKeLoan
//
//  Created by wanglili on 16/6/13.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 系统权限
typedef NS_ENUM(NSInteger, LNPermissionType) {
    LNPermissionTypeCamera = 10,
    LNPermissionTypeMicrophone,
    LNPermissionTypeNotification,
    LNPermissionTypeLocation,
    LNPermissionTypeAddressBook
};

@interface PermissionManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)checkCameraAuthorization;
- (BOOL)checkMicrophoneAuthorization;
- (void)checkNotificationAuthorization;
- (BOOL)checkLocationAuthorization;
- (BOOL)checkAddressBookAuthorization;

- (void)showPermissionAlertWithType:(LNPermissionType)type;

/**
 检查通讯录权限
 
 @param result <#result description#>
 @param showAlert <#showAlert description#>
 */
+ (void)checkContactPermissionWithResult:(void (^) (BOOL allow))result showAlert:(BOOL)showAlert;

//获取录音权限
+ (void)showVoiceGuideAlertConfirmClick:(void (^) (void))confirmClick
                            cancelClick:(void (^) (void))cancelClick;
@end
