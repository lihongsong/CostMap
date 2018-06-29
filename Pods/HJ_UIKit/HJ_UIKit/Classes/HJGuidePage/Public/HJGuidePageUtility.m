//
//  HJGuidePageUtility.m
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/18.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import "HJGuidePageUtility.h"

NSString * const kGuidePageAppFirstInstall = @"kGuidePageAppFirstInstall";
NSString * const kGuidePageAppLastVersion = @"kGuidePageAppLastVersion";
NSString * const kGuidePageAppVersionString = @"CFBundleShortVersionString";
NSString * const kHJGuidePageWindowDidDismiss = @"HJGuidePageWindowDidDismiss";
NSString * const kGuidePageWKScriptMessageHandler = @"kGuidePageWKScriptMessageHandler";
CA_EXTERN NSString* HJGetStrFromUserDefaults(NSString* key) {
    if (key) return [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return nil;
}
CA_EXTERN BOOL HJGetBoolFromUserDefaults(NSString* key) {
    if (key) return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    return NO;
}
CA_EXTERN NSInteger HJGetIntFromUserDefaults(NSString* key) {
    if (key) return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return NSIntegerMin;
}
CA_EXTERN float HJGetFloatFromUserDefaults(NSString* key) {
    if (key) return [[NSUserDefaults standardUserDefaults] floatForKey:key];
    return CGFLOAT_MIN;
}
CA_EXTERN NSURL* HJGetURLFromUserDefaults(NSString* key){
    if (key) return [[NSUserDefaults standardUserDefaults] URLForKey:key];
    return nil;
}
//从UserDefault 读取 float
CA_EXTERN NSArray* HJGetArryFromUserDefaults(NSString* key){
    if (key) return [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    return nil;
}

//从UserDefault 读取 float
CA_EXTERN NSDictionary* HJGetDictionaryFromUserDefaults(NSString* key){
    if (key) return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
    return nil;
}

//从UserDefault 读取 float
CA_EXTERN NSArray<NSString *> * HJGetStringArrayFromUserDefaults(NSString* key){
    if (key) return [[NSUserDefaults standardUserDefaults] stringArrayForKey:key];
    return nil;
}
CA_EXTERN NSData * HJGetDataFromUserDefaults(NSString* key){
    if (key) return [[NSUserDefaults standardUserDefaults] dataForKey:key];
    return nil;
}

CA_EXTERN void HJSetStrFromUserDefaults(NSString* key, NSString* value) {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
CA_EXTERN void HJSetBoolFromUserDefaults(NSString* key, BOOL value) {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
CA_EXTERN void HJSetIntFromUserDefaults(NSString* key, NSInteger value) {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
CA_EXTERN void HJSetFloatFromUserDefaults(NSString* key, float value) {
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
CA_EXTERN void HJSetDoubleFromUserDefaults(NSString* key, double value){
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

CA_EXTERN void HJSetURLFromUserDefaults(NSString* key, NSURL* value){
    [[NSUserDefaults standardUserDefaults] setURL:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

CA_EXTERN void HJSetObjectFromUserDefaults(NSString* key, id value){
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
CA_EXTERN void HJRemoveObjFromUserDefaults(NSString* key, ...) {
    va_list args;
    if (key){
        va_start(args, key);
        NSString* otherKey;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        while ((otherKey = va_arg(args, NSString*))) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:otherKey];
        }
        //  用VA_END宏结束可变参数的获取
        va_end(args);
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
CA_EXTERN NSString* HJGetAppVersonString(void) {
    NSDictionary* info = [NSBundle mainBundle].infoDictionary;
    return info[kGuidePageAppVersionString];
}
CA_EXTERN GuidePageAPPLaunchStateOptions HJGetGuidePageAPPLaunchState() {
    GuidePageAPPLaunchStateOptions option  = GuidePageAPPLaunchStateFirst;
    // 判断是否登陆过,用当前版本号做Key来存储版本号
    BOOL userHasOnboarded = HJGetBoolFromUserDefaults(kGuidePageAppFirstInstall);
    BOOL appIsUpdate = ![HJGetStrFromUserDefaults(kGuidePageAppLastVersion) isEqualToString:HJGetAppVersonString()];
    if (userHasOnboarded) {//曾经登陆过
        if (appIsUpdate) {//保存版本信息与当前版本信息不同
            option = GuidePageAPPLaunchStateUpdate;
        }else{
            option = GuidePageAPPLaunchStateNormal;//保存版本信息与当前版本信息相同
        }
    }
    return option;
}
CA_EXTERN NSString* HJGetLaunchImageName(void){
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}
CA_EXTERN BOOL HJContainsString(NSString*str,NSString* subStr){
    if (str == nil||subStr == nil) return NO;
    return [str rangeOfString:subStr].location != NSNotFound;
}
