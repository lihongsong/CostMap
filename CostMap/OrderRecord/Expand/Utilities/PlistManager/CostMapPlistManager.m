#import "CostMapPlistManager.h"
#import "CostMapUtilitiesDefine.h"
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
@interface CostMapPlistManager()
@end
@implementation CostMapPlistManager
+ (instancetype)plistInit:(InitFinish)finishBlock{
    CostMapPlistManager *manger = [[CostMapPlistManager alloc] init];
    manger.testPlistDic = [[NSDictionary alloc] initWithDictionary:[CostMapPlistManager getPlistName:TestApi]];
    manger.testReleasePlistDic = [[NSDictionary alloc] initWithDictionary:[CostMapPlistManager getPlistName:ReleaseTestApi]];
    manger.releasePlistDic = [[NSDictionary alloc] initWithDictionary:[CostMapPlistManager getPlistName:ReleaseApi]];
    [manger getCacheApi:(CostMapPlistManager *) manger block:finishBlock];
   return manger;
}
- (instancetype)init{
    self = [super init];
    if(!self){
        return nil;
    }
    return self;
}
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
- (NSString *)getCellTitle:(NSIndexPath *)indexPath{
    return [self getRowsAtSection:indexPath.section][indexPath.item][rowTitle];
}
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
- (void)getCacheApi:(CostMapPlistManager *)manger block:(InitFinish)finishBlock{
    NSDictionary * configDic = UserDefaultGetObj(ApiList);
    NSLog(@"______%@",configDic);
    if (!configDic) {
        manger.testConfigArr = [CostMapPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
        manger.testReleaseConfigArr = [CostMapPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
        manger.releaseConfigArr = [CostMapPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
        manger.YKAApiType = TestYKAApiType;
        finishBlock(TestYKAApiType);
    }else{
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                {
                    manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                    manger.testReleaseConfigArr = [CostMapPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                    manger.releaseConfigArr = [CostMapPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                     manger.YKAApiType = TestYKAApiType;
                    finishBlock(TestYKAApiType);
                };
                break;
            case 1:
            {
                manger.testConfigArr = [CostMapPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.releaseConfigArr = [CostMapPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.YKAApiType = TestReleaseYKAApiType;
                finishBlock(TestReleaseYKAApiType);
            };
                break;
            case 2:
            {
                manger.testConfigArr = [CostMapPlistManager getArrCounts:[manger.testPlistDic[ApiKey] count]];
                manger.testReleaseConfigArr = [CostMapPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.YKAApiType = ReleaseYKAApiType;
                finishBlock(ReleaseYKAApiType);
            };
                break;
            default:
            {
                manger.testConfigArr = [NSMutableArray arrayWithArray:configDic[List]];
                manger.testReleaseConfigArr = [CostMapPlistManager getArrCounts:[manger.testReleasePlistDic[ApiKey] count]];
                manger.releaseConfigArr = [CostMapPlistManager getArrCounts:[manger.releasePlistDic[ApiKey] count]];
                manger.YKAApiType = TestYKAApiType;
                finishBlock(TestYKAApiType);
            };
                break;
        }
    }
}
+ (NSString *)getDebugHost{  
    NSDictionary * configDic = UserDefaultGetObj(ApiList);
    if (!configDic) {
       NSDictionary *dic = [CostMapPlistManager getPlistName:ReleaseApi];
        return (dic[ApiKey][0])[RowsKey][0][ApiUrl];
    }else{
        NSArray *configSelectArr = configDic[ApiSelectType][List];
        NSDictionary *dataDic;
        switch ([configDic[ApiSelectType] integerValue]) {
            case 0:
                dataDic = [CostMapPlistManager getPlistName:TestApi];
                break;
            case 1:
                dataDic = [CostMapPlistManager getPlistName:ReleaseTestApi];
                break;
            case 2:
                dataDic = [CostMapPlistManager getPlistName:ReleaseApi];
                break;
            default:
                dataDic = [CostMapPlistManager getPlistName:TestApi];
                break;
        }
        NSInteger rowItem = [configSelectArr[0] integerValue];
        if (rowItem > ([(dataDic[ApiKey][0])[RowsKey] count] - 1)) {
            NSDictionary *dic = [CostMapPlistManager getPlistName:ReleaseApi];
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

+ (NSString *)getColor: (NSInteger)index{
    NSArray *colorArr = [CostMapPlistManager getPlistName:ColorFont key:Color];
    if ([colorArr count] > index){
         return [colorArr[index] objectForKey:Color];
    }else{
        return DefaultColor;
    }
};
+ (float )getFontSize: (NSInteger)index{
    NSArray *fontSizeArr = [CostMapPlistManager getPlistName:ColorFont key:FontSize];
    if ([fontSizeArr count] > index){
        return [[NSString stringWithFormat:@"%@",[fontSizeArr[index] objectForKey:Font]] floatValue];
    }else{
        return DefaultSize;
    }
};
+ (NSString *)getFontName: (NSInteger)index{
    NSArray *fontNameArr =  [CostMapPlistManager getPlistName:ColorFont key:FontName];
    if ([fontNameArr count] > index) {
        return [fontNameArr[index] objectForKey:FontName];
    }else{
        return DefaultFontName;
    }
}
+ (NSArray *)getPlistName:(NSString *)name key:(NSString*)key{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSArray *plistArr = [[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:key];
    return plistArr;
}
+ (NSDictionary *)getPlistName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return plistDic;
}
@end
