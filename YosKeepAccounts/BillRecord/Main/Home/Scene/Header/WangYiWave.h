#import <UIKit/UIKit.h>
@interface WangYiWave : UIView
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat waveHeight;
- (void)wave;
- (void)stop;
@end
