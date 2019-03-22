#import "ScoreProgressScene.h"
#import "UICountingLabel.h"
#import "ZYZControl.h"
@interface ScoreProgressScene()
@property (nonatomic,strong) UICountingLabel *pointLab;
@end
@implementation ScoreProgressScene
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setchushihua];
    self.backgroundColor = [UIColor clearColor];
    return  self;
}
-(void)setchushihua{
    _kd = 3;
    self.progress = 0.5;
    _zj = [[ProgressScene alloc]initWithFrame:CGRectMake(0, 0, self.hj_width, 155)];
    _zj.backgroundColor = [UIColor clearColor];
    _zj.toValue = self.progress;
    _zj.bj = 120;
    [self insertSubview:_zj atIndex:1];
    self.pointLab.frame = CGRectMake(0, 65, self.hj_width, 60);
    [self addSubview:self.pointLab];
    self.statusLabel = [ZYZControl createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.pointLab.frame) + 5, self.hj_width, 40) Font:[UIFont NormalTitleFont] Text:@"评分一般"];
    self.statusLabel.textColor = [UIColor whiteColor];
   self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.statusLabel];
    self.timeLabel = [ZYZControl createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusLabel.frame), self.hj_width, 40) Font:[UIFont normalFont] Text:@"评估时间:2018-05-01"];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
}
-(UICountingLabel *)pointLab
{
    if (!_pointLab) {
        _pointLab = [[UICountingLabel alloc]init];
        _pointLab.textAlignment = NSTextAlignmentCenter;
        _pointLab.font = [UIFont PercentTitleFont];
        _pointLab.textColor = [UIColor whiteColor];
    }
    return _pointLab;
}
-(void)drawRect:(CGRect)rect{
    [self draw_scdcdt:rect];
}
-(void)draw_scdcdt:(CGRect)rect{
    _zj.frame = rect;
    _zj.z = _z;
    _zj.zj_kd = _kd;
}
-(void)setKd:(float)kd{
    _kd = kd> 10?10:kd;
    [self setNeedsDisplay];
}
-(void)setZ:(float)z{
    _z = z;
    [self setNeedsDisplay];
}
-(void)setProgress:(float)progress
{
    _progress = progress;
    _zj.toValue = progress;
}
-(void)start
{
    self.pointLab.method = UILabelCountingMethodLinear;
    self.pointLab.format = @"%d%";
    [self.pointLab countFrom:1 to:self.progress * 100 withDuration:1.5];
    [_zj startAnimaition];
}
@end
