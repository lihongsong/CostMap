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
//#import <UICKeyChainStore/UICKeyChainStore.h>
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
static NSString *const kUserBaseInfoKey = @"jk_user_base_info";
static NSString *const kInWhiteListKey = @"jk_in_white_list";
static NSString *const KUserCreditKey = @"jk_user_credit";
static NSString *const KLastMobilePhoneKey = @"jk_last_mobilephone";
static NSString *const KSignedUpKey = @"jk_signed_up";

@interface HQWYUserStatusManager ()

@property (nonatomic, strong) HQWYUserBaseInfo *userBaseInfo;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSInteger creditScore;

@property (nonatomic, copy) NSString *borrowUUID;
@property (nonatomic, copy) NSString *repaymentUUID;
@property (nonatomic, copy) NSString *generateUUID;

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
       // [_instance startMonitorNetChange];
       // ILNCaddObserver(_instance, @selector(clearMessageReminds), kNotificationClearMessageRemainds, nil);
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.borrowUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.repaymentUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.generateUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return self;
}
//
//#pragma mark - UpdateUserInfoWithoutRequst
//
//- (void)freshUserStatusWithoutRequst:(NSNumber *)status needNotification:(BOOL)needNotif {
//
//    self.userBaseInfo.status = status;
//    [self freshUserInformationWithoutRequst:_userBaseInfo];
//
//    if (status && needNotif) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kJKNotUserInfoUpdate object:nil];
//    }
//}
//
///**
// *  更新userInfo 不发送请求 不发送通知
// */
//
//- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo {
//    [self freshUserInformationWithoutRequst:userInfo needNotification:NO];
//}
//
///**
// *  更新Userinfo 不需要发起请求
// */
//
//- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo needNotification:(BOOL)needNotif {
//    if (userInfo) {
//        [self storeNeedStoredUserInfomation:userInfo];
//    }
//    if (userInfo && needNotif) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kJKNotUserInfoUpdate object:nil];
//    }
//}
//
///**
// *  更新userInfo 且需要发送通知
// *
// *  @param userInfo 回掉成功的数据信息
// *  @parma needNotif 是否需要通知
// *  @parma storeToken 存储token信息
// */
//- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo needNotification:(BOOL)needNotif needStoreToken:(BOOL)storeToken {
//    if (userInfo.token.length > 0 && storeToken) {
//        self.token = userInfo.token;
//    }
//    [self freshUserInformationWithoutRequst:userInfo needNotification:needNotif];
//}
//
//#pragma mark - UpdateUserInfoWithRequst
//
///**
// *  只更新userInfo 不发送通知 不现实loading
// *  @param userInfo 回掉成功的数据信息
// */
//
//- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo {
//    [self freshUserInformation:userInfo showLoading:NO];
//}
//
///**
// *  只更新userInfo 不发送通知
// *  @param showLoading 是否展示loading状体
// *  @param userInfo 回掉成功的数据信息
// */
//
//- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo showLoading:(BOOL)showLoading {
//    [self freshUserInformation:userInfo needNotification:NO showLoading:showLoading];
//}
//
///**
// *  更新userInfo 且需要发送通知
// *
// *  @param userInfo 回掉成功的数据信息
// *  @parma needNotif 是否需要通知
// */
//
//- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo needNotification:(BOOL)needNotif {
//    [self freshUserInformation:userInfo needNotification:needNotif showLoading:NO];
//}
//
///**
// *  更新userInfo 且需要发送通知
// *
// *  @param userInfo 回掉成功的数据信息
// *  @param showLoading 是否展示loading 状态
// *  @parma needNotif 是否需要通知
// */
//
//- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo needNotification:(BOOL)needNotif showLoading:(BOOL)showLoading {
//    if (![HQWYUserStatusManager hasAlreadyLoggedIn]) {
//        return;
//    }
//    if (showLoading) {
//        [KeyWindow ln_showLoadingHUD];
//    }
//    _updateUserDataTask =
//    [HQWYUserBaseInfo requestUserStatusWithCompletion:^(HQWYUserBaseInfo *_Nullable result, NSError *_Nullable error) {
//        /// 此接口只返回status字段，用户的基本信息不返回，基本信息在用户登录接口持久化存储
//        if (error) {
//            if (showLoading) {
//                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
//                                      message:[error jk_errorMessage]];
//            } else {
//                [error jk_errorMessage];
//            }
//            return;
//        }
//        if (result.status) {
//
//            [JKUserStatusSharedManager userBaseInfo].status = result.status;
//
//            if (showLoading) {
//                [KeyWindow ln_hideProgressHUD];
//            }
//            if (userInfo) {
//                userInfo(result);
//            }
//            if (needNotif) {
//                [kNotificationCenter postNotificationName:kJKNotUserInfoUpdate object:nil];
//            }
//        } else {
//            if (showLoading) {
//                [KeyWindow ln_hideProgressHUD];
//            }
//        }
//    }];
//}
//
//#pragma mark - Private Method
//
//- (void)startMonitorNetChange {
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusDidChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
//}
//
//- (void)networkStatusDidChange:(NSNotification *)notify {
//    AFNetworkReachabilityStatus status = [[notify.userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem] integerValue];
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
//
//        if (self.userBaseInfo == nil && [JKUserStatusManager hasAlreadyLoggedIn] && self.inWhiteList) {
//            [self freshUserInformation:nil needNotification:YES];
//        }
//    }
//}
//
//- (NSString *)pathForInfoInLocal {
//    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kUserBaseInfoKey];
//}
//
//- (void)setToken:(NSString *)token {
//    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
//    if (!token) {
//        [keychain removeItemForKey:kTokenKey];
//        _token = token;
//        return;
//    }
//    if (_token != token) {
//        _token = token;
//        NSString *tokenStr = [DES3Util encryptObject:_token];
//        keychain[kTokenKey] = tokenStr;
//    }
//}
//
//- (NSString *)token {
//    if (!_token) {
//        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:nil];
//        NSString *userTokenStr = keychain[kTokenKey];
//        return [DES3Util decryptString:userTokenStr];
//    }
//    return _token;
//}
//
//- (void)setUserBaseInfo:(HQWYUserBaseInfo *)userBaseInfo {
//    if (!userBaseInfo) {
//        [self removeUserBaseInfo];
//        _userBaseInfo = userBaseInfo;
//        return;
//    }
//    if (_userBaseInfo != userBaseInfo) {
//        _userBaseInfo = userBaseInfo;
//        NSString *infoString = [DES3Util encryptObject:_userBaseInfo];
//        NSMutableData *data = [NSMutableData data];
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//        [archiver encodeObject:infoString forKey:kUserBaseInfoKey];
//        [archiver finishEncoding];
//        [data writeToFile:[self pathForInfoInLocal] atomically:YES];
//    }
//}
//
//- (HQWYUserBaseInfo *)userBaseInfo {
//    if (!_userBaseInfo) {
//        NSData *data = [NSData dataWithContentsOfFile:[self pathForInfoInLocal]];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        id result = [unarchiver decodeObjectForKey:kUserBaseInfoKey];
//        [unarchiver finishDecoding];
//        _userBaseInfo = [DES3Util decryptString:result];
//        return _userBaseInfo;
//    }
//    return _userBaseInfo;
//}
//
//- (NSString *)regularExpressionUrl {
//    return [[NSUserDefaults standardUserDefaults] objectForKey:kRegularExpressionForUserDefault];
//}
//
//#pragma mark - StoredUserInfo
//
//- (void)storeNeedStoredUserInfomation:(HQWYUserBaseInfo *)userInfo {
//    if (userInfo) {
//        self.userBaseInfo = userInfo;
//        [self storeUserMobilePhone:userInfo.mobilephone];
//        // Bugly设置用户标示
//        [Bugly setUserIdentifier:userInfo.userId ?: @""];
//    }
//}
//
//- (void)storeUserMobilePhone:(NSString *)mobilePhone {
//    if (mobilePhone) {
//        NSString *mobilePhoneStr = [DES3Util encryptObject:mobilePhone];
//        [[NSUserDefaults standardUserDefaults] setObject:mobilePhoneStr forKey:KLastMobilePhoneKey];
//    }
//}
//
//-(void)updateBorrowUUID {
//    self.borrowUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
//}
//
//-(void)updateRepaymentUUID {
//    self.repaymentUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
//}
//
//-(void)updateGenerateUUID {
//    self.generateUUID = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
//}
//
//#pragma mark - Public Method
//
//- (void)refreshUserCreditScore:(NSInteger)creditScore {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *mobilePhone = self.userBaseInfo.mobilephone;
//    [userDefault setValue:@(creditScore) forKey:[NSString stringWithFormat:@"%@-%@", mobilePhone, KUserCreditKey]];
//    [userDefault synchronize];
//    self.creditScore = creditScore;
//}
//
//- (void)deleteUserInfo {
//    self.userBaseInfo = nil;
//    self.token = nil;
//    self.inWhiteList = NO;
//    self.dealPwdHasSet = NO;
//    self.bankcardHasSet = NO;
//}
//
//- (void)removeUserBaseInfo {
//    NSFileManager *defaultManager = [NSFileManager defaultManager];
//    if ([defaultManager isDeletableFileAtPath:[self pathForInfoInLocal]]) {
//        BOOL success =[defaultManager removeItemAtPath:[self pathForInfoInLocal] error:nil];
//        if (success) { DLog(@"清空成功");}
//    }
//}
//
//+ (void)handleInvalidateToken:(NSDictionary *)dict {
//    if (JKUserStatusSharedManager.showingTokenValidateAlertView) {
//        return;
//    }
//    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//
//        JKUserStatusSharedManager.showingTokenValidateAlertView = NO;
//        [SharedAppDelegate logoutAndLoginAgain];
//
//    }
//                                  title:nil
//                                message:dict[@"message"]
//                       cancelButtonName:nil
//                      otherButtonTitles:@"确认", nil];
//    JKUserStatusSharedManager.showingTokenValidateAlertView = YES;
//}
//
//+ (NSString *)lastLoginMobilePhone {
//    NSString *mobilStr = [[NSUserDefaults standardUserDefaults] objectForKey:KLastMobilePhoneKey];
//    if (mobilStr) {
//        return [DES3Util decryptString:mobilStr];
//    }
//    return nil;
//}
//

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
//- (void)clearMessageReminds
//{
//    self.personMessageReminds = nil;
//}
//
//- (void)clearAnnounceReminds
//{
//    self.personAnnounceReminds = nil;
//}
//*/
@end
