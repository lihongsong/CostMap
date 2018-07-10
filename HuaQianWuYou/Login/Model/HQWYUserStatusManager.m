//
//  HQWYUserStatusManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUserStatusManager.h"
#import "HQWYUserBaseInfo.h"
#import "DES3Util.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
/*#import <Bugly/Bugly.h>
#import "HQWYUserBaseInfo+JKService.h"
#import "JKQuotaResult+JKService.h"
#import "AppDelegate+JKRisk.h"
#import "JKQuota+JKService.h"
#import "JKUserManager.h"
#import "ILApplyInfoManager.h"
#import "ILResultStatus+ILLoginService.h"
 */

/// token的key值和之前老的key值一样，以便网络请求头处理简单
static NSString *const kTokenKey = @"user_token";
//--------------------------------------------------------------------//
static NSString *const kUserBaseInfoKey = @"hqwy_user_base_info";
static NSString *const KLastMobilePhoneKey = @"hqwy_last_mobilephone";


@interface HQWYUserStatusManager ()

@property (nonatomic, strong) HQWYUserBaseInfo *userBaseInfo;
@property (nonatomic, copy) NSString *token;

@property (nonatomic, strong) NSURLSessionDataTask *updateUserDataTask;
@end



@implementation HQWYUserStatusManager
@synthesize token = _token;
@synthesize userBaseInfo = _userBaseInfo;

+ (instancetype)sharedInstance {
    static HQWYUserStatusManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setToken:(NSString *)token {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
    if (!token) {
        [keychain removeItemForKey:kTokenKey];
        _token = token;
        return;
    }
    if (_token != token) {
        _token = token;
        NSString *tokenStr = [DES3Util encryptObject:_token];
        keychain[kTokenKey] = tokenStr;
    }
}

- (NSString *)token {
    if (!_token) {
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
        NSString *userTokenStr = keychain[kTokenKey];
        return [DES3Util decryptString:userTokenStr];
    }
    return _token;
}

- (void)setUserBaseInfo:(HQWYUserBaseInfo *)userBaseInfo {
    if (!userBaseInfo) {
        [self removeUserBaseInfo];
        _userBaseInfo = userBaseInfo;
        return;
    }
    if (_userBaseInfo != userBaseInfo) {
        _userBaseInfo = userBaseInfo;
        NSString *infoString = [DES3Util encryptObject:_userBaseInfo];
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:infoString forKey:kUserBaseInfoKey];
        [archiver finishEncoding];
        [data writeToFile:[self pathForInfoInLocal] atomically:YES];
    }
}

- (HQWYUserBaseInfo *)userBaseInfo {
    if (!_userBaseInfo) {
        NSData *data = [NSData dataWithContentsOfFile:[self pathForInfoInLocal]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        id result = [unarchiver decodeObjectForKey:kUserBaseInfoKey];
        [unarchiver finishDecoding];
        _userBaseInfo = [DES3Util decryptString:result];
        return _userBaseInfo;
    }
    return _userBaseInfo;
}

#pragma mark - StoredUserInfo

- (void)storeNeedStoredUserInfomation:(HQWYUserBaseInfo *)userInfo {
    if (userInfo) {
        self.userBaseInfo = userInfo;
        [self storeUserMobilePhone:userInfo.mobilephone];
        // Bugly设置用户标示
       // [Bugly setUserIdentifier:userInfo.userId ?: @""];
    }
}

- (void)storeUserMobilePhone:(NSString *)mobilePhone {
    if (mobilePhone) {
        NSString *mobilePhoneStr = [DES3Util encryptObject:mobilePhone];
        [[NSUserDefaults standardUserDefaults] setObject:mobilePhoneStr forKey:KLastMobilePhoneKey];
    }
}


- (void)deleteUserInfo {
    self.userBaseInfo = nil;
    self.token = nil;
}

- (void)removeUserBaseInfo {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:[self pathForInfoInLocal]]) {
        BOOL success =[defaultManager removeItemAtPath:[self pathForInfoInLocal] error:nil];
        if (success) { NSLog(@"清空成功");}
    }
}
- (NSString *)pathForInfoInLocal {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kUserBaseInfoKey];
}

+ (void)handleInvalidateToken:(NSDictionary *)dict {
    if (HQWYUserStatusSharedManager.showingTokenValidateAlertView) {
        return;
    }
    
    HJAlertView *alert = [[HJAlertView alloc] initWithTitle:nil message:dict[@"message"] confirmButtonTitle:@"确定" confirmBlock:^{
        [HQWYUserManager sharedInstance].showingTokenValidateAlertView = NO;
        //  [SharedAppDelegate logoutAndLoginAgain];
    }];
    [alert show];
    [HQWYUserManager sharedInstance].showingTokenValidateAlertView = YES;
}

+ (NSString *)lastLoginMobilePhone {
    NSString *mobilStr = [[NSUserDefaults standardUserDefaults] objectForKey:KLastMobilePhoneKey];
    if (mobilStr) {
        return [DES3Util decryptString:mobilStr];
    }
    return nil;
}


+ (BOOL)hasAlreadyLoggedIn {
    return [HQWYUserManager hasAlreadyLoggedIn];
}

//
//+ (BOOL)hasAlreadySignedUp {
//    return [[NSUserDefaults standardUserDefaults] boolForKey:KSignedUpKey];
//}
//
//+ (void)setAlreadySignedUp {
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KSignedUpKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
@end
