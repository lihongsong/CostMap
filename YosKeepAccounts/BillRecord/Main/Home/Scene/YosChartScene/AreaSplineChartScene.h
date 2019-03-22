typedef NS_ENUM(NSInteger, AreaSplineType){
    AreaSplineTypeSingle,
    AreaSplineTypeCompare,
};
#import "BaseChartScene.h"
@interface AreaSplineChartScene : BaseChartScene<YosChartSceneDidFinishLoadDelegate>
@property (nonatomic, strong) YosChartEntity *zzChartEntity;
@property (nonatomic, strong) YosChartScene  *zzChartScene;
@property (nonatomic,assign)AreaSplineType chartType;
@property(nonatomic,strong)NSArray *callArr;
@property(nonatomic,strong)NSArray *beCallArr; 
@end
