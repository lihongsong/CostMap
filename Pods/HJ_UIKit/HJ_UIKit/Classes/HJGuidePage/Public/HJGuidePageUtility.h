//
//  HJGuidePageUtility.h
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/18.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define HJGuidePageDlog(...) printf("<%s : %d>%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define HJGuidePageDlog(...)
#endif
CA_EXTERN NSString * const kGuidePageAppFirstInstall;                //app首次启动保存至UserDefaults Key
CA_EXTERN NSString * const kGuidePageAppLastVersion;                 //app每次更新保存版本号至UserDefaults Key
CA_EXTERN NSString * const kGuidePageAppVersionString;               //app获取当前版本 Key--CFBundleShortVersionString
CA_EXTERN NSString * const kHJGuidePageWindowDidDismiss;             //app启动页消失   全局--通知 名称
CA_EXTERN NSString * const kGuidePageWKScriptMessageHandler;         //HJGuidePageWKScriptMessageHandler wk交互详细对象----->message.name

typedef NS_OPTIONS(NSUInteger, GuidePageAPPLaunchStateOptions){
    GuidePageAPPLaunchStateNormal    = 1 << 0, //正常启动
    GuidePageAPPLaunchStateFirst     = 1 << 1, //第一次启动   default
    GuidePageAPPLaunchStateUpdate    = 1 << 2 //APP更新后启动
};//default GuidePageAPPLaunchStateFirst 才弹出启动页
#pragma mark -- UserDefaults
//从UserDefault 读取 NSString
CA_EXTERN NSString* HJGetStrFromUserDefaults(NSString* key);

//从UserDefault 读取 BOOL
CA_EXTERN BOOL HJGetBoolFromUserDefaults(NSString* key);

//从UserDefault 读取 NSInteger
CA_EXTERN NSInteger HJGetIntFromUserDefaults(NSString* key);

//从UserDefault 读取 float
CA_EXTERN float HJGetFloatFromUserDefaults(NSString* key);

//从UserDefault 读取 NSURL
CA_EXTERN NSURL* HJGetURLFromUserDefaults(NSString* key);

//从UserDefault 读取 NSArray
CA_EXTERN NSArray* HJGetArryFromUserDefaults(NSString* key);

//从UserDefault 读取 NSDictionary
CA_EXTERN NSDictionary* HJGetDictionaryFromUserDefaults(NSString* key);

//从UserDefault 读取 NSArray<NSString *> *
CA_EXTERN NSArray<NSString *> * HJGetStringArrayFromUserDefaults(NSString* key);

//从UserDefault 读取 NSData
CA_EXTERN NSData * HJGetDataFromUserDefaults(NSString* key);


//设置UserDefault set NSString
CA_EXTERN void HJSetStrFromUserDefaults(NSString* key, NSString* value);

//设置UserDefault set BOOL
CA_EXTERN void HJSetBoolFromUserDefaults(NSString* key, BOOL value);

//设置UserDefault set NSInteger
CA_EXTERN void HJSetIntFromUserDefaults(NSString* key, NSInteger value);

//设置UserDefault set float
CA_EXTERN void HJSetFloatFromUserDefaults(NSString* key, float value);

//设置UserDefault set double
CA_EXTERN void HJSetDoubleFromUserDefaults(NSString* key, double value);

//设置UserDefault set NSURL
CA_EXTERN void HJSetURLFromUserDefaults(NSString* key, NSURL* value);

//设置UserDefault set Object
CA_EXTERN void HJSetObjectFromUserDefaults(NSString* key, id value);

//通过Key 删除 UserDefaults值
CA_EXTERN void HJRemoveObjFromUserDefaults(NSString* key, ...);

#pragma mark -- app信息
//获取 app当前版本号
CA_EXTERN NSString* HJGetAppVersonString(void);

//获取 app 使用状态：首次启动，日常启动，更新后首次启动
CA_EXTERN GuidePageAPPLaunchStateOptions HJGetGuidePageAPPLaunchState(void);

//获取 app LaunchImage --->仅支持竖屏
CA_EXTERN NSString* HJGetLaunchImageName(void);

CA_EXTERN BOOL HJContainsString(NSString*str,NSString* subStr);

