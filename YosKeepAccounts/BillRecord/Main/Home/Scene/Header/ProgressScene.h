#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ProgressScene : UIView
@property(nonatomic)CGPoint point;
@property(nonatomic)float bj;
@property(nonatomic)float zj_kd;
@property(nonatomic)float z1;
@property(nonatomic)CGRect rect1,rect2;
@property(nonatomic)float z;
@property(nonatomic)CAGradientLayer * gradientlayer1,*gradientlayer2;
@property(nonatomic)CALayer * layer_d;
@property(nonatomic)CAShapeLayer * shapelayer;
@property(nonatomic)NSArray * array1,*array2;
@property(nonatomic)UIBezierPath * apath;
@property(nonatomic,strong)UIView *bgScene;
@property(nonatomic)CABasicAnimation *animation;
@property (nonatomic)float toValue;
@property(nonatomic,assign)CGAffineTransform lastTransform;
-(void)startAnimaition;
@end
