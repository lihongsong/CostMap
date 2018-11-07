//
//  ColorFontManager.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.

/*
 该类 适用于plist文件用
*/
#import <Foundation/Foundation.h>

typedef void(^RefreshBegin)(void);


typedef enum :NSInteger {
    TestApiType,
    TestReleaseApiType,
    ReleaseApiType,
}ApiType;

typedef void(^InitFinish)(ApiType);

@interface PlistManager : NSObject
// ***********  Debug 模式下  *****************
//测试服数据
@property(nonatomic,strong)NSDictionary *testPlistDic;
//预正式服数据
@property(nonatomic,strong)NSDictionary *testReleasePlistDic;
//正式服数据
@property(nonatomic,strong)NSDictionary *releasePlistDic;

@property(nonatomic,strong)NSMutableArray *testConfigArr;
@property(nonatomic,strong)NSMutableArray *testReleaseConfigArr;
@property(nonatomic,strong)NSMutableArray *releaseConfigArr;
// 目前选取api类型
@property(nonatomic,assign)ApiType apiType;
#pragma mark  获取rows数组
- (NSArray *)getRowsAtSection:(NSInteger)section;

#pragma mark 获取section title
- (NSString *)getSectionTitle:(NSInteger)section;

#pragma mark 获取section 个数
- (NSInteger)getSectionCount;

#pragma mark 获取Cell button 标题
- (NSString *)getCellTitle:(NSIndexPath *)indexPath;

#pragma mark 获取section中当前选中api标签
- (NSInteger)getCurrentTag:(NSInteger)section;

#pragma mark 根据操作刷新数据源
- (void)refreshSelectData:(NSInteger)tag block:(RefreshBegin)refreshBegin;

#pragma mark  保存api 配置
- (void)saveApiConfig;

#pragma plist 管理器初始化
+ (instancetype)plistInit:(InitFinish)finishBlock;

#pragma mark   获取host
+ (NSString *)getDebugHost;

// ************  以上Debug模式调用  ***********************

// ************ Release 和Debug 模式下都调用 ************************

#pragma mark  获取 颜色
+ (NSString *)getColor: (NSInteger)index;

#pragma mark 获取 字号
+ (float )getFontSize: (NSInteger)index;

#pragma mark 获取 字体
+ (NSString *)getFontName: (NSInteger)index;

// ************以上 Release 和Debug 模式下都调用 ************************

// ************ Release 模式下调用 ************************

#pragma mark 获取
//+ (NSString *)getReleaseHost;
// ************ Release 模式下调用 ************************
@end
