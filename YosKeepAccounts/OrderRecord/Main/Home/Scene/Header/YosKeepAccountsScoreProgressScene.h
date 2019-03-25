#import <UIKit/UIKit.h>
#import "YosKeepAccountsProgressScene.h"
@interface YosKeepAccountsScoreProgressScene : UIView
@property(nonatomic)float kd;
@property(nonatomic)float z;
@property(nonatomic)YosKeepAccountsProgressScene * zj;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic)float progress;
-(void)start;
@end
