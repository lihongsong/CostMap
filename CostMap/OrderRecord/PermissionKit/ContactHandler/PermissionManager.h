//
//  PermissionManager.h
//
//  Created by wanglili on 16/6/13.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LNPermissionType) {
    LNPermissionTypeCamera = 10,
    LNPermissionTypeNotification,
    LNPermissionTypeLocation
};

@interface PermissionManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)checkCameraAuthorization;
- (void)checkNotificationAuthorization;
- (BOOL)checkLocationAuthorization;

- (void)showPermissionAlertWithType:(LNPermissionType)type;

@end
