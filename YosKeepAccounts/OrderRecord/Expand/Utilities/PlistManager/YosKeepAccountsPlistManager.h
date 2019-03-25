#import <Foundation/Foundation.h>
typedef void(^RefreshBegin)(void);
typedef enum :NSInteger {
    TestYKAApiType,
    TestReleaseYKAApiType,
    ReleaseYKAApiType,
} YKAApiType;
typedef void(^InitFinish)(YKAApiType);
@interface YosKeepAccountsPlistManager : NSObject
@property(nonatomic,strong)NSDictionary *testPlistDic;
@property(nonatomic,strong)NSDictionary *testReleasePlistDic;
@property(nonatomic,strong)NSDictionary *releasePlistDic;
@property(nonatomic,strong)NSMutableArray *testConfigArr;
@property(nonatomic,strong)NSMutableArray *testReleaseConfigArr;
@property(nonatomic,strong)NSMutableArray *releaseConfigArr;
@property(nonatomic,assign)YKAApiType YKAApiType;
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
#pragma mark  获取 颜色
+ (NSString *)getColor: (NSInteger)index;
#pragma mark 获取 字号
+ (float )getFontSize: (NSInteger)index;
#pragma mark 获取 字体
+ (NSString *)getFontName: (NSInteger)index;
#pragma mark 获取
@end
