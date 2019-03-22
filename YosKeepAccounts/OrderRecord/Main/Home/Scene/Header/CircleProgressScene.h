#import <UIKit/UIKit.h>
#import "HomeDataEntity.h"
@interface CircleProgressScene : UIView
@property(nonatomic,strong) HomeDataEntity *model;
@property(nonatomic,strong) NSTimer *timer;
-(void)refreshData;
@end
