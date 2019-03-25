#import <UIKit/UIKit.h>
@interface YosKeepAccountsCircle : UIView
@property (assign,nonatomic)NSString* centerState;
@property (strong,nonatomic)UIColor* centerColor;
@property (strong,nonatomic)UIColor* cycleBegColor;
@property (strong,nonatomic)UIColor* cycleFinishColor;
@property (strong,nonatomic)UIColor* cycleUnfinishColor;
@property (assign,nonatomic)float percent;
@property (assign,nonatomic)float width;
@property(nonatomic,strong)UILabel *stateLabel;
@end
