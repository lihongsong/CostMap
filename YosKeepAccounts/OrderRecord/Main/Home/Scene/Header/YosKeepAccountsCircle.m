#import "YosKeepAccountsCircle.h"
#import "YosKeepAccountsControl.h"
@implementation YosKeepAccountsCircle
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _width = 0;
        [self addSubview:self.stateLabel];
    }
    return self;
}
-(void)setPercent:(float)percent{
    _percent = percent;
    [self setNeedsDisplay]; 
}
-(void)drawRect:(CGRect)rect
{
    [self addCycleBegColor];
    [self drawArc];
    [self addCenterBack];
    if (_centerState.length > 0) {
        [self addCenterLabel];
    }
}
-(void)addCycleBegColor{
    CGColorRef color = (_cycleBegColor == nil) ? [UIColor lightGrayColor].CGColor : _cycleBegColor.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext(); 
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    CGFloat radius = viewSize.width/2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y); 
    CGContextAddArc(contextRef, center.x, center.y, radius, 0, 2*M_PI, 0); 
    CGContextSetFillColorWithColor(contextRef, color); 
    CGContextFillPath(contextRef); 
}
-(void)drawArc{
    if (_percent == 0 || _percent > 1) {
        return;
    }
    if (_percent == 1) {
        CGColorRef color = (_cycleFinishColor == nil) ? [UIColor greenColor].CGColor : _cycleFinishColor.CGColor;
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
        CGFloat radius = viewSize.width/2;
        CGContextBeginPath(contextRef);
        CGContextMoveToPoint(contextRef, center.x, center.y);
        CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
        CGContextSetFillColorWithColor(contextRef, color);
        CGContextFillPath(contextRef);
    }
    else{
        float endAngle = 2*M_PI*_percent + M_PI * 3 / 2.0;
        CGColorRef color = (_cycleUnfinishColor == nil) ? [UIColor blueColor].CGColor : _cycleUnfinishColor.CGColor;
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        CGFloat radius = viewSize.width / 2;
        CGContextBeginPath(contextRef);
        CGContextMoveToPoint(contextRef, center.x, center.y);
        CGContextAddArc(contextRef, center.x, center.y, radius,M_PI * 3 / 2.0,endAngle, 0);
        CGContextSetFillColorWithColor(contextRef, color);
        CGContextFillPath(contextRef);
    }
}
-(void)addCenterBack{
    float width = (_width == 0) ? 2.5 : _width;
    CGColorRef color = (_centerColor == nil) ? [UIColor whiteColor].CGColor : _centerColor.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2 - width;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}
-(UILabel *)stateLabel
{
    if (_stateLabel  == nil) {
        _stateLabel = [YosKeepAccountsControl yka_createLabelWithFrame:CGRectMake(0, self.bounds.size.height/2.0-20, self.bounds.size.width, 40) Font:[UIFont BigTitleFont] Text:self.centerState];
        if (UIDevice.hj_isIPhone5SizedDevice) {
            _stateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        }
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}
-(void)addCenterLabel{
    self.stateLabel.text = self.centerState;
}
@end
