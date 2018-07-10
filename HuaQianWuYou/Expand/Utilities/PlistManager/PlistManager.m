//
//  ColorFontManager.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "PlistManager.h"
#import "HQWYUtilitiesDefine.h"

// plistName
// 测试服
#define TestApi @"TestApi"
//预正式服
#define ReleaseTestApi @"ReleaseTestApi"
//正式服
#define ReleaseApi @"ReleaseApi"
//颜色字体 plist
#define ColorFont @"ColorFont"

//plist  颜色 key
#define Color @"Color"
#define DefaultColor @"d7000f"//默认
//plist  字号 key
#define Font @"Font"
#define FontSize @"FontSize"
#define DefaultSize 15.0//默认
//plist  字体 key
#define FontName @"FontName"
#define DefaultFontName @"HelveticaNeue-Bold"//默认

// 测试 api 数组集合key
#define ApiKey @"ApiArray"

// 测试 api 单条功能多种状态api集合key；exp 风控，t0,t1
#define RowsKey @"Rows"

//section 头title
#define SectionTitle @"SectionTitle"

// item title
#define rowTitle @"Title"

#define ApiList @"SelectApiConfigList"
#define List @"ApiConfigList"
#define ApiSelectType @"SelectApiConfigtype"
#define ApiUrl @"Api"
@interface PlistManager()

@end

@implementation PlistManager
// ***********  Debug 模式下  Debug区 *****************
+ (instancetype)plistInit:(InitFinish)finishBlock{
    PlistManager *manger = [[PlistManager alloc] init];
    manger.testPlistDic = [[NSDictionary alloc] initWithDictionary:[PlistManager getPlistName:TestApi]];
    manger.testReleasePlistDic = [[NSDictionary alloc] initWithDictionary:[PlistManager getPlistName:ReleaseTestApi]];
    manger.releasePlistDic = [[NSDictionary alloc] initWithDictionary:[PlistManager getPlistName:ReleaseApi]];
    //获取缓存api
    [manger getCacheApi:(PlistManager *) manger block:finishBlock];
   return manger;
}

- (instancetype)init{
    self = [super init];
    if(!self){
        return nil;
    }
    return self;
}

#pragma mark  获取rows数组
- (NSArray *)getRowsAtSection:(NSInteger)section{
    NSArray *tempArr;
    switch (self.apiType) {
        case TestApiType:
            tempArr = [NSArray arrayWithArray:(self.testPlistDic[ApiKey][section])[RowsKey]];
            break;
        case TestReleaseApiType:
            tempArr = [NSArray arrayWithArray:(self.testReleasePlistDic[ApiKey][section])[RowsKey]];
            break;
        case ReleaseApiType:
            tempArr = [NSArray arrayWithArray:(self.releasePlistDic[ApiKey][section])[RowsKey]];
            break;
        default:
            [NSArray arrayWithArray:(self.testPlistDic[ApiKey][section])[RowsKey]];
            break;
    }
    return tempArr;
}

#pragma mark 获取section title
- (NSString *)getSectionTitle:(NSInteger)section{
    // self.testPlistDic[ApiKey][section][SectionTitle];
    switch (self.apiType) {
        case TestApiType:
           return self.testPlistDic[ApiKey][section][SectionTitle];
            break;
        case TestReleaseApiType:
            return self.testReleasePlistDic[ApiKey][section][SectionTitle];
            break;
        case ReleaseApiType:
            return self.releasePlistDic[ApiKey][section][SectionTitle];
            break;
        default:
           return self.testPlistDic[ApiKey][section][SectionTitle];
            break;
    }
}

#pragma mark 获取section 个数
- (NSInteger)getSectionCount{
    switch (self.apiType) {
        case TestApiType:
            return [self.testPlistDic[ApiKey] count];
            break;
        case TestReleaseApiType:
            return [self.testReleasePlistDic[ApiKey] count];
            break;
        case ReleaseApiType:
           return [self.releasePlistDic[ApiKey] count];
            break;
        default:
           return [self.testPlistDic[ApiKey] count];
            break;
    }
}

#pragma mark 获取Cell button 标题
- (NSString *)getCellTitle:(NSIndexPath *)indexPath{
    return [self getRowsAtSection:indexPath.section][indexPath.item][rowTitle];
}

#pragma mark 获取section中当前选中api标签
- (NSInteger)getCurrentTag:(NSInteger)section{
    switch (self.apiType) {
        case TestApiType:
            return [self.testConfigArr[section] integerValue];
            break;
        case TestReleaseApiType:
            return  [self.testReleaseConfigArr[section] integerValue];
            break;
        case ReleaseApiType:
            return  [self.releaseConfigArr[section] integerValue];
            break;
        default:
            return  [self.testConfigArr[section] integerValue];
            break;
    }
}

#pragma mark 根据操作刷新数据源
- (void)refreshSelectData:(NSInteger)tag block:(RefreshBegin)refreshBegin{
    NSInteger section = tag/10 - 1;
    switch (self.apiType) {
    case TestApiType:
    {
        [self.testConfigArr replaceObjectAtIndex:section withObject:@(tag%10)];
        refreshBegin();
    }
        break;
    case TestReleaseApiType:
    {
        [self.testReleaseConfigArr replaceObjectAtIndex:section withObject:@(tag%10)];
        refreshBegin();
    }
        break;
    case ReleaseApiType:
    {
        [self.releaseConfigArr replaceObjectAtIndex:section withObject:@(tag%10)];
        refreshBegin();
    }
        break;
    default:
        break;
    }
}

