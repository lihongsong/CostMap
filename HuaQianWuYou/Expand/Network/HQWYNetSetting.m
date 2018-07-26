//
//  HQWYNetSetting.m
//  HuaQianWuYou
//
//  Created by yoser on 2018/7/20.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYNetSetting.h"

static NSString * const kTextFieldHost = @"debug_url_perference_TextField";
static NSString * const kMultiHost = @"debug_url_perference_Multi";

static NSString * const memberDefaultPath = @"http://t1-static.huaqianwy.com/mem";
static NSString * const productDefaultPath = @"http://t1-static.huaqianwy.com/api";
static NSString * const hqwyV1DefaultPath = @"http://appjieqian.2345.com/index.php";
static NSString * const activeDefaultPath = @"http://t1-static.huaqianwy.com/hqwy/dist/#/home";
static NSString * const aggrementDefaultPath = @"http://t1-static.huaqianwy.com/hqwy/dist/#/userServiceAgreement";

@implementation HQWYNetSetting

+ (NSString *)memberPath {
    
    NSString *host = [self settingHost];
    
    if (!host) {
        return memberDefaultPath;
    } else {
        return [host stringByAppendingPathComponent:@"mem"];
    }
}

+ (NSString *)productPath {
    
    NSString *host = [self settingHost];
    
    if (!host) {
        return productDefaultPath;
    } else {
        return [host stringByAppendingPathComponent:@"api"];
    }
}

+ (NSString *)activePath {
    NSString *host = [self settingHost];
    
    if (!host) {
        return activeDefaultPath;
    } else {
        return [host stringByAppendingPathComponent:@"hqwy/dist/#/home"];
    }
}

+ (NSString *)agreementPath {
    NSString *host = [self settingHost];
    
    if (!host) {
        return aggrementDefaultPath;
    } else {
        return [host stringByAppendingPathComponent:@"hqwy/dist/#/userServiceAgreement"];
    }
}

+ (NSString *)hqwyV1Path {
    return hqwyV1DefaultPath;
}

+ (NSString *)settingHost {
    
    NSString *host = [[NSUserDefaults standardUserDefaults] objectForKey:kTextFieldHost];
    
    if (!host) {
        host = [[NSUserDefaults standardUserDefaults] objectForKey:kMultiHost];
    }
    return host;
}

@end
