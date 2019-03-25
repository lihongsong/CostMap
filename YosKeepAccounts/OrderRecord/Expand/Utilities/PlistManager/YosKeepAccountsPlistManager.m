#import "YosKeepAccountsPlistManager.h"
#import "YosKeepAccountsUtilitiesDefine.h"
#define TestApi @"TestApi"
#define ReleaseTestApi @"ReleaseTestApi"
#define ReleaseApi @"ReleaseApi"
#define ColorFont @"ColorFont"
#define Color @"Color"
#define DefaultColor @"d7000f"
#define Font @"Font"
#define FontSize @"FontSize"
#define DefaultSize 15.0
#define FontName @"FontName"
#define DefaultFontName @"HelveticaNeue-Bold"
#define ApiKey @"ApiArray"
#define RowsKey @"Rows"
#define SectionTitle @"SectionTitle"
#define rowTitle @"Title"
#define ApiList @"SelectApiConfigList"
#define List @"ApiConfigList"
#define ApiSelectType @"SelectApiConfigtype"
#define ApiUrl @"Api"
@interface YosKeepAccountsPlistManager()
@end
@implementation YosKeepAccountsPlistManager
+ (instancetype)plistInit:(InitFinish)finishBlock{
    YosKeepAccountsPlistManager *manger = [[YosKeepAccountsPlistManager alloc] init];
    manger.testPlistDic = [[NSDictionary alloc] initWithDictionary:[YosKeepAccountsPlistManager getPlistName:TestApi]];
    manger.testReleasePlistDic = [[NSDictionary alloc] initWithDictionary:[YosKeepAccountsPlistManager getPlistName:ReleaseTestApi]];
    manger.releasePlistDic = [[NSDictionary alloc] initWithDictionary:[YosKeepAccountsPlistManager getPlistName:ReleaseApi]];
    [manger getCacheApi:(YosKeepAccountsPlistManager *) manger block:finishBlock];
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
    switch (self.YKAApiType) {
        case TestYKAApiType:
            tempArr = [NSArray arrayWithArray:(self.testPlistDic[ApiKey][section])[RowsKey]];
            break;
        case TestReleaseYKAApiType:
            tempArr = [NSArray arrayWithArray:(self.testReleasePlistDic[ApiKey][section])[RowsKey]];
            break;
        case ReleaseYKAApiType:
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
    switch (self.YKAApiType) {
        case TestYKAApiType:
           return self.testPlistDic[ApiKey][section][SectionTitle];
            break;
        case TestReleaseYKAApiType:
            return self.testReleasePlistDic[ApiKey][section][SectionTitle];
            break;
        case ReleaseYKAApiType:
            return self.releasePlistDic[ApiKey][section][SectionTitle];
            break;
        default:
           return self.testPlistDic[ApiKey][section][SectionTitle];
            break;
    }
}
#pragma mark 获取section 个数
- (NSInteger)getSectionCount{
    switch (self.YKAApiType) {
        case TestYKAApiType:
            return [self.testPlistDic[ApiKey] count];
            break;
        case TestReleaseYKAApiType:
            return [self.testReleasePlistDic[ApiKey] count];
            break;
        case ReleaseYKAApiType:
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
    switch (self.YKAApiType) {
        case TestYKAApiType:
            return [self.testConfigArr[section] integerValue];
            break;
        case TestReleaseYKAApiType:
            return  [self.testReleaseConfigArr[section] integerValue];
            break;
        case ReleaseYKAApiType:
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
    switch (self.YKAApiType) {
    case TestYKAApiType:
    {
        [self.testConfigArr replaceObjectAtIndex:section withObject:@(tag%10)];
        refreshBegin();
    }
        break;
    case TestReleaseYKAApiType:
    {
        [self.testReleaseConfigArr replaceObjectAtIndex:section withObject:@(tag%10)];
        refreshBegin();
    }
        break;
    case ReleaseYKAApiType:
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
    switch (self.YKAApiType) {
        case TestYKAApiType:
        {
            NSLog(@"____%ld",(long)self.YKAApiType);
            saveDic = @{ApiSelectType:[NSString stringWithFormat:@"%ld",(long)self.YKAApiType],List:self.testConfigArr};
            NSLog(@"___1111____%@",saveDic);
            UserDefaultSetObj(saveDic, ApiList);
        }
            break;
        case TestReleaseYKAApiType:
        {
             saveDic = @{ApiSelectType:[NSString stringWithFormat:@"%ld",(long)self.YKAApiType],List:self.testReleaseConfigArr};
             NSLog(@"___2222____%@",saveDic);
            UserDefaultSetObj(saveDic, ApiList);
        }
            break;
            break;
        default:
            break;
    }
}
#pragma mark   获取缓存 api
- (void)getCacheApi:(YosKeepAccountsPlistManager *)manger block:(InitFinish)finishBlock{
    NSDictionary * configDic = UserDefaultGetObj(ApiList);
    NSLog(@"______%@",configDic);
    if (!configDic) {
        manger.testConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
        manger.testReleaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
        manger.releaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
        manger.YKAApiType = TestYKAApiType;
        finishBlock(TestYKAApiType);
    }else{
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                {
                    manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                    manger.testReleaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                    manger.releaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                     manger.YKAApiType = TestYKAApiType;
                    finishBlock(TestYKAApiType);
                };
                break;
            case 1:
            {
                manger.testConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.releaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.YKAApiType = TestReleaseYKAApiType;
                finishBlock(TestReleaseYKAApiType);
            };
                break;
            case 2:
            {
                manger.testConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.YKAApiType = ReleaseYKAApiType;
                finishBlock(ReleaseYKAApiType);
            };
                break;
            default:
            {
                manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.testReleaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [YosKeepAccountsPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.YKAApiType = TestYKAApiType;
                finishBlock(TestYKAApiType);
            };
                break;
        }
    }
}
#pragma mark   获取host
+ (NSString *)getDebugHost{  
    NSDictionary * configDic = UserDefaultGetObj(ApiList);
    if (!configDic) {
       NSDictionary *dic = [YosKeepAccountsPlistManager getPlistName:ReleaseApi];
        return (dic[ApiKey][0])[RowsKey][0][ApiUrl];
    }else{
        NSArray *configSelectArr = configDic[ApiSelectType][List];
        NSDictionary *dataDic;
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                dataDic = [YosKeepAccountsPlistManager getPlistName:TestApi];
                break;
            case 1:
                dataDic = [YosKeepAccountsPlistManager getPlistName:ReleaseTestApi];
                break;
            case 2:
                dataDic = [YosKeepAccountsPlistManager getPlistName:ReleaseApi];
                break;
            default:
                dataDic = [YosKeepAccountsPlistManager getPlistName:TestApi];
                break;
        }
        NSInteger rowItem = [configSelectArr[0] integerValue];
        if (rowItem > ([(dataDic[ApiKey][0])[RowsKey] count] - 1)) {
            NSDictionary *dic = [YosKeepAccountsPlistManager getPlistName:ReleaseApi];
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
#pragma mark  获取 颜色
+ (NSString *)getColor: (NSInteger)index{
    NSArray *colorArr = [YosKeepAccountsPlistManager getPlistName:ColorFont key:Color];
    if ([colorArr count] > index){
         return [colorArr[index] objectForKey:Color];
    }else{
        return DefaultColor;
    }
};
#pragma mark 获取 字号
+ (float )getFontSize: (NSInteger)index{
    NSArray *fontSizeArr = [YosKeepAccountsPlistManager getPlistName:ColorFont key:FontSize];
    if ([fontSizeArr count] > index){
        return [[NSString stringWithFormat:@"%@",[fontSizeArr[index] objectForKey:Font]] floatValue];
    }else{
        return DefaultSize;
    }
};
#pragma mark 获取 字体
+ (NSString *)getFontName: (NSInteger)index{
    NSArray *fontNameArr =  [YosKeepAccountsPlistManager getPlistName:ColorFont key:FontName];
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
@end
