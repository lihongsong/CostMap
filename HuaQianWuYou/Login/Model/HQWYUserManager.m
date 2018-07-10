//
//  HQWYUserManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUserManager.h"
#import "DES3Util.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
//#import <Bugly/Bugly.h>
//保存的最后登录手机
#define kMobilePhoneForUserDefault @"login_mobilephone"
//保存的最后登录用户的customerID
#define kuserCustomerIDForUserDefault @"user_customerID"
#define KuserTokenKey @"user_token"

@interface HQWYUserManager ()

@property (nonatomic, assign) BOOL showingCreditLineAlertView;
@property (nonatomic, strong) HQWYUser *userInfo;

@property (nonatomic, strong) NSURLSessionDataTask *retrieveUserDataTask;

@end

@implementation HQWYUserManager
@synthesize userToken = _userToken;

+ (instancetype)sharedInstance {
    static HQWYUserManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance readUserInfoFromSandbox]; // 处理版本兼容的本地数据信息
        //[_instance startMonitorNetChange];
    });
    return _instance;
}

#pragma mark 处理用户升级的问题
// 反归档
- (void)readUserInfoFromSandbox {
    // 从本地（kUserArchiverFileName文件中）获取.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kUserArchiverFileName];
    
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    //  如何本地没有数据则 直接return掉
    if (data.length <= 0) {
        return;
    }
    // 反归档.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    HQWYUser *userInfo = nil;
     if ([[unarchiver decodeObjectForKey:kUserArchiverKey] isKindOfClass:[NSString class]]) {
        
        // 解档出用户信息，并解密
        NSString *userInfoString = [unarchiver decodeObjectForKey:kUserArchiverKey];
        
        userInfo = [DES3Util decryptString:userInfoString];
    } else {
        userInfo = nil;
    }
    
    // 反归档结束.
    [unarchiver finishDecoding];
    
    self.userInfo = userInfo;
    
    [self storeNeedStoredUserInfomation:userInfo];
    
    // 清楚本地保留的数据信息
    [self deleteUserInfoInSandbox];
}

// 清除本地archiver的信息
- (void)deleteUserInfoInSandbox {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kUserArchiverFileName];
    
    if ([defaultManager isDeletableFileAtPath:file]) {
        [defaultManager removeItemAtPath:file error:nil];
    }
}

//用户是否已经登录
+ (BOOL)hasAlreadyLoggedIn {
    // token存放在keychain中，用户删除app再安装，还是可以获取到。为了保持跟之前版本的表现一致，“是否登录”添加一个判断条件：customerID
    if ([[self sharedInstance] userToken] && [self lastUserCustomerID]) {
        return YES;
    }
    return NO;
}

#pragma mark 需要存储到本地的信息及读取
// 用户的手机号、customID 及token信息 采用3DES 进行加密
- (void)storeNeedStoredUserInfomation:(HQWYUser *)userInfo {
    if (userInfo) {
        [self storeUserMobilePhone:userInfo.mobilephone];
       // [self dealUserApplicationIconBadgeNumber:userInfo];
        // Bugly设置用户标示
      //  [Bugly setUserIdentifier:userInfo.userId.stringValue?:@""];
    }
}

- (void)setUserToken:(NSString *)userToken {
    if (userToken) {
        _userToken = userToken;
        NSString *tokenStr = [DES3Util encryptObject:userToken];
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
        keychain[KuserTokenKey] = tokenStr;
    }
}

- (void)storeCustomerID:(NSString *)customerID {
    if (customerID) {
        NSString *customerIDStr = [DES3Util encryptObject:customerID];
        [[NSUserDefaults standardUserDefaults] setObject:customerIDStr forKey:kuserCustomerIDForUserDefault];
    }
}

// 外界需要调用保存mobilePhone
- (void)storeUserMobilePhone:(NSString *)mobilePhone {
    if (mobilePhone) {
        NSString *mobilePhoneStr = [DES3Util encryptObject:mobilePhone];
        [[NSUserDefaults standardUserDefaults] setObject:mobilePhoneStr forKey:kMobilePhoneForUserDefault];
    }
}

#pragma mark 获取用户的相关token、customerID及mobile Phone
//从keychain中获取用户上次登录成功的token
- (NSString *)userToken {
    if (!_userToken) {
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
        NSString *userTokenStr = keychain[KuserTokenKey];
        if (userTokenStr) {
            _userToken = [DES3Util decryptString:userTokenStr];
        }
    }
    return _userToken;
}

//从UserDefault中获取用户上次登录成功的手机号码
+ (NSString *)lastLoginMobilePhone {
    
    NSString *mobilStr = [[NSUserDefaults standardUserDefaults] objectForKey:kMobilePhoneForUserDefault];
    if (mobilStr) {
        return [DES3Util decryptString:mobilStr];
    }
    
    return nil;
}

//从UserDefault中获取用户上次登录成功的CustomerID
+ (NSString *)lastUserCustomerID {
    
    NSString *customerIdStr = [[NSUserDefaults standardUserDefaults] objectForKey:kuserCustomerIDForUserDefault];
    if (customerIdStr) {
        return [DES3Util decryptString:customerIdStr];
    }
    
    return nil;
}

// 从NSUserDefaults中删存储的用户信息
- (void)deleteUserInfo {
    self.userInfo = nil;
    _userToken = nil;
    // 删除keychain中的token信息
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
    keychain[KuserTokenKey] = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kuserCustomerIDForUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//清除通知栏
//- (void)dealUserApplicationIconBadgeNumber:(JKUser *)userInfo {
//
//    if ([HQWYUserManager lastLoginMobilePhone] && ![[HQWYUserManager lastLoginMobilePhone] isEqualToString:userInfo.mobilephone]) {
//        [MiPushSDK unsetAlias:[HQWYUserManager lastUserCustomerID]];
//
//        /*
//         如果推送 APN 时，Badge number 被指定为0 ，则可能出现 APN 消息在通知中心被点击后，
//         尽管调用了 [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//         但 APN 消息在通知中心不会被删除的情况。 这种情况可以按如下代码调用以清除通知中心的 APN 通知。
//         [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
//         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//         */
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    }
//}

+ (void)handleInvalidateToken:(NSDictionary *)dict {
    if ([HQWYUserManager sharedInstance].showingTokenValidateAlertView) {
        return;
    }
    
//    HJAlertView *alert = [[HJAlertView alloc] initWithTitle:nil message:dict[@"message"] confirmButtonTitle:@"确定" confirmBlock:^{
//        [HQWYUserManager sharedInstance].showingTokenValidateAlertView = NO;
//      //  [SharedAppDelegate logoutAndLoginAgain];
//    }];
//    [alert show];
    [HQWYUserManager sharedInstance].showingTokenValidateAlertView = YES;
}

@end
