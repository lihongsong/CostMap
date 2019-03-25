#import "YosKeepAccountsWaveAnimationScene.h"
#import "YosKeepAccountsControl.h"
@interface YosKeepAccountsWaveAnimationScene()
@property(nonatomic,strong)UIImageView *animation1Image;
@property(nonatomic,strong)UIImageView *animation2Image;
@property(nonatomic,strong)UIImageView *animation3Image;
@property(nonatomic,strong)UIImageView *animation4Image;
@property(nonatomic,strong)NSTimer *display;
@property(nonatomic,assign)CGAffineTransform lastTransform;
@property(nonatomic,assign)CGAffineTransform lastTransform2;
@property(nonatomic,assign)CGAffineTransform lastTransform3;
@property(nonatomic,assign)CGAffineTransform lastTransform4;
@end
@implementation YosKeepAccountsWaveAnimationScene
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initControls:frame];
    return self;
}
-(void)initControls:(CGRect)frame{
    [self addSubview:self.animation1Image];
    [self addSubview:self.animation2Image];
    [self addSubview:self.animation3Image];
    [self addSubview:self.animation4Image];
   UIImageView *animationBGImage = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(0, frame.size.height - 22.5, frame.size.width, 22.5) imageName:@"home_bg_wave_mask"];
    [self addSubview:animationBGImage];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    self.timer.frameInterval = 2;
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
}
-(void)updateValue:(NSTimer *)timer{
    [UIView animateWithDuration:0.16 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.lastTransform = self.animation1Image.transform;
        self.animation1Image.transform = CGAffineTransformTranslate(self.lastTransform, -2, 0);
        self.lastTransform2 = self.animation2Image.transform;
        self.animation2Image.transform = CGAffineTransformTranslate(self.lastTransform2, -2, 0);
        self.lastTransform3 = self.animation3Image.transform;
        self.animation3Image.transform = CGAffineTransformTranslate(self.lastTransform3, -3, 0);
        self.lastTransform4 = self.animation4Image.transform;
        self.animation4Image.transform = CGAffineTransformTranslate(self.lastTransform4, -3, 0);
    } completion:^(BOOL finished) {
        if (CGRectGetMaxX(self.animation1Image.frame)<0) {
            self.animation1Image.frame = CGRectMake(CGRectGetMaxX(self.animation2Image.frame), 0, 750, 41);
        }else if (CGRectGetMaxX(self.animation2Image.frame)<0){
            self.animation2Image.frame = CGRectMake(CGRectGetMaxX(self.animation1Image.frame), 0, 750, 41);
        }
        if (CGRectGetMaxX(self.animation3Image.frame)<0) {
            self.animation3Image.frame = CGRectMake(CGRectGetMaxX(self.animation4Image.frame), 0, 750, 41);
        }else if (CGRectGetMaxX(self.animation4Image.frame)<0){
            self.animation4Image.frame = CGRectMake(CGRectGetMaxX(self.animation3Image.frame), 0, 750, 41);
        }
    }];
}
-(UIImageView *)animation1Image
{
    if (_animation1Image  == nil) {
        _animation1Image = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(0, 0, 750, 41) imageName:@"home_bg_wave_01"];
    }
    return _animation1Image;
}
-(UIImageView *)animation2Image
{
    if (_animation2Image  == nil) {
        _animation2Image = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(750, 0, 750, 41) imageName:@"home_bg_wave_01"];
    }
    return _animation2Image;
}
-(UIImageView *)animation4Image
{
    if (_animation4Image  == nil) {
        _animation4Image = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(750, 0, 750, 41) imageName:@"home_bg_wave_02"];
    }
    return _animation4Image;
}
-(UIImageView *)animation3Image
{
    if (_animation3Image  == nil) {
        _animation3Image = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(0, 0, 750, 41) imageName:@"home_bg_wave_02"];
    }
    return _animation3Image;
}
@end
