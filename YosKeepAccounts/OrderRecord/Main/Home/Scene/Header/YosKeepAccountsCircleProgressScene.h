#import <UIKit/UIKit.h>
#import "HomeDataEntity.h"
@interface YosKeepAccountsCircleProgressScene : UIView
@property(nonatomic,strong) HomeDataEntity *model;
@property(nonatomic,strong) NSTimer *timer;
-(void)refreshData;
@end