#pragma mark  保存api 配置
- (void)saveApiConfig{
    NSDictionary *saveDic;
    switch (self.apiType) {
        case TestApiType:
        {
            NSLog(@"____%ld",(long)self.apiType);
            saveDic = @{ApiSelectType:[NSString stringWithFormat:@"%ld",(long)self.apiType],List:self.testConfigArr};
            NSLog(@"___1111____%@",saveDic);
            SetUserDefault(saveDic, ApiList);
        }
            break;
        case TestReleaseApiType:
        {
             saveDic = @{ApiSelectType:[NSString stringWithFormat:@"%ld",(long)self.apiType],List:self.testReleaseConfigArr};
             NSLog(@"___2222____%@",saveDic);
            SetUserDefault(saveDic, ApiList);
        }
            break;
        case ReleaseApiType:
        {
            saveDic = @{ApiSelectType:[NSString stringWithFormat:@"%ld",(long)self.apiType],List:self.releaseConfigArr};
        }
            break;
        default:
            break;
    }
}

#pragma mark   获取缓存 api
- (void)getCacheApi:(PlistManager *)manger block:(InitFinish)finishBlock{
    NSDictionary * configDic = GetUserDefault(ApiList);
    NSLog(@"______%@",configDic);
    if (!configDic) {
        manger.testConfigArr = [PlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
        manger.testReleaseConfigArr = [PlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
        manger.releaseConfigArr = [PlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
        manger.apiType = TestApiType;
        finishBlock(TestApiType);
    }else{
        
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                {
                    manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                    manger.testReleaseConfigArr = [PlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                    manger.releaseConfigArr = [PlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                     manger.apiType = TestApiType;
                    finishBlock(TestApiType);
                };
                break;
            case 1:
            {
                manger.testConfigArr = [PlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.releaseConfigArr = [PlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.apiType = TestReleaseApiType;
                finishBlock(TestReleaseApiType);
            };
                break;
            case 2:
            {
                manger.testConfigArr = [PlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [PlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.apiType = ReleaseApiType;
                finishBlock(ReleaseApiType);
            };
                break;
            default:
            {
                manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.testReleaseConfigArr = [PlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [PlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.apiType = TestApiType;
                finishBlock(TestApiType);
            };
                break;
        }
    }
    
}

#pragma mark   获取host
+ (NSString *)getDebugHost{  
    NSDictionary * configDic = GetUserDefault(ApiList);
    if (!configDic) {
       NSDictionary *dic = [PlistManager getPlistName:ReleaseApi];
        return (dic[ApiKey][0])[RowsKey][0][ApiUrl];
    }else{
        NSArray *configSelectArr = configDic[ApiSelectType][List];
        NSDictionary *dataDic;
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                dataDic = [PlistManager getPlistName:TestApi];
                break;
            case 1:
                dataDic = [PlistManager getPlistName:ReleaseTestApi];
                break;
            case 2:
                dataDic = [PlistManager getPlistName:ReleaseApi];
                break;
            default:
                dataDic = [PlistManager getPlistName:TestApi];
                break;
        }
        NSInteger rowItem = [configSelectArr[0] integerValue];
        //  下标比较
        if (rowItem > ([(dataDic[ApiKey][0])[RowsKey] count] - 1)) {
            NSDictionary *dic = [PlistManager getPlistName:ReleaseApi];
            return (dic[ApiKey][0])[RowsKey][0][ApiUrl];
        }else{
            return (dataDic[ApiKey][0])[RowsKey][rowItem][ApiUrl];
        }
    }
}

+ (NSMutableArray *)getArrCounts:(NSInteger)count{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        [arr addObject:@(0)];
    }
    return arr;
}

// ************  以上Debug模式调用 以上Debug区 ***********************

// ************ Release 和Debug 模式下都调用 ************************
#pragma mark  获取 颜色
+ (NSString *)getColor: (NSInteger)index{
    NSArray *colorArr = [PlistManager getPlistName:ColorFont key:Color];
    if ([colorArr count] > index){
         return [colorArr[index] objectForKey:Color];
    }else{
        return DefaultColor;
    }
};

#pragma mark 获取 字号
+ (float )getFontSize: (NSInteger)index{
    NSArray *fontSizeArr = [PlistManager getPlistName:ColorFont key:FontSize];
    if ([fontSizeArr count] > index){
        return [[NSString stringWithFormat:@"%@",[fontSizeArr[index] objectForKey:Font]] floatValue];
    }else{
        return DefaultSize;
    }
};

#pragma mark 获取 字体
+ (NSString *)getFontName: (NSInteger)index{
    NSArray *fontNameArr =  [PlistManager getPlistName:ColorFont key:FontName];
    if ([fontNameArr count] > index) {
        return [fontNameArr[index] objectForKey:FontName];
    }else{
        return DefaultFontName;
    }
}

#pragma mark  获取plist 数组内容
+ (NSArray *)getPlistName:(NSString *)name key:(NSString*)key{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSArray *plistArr = [[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:key];
    return plistArr;
    
}

#pragma mark  获取plist 字典内容
+ (NSDictionary *)getPlistName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return plistDic;
}

// ************以上 Release 和Debug 模式下都调用 ************************
@end
