#import "BaseChartScene.h"
@interface GradientCompareBarScene : BaseChartScene<YosChartSceneDidFinishLoadDelegate>
@property (nonatomic, strong) YosChartEntity *barChartEntity;
@property (nonatomic, strong) YosChartScene  *barChartScene;
@property (nonatomic,strong) NSArray *lendArr;
@property (nonatomic,strong) NSArray *repayArr; 
-(void)refreshData;
@end
