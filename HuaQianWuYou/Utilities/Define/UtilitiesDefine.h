//
//  UtilitiesDefine.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#ifndef UtilitiesDefine_h
#define UtilitiesDefine_h

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define WeakObj(o) __weak typeof(o) o##Weak = o;
#define StrongObj(o) __strong typeof(o) o = o##Weak;

#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height

#define TabBarHeight (SHeight == 812.0 ? 34 + 49 : 49)
#define NavigationHeight (SHeight == 812.0 ? 88 : 64)
#define StatusBarHeight (SHeight == 812.0 ? 20 : 0)
#define CellDefaultHeight 40
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define HEITI(font) [UIFont fontWithName:@"Heiti SC" size:font]
#define LeftSpace 15 //留白间距
// UserDefault快捷
#define SetUserDefault(x,y) [[NSUserDefaults standardUserDefaults] setObject:x forKey:y];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define GetUserDefault(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]
#define RemoveUserDefault(x) [[NSUserDefaults standardUserDefaults] removeObjectForKey:x];\
[[NSUserDefaults standardUserDefaults] synchronize];

/****** 对象是否为空判断 ******/
#define ObjIsNilOrNull(_obj)    (((_obj) == nil) || (_obj == (id)kCFNull))
#define StrIsEmpty(_str)        (ObjIsNilOrNull(_str) || (![(_str) isKindOfClass:[NSString class]]) || ([(_str) isEqualToString:@""]))
#define ArrIsEmpty(_arr)        (ObjIsNilOrNull(_arr) || (![(_arr) isKindOfClass:[NSArray class]]) || ([(_arr) count] == 0))
#define DicIsEmpty(_dic)        (ObjIsNilOrNull(_dic) || (![(_dic) isKindOfClass:[NSDictionary class]]) || ([(_dic.allKeys) count] == 0))
/****** 对象是否为空判断 ******/

/****** 安全文字 ******/
#define SafeStr(_str) StrIsEmpty(_str) ? @"" : _str
/****** 安全文字 ******/

//KeyWindow
#define KeyWindow [[UIApplication sharedApplication] delegate].window

/****** UserDefault快捷 ******/
#define UserDefaultSetObj(obj,key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefaultGetObj(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
/****** UserDefault快捷 ******/

#define LNAOPSAFESTRING(str) ((((str) != nil) && ![(str) isKindOfClass:[NSNull class]]) ? [NSString stringWithFormat:@"%@", (str)] : @"")

#endif /* UtilitiesDefine_h */
