//
//  LoginInfoModel.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LoginInfoModel.h"
#import "DES3Util.h"
#import "YYModel.h"

static NSString *userNameKey = @"userName";
static NSString *passwordKey = @"password";
static NSString *rememberKey = @"Remember";

@implementation LoginInfoModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
            @"userInfo": [LoginUserInfoModel class],
    };
}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self yy_modelEncodeWithCoder:aCoder];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    return [self yy_modelInitWithCoder:aDecoder];
//}


@end

@implementation LoginUserInfoModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

+ (LoginUserInfoModel *)cachedLoginModel {
    NSString *encryptString = UserDefaultGetObj(kCachedUserLoginModel);
    
    LoginUserInfoModel *model = [DES3Util decryptString:encryptString];
    return model;
}

+ (void)cacheLoginModel:(LoginUserInfoModel *)userLoginModel {
    NSString *usersLoginString = [DES3Util encryptObject:userLoginModel];
    
    UserDefaultSetObj(usersLoginString, kCachedUserLoginModel);
}

//保存用户名和密码
+ (void)cacheUserName:(NSString *)userName password:(NSString *)password {
    if (!StrIsEmpty(userName)) {
        UserDefaultSetObj(userName, userNameKey);
    } else {
        UserDefaultSetObj(nil, userNameKey);
    }
    if (!StrIsEmpty(password)) {
        UserDefaultSetObj(password, passwordKey);
    } else {
        UserDefaultSetObj(nil, passwordKey);
        
    }
}

//是否记住密码 1代表记住密码  0代表  不记住密码
+ (void)cacheRememberPassword:(NSString *)isRemember {
    if (isRemember) {//记住
        UserDefaultSetObj(isRemember, rememberKey);
        
    } else {//不记住
        UserDefaultSetObj(isRemember, rememberKey);
        
    }
}
@end
