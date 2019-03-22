#import <UIKit/UIKit.h>
#import "waveAnimationScene.h"
#import "WangYiWave.h"
@protocol HomeScoreHeaderSceneDelegate<NSObject>
-(void)continueCheckMyReport;
@end
@interface HomeScoreHeaderScene : UIView
@property(nonatomic,assign)BOOL isCheckMyReport;
@property(nonatomic,weak)id<HomeScoreHeaderSceneDelegate> delegate;
@property(nonatomic,strong)WangYiWave *waveScene;
@property (nonatomic)float progress;
@property (nonatomic,assign)NSString *status;
@property (nonatomic,assign)NSString *time;
-(void)startAnimation;
@end
