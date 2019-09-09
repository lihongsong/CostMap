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
- (NSArray *)getRowsAtSection:(NSInteger)section;
- (NSString *)getSectionTitle:(NSInteger)section;
- (NSInteger)getSectionCount;
- (NSString *)getCellTitle:(NSIndexPath *)indexPath;
- (NSInteger)getCurrentTag:(NSInteger)section;
- (void)refreshSelectData:(NSInteger)tag block:(RefreshBegin)refreshBegin;
- (void)saveApiConfig;
#pragma plist
+ (instancetype)plistInit:(InitFinish)finishBlock;
+ (NSString *)getDebugHost;
+ (NSString *)getColor: (NSInteger)index;
+ (float )getFontSize: (NSInteger)index;
+ (NSString *)getFontName: (NSInteger)index;
@end
