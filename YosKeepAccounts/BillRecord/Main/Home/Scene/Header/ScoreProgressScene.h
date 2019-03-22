#import <UIKit/UIKit.h>
#import "ProgressScene.h"
@interface ScoreProgressScene : UIView
@property(nonatomic)float kd;
@property(nonatomic)float z;
@property(nonatomic)ProgressScene * zj;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic)float progress;
-(void)start;
@end
