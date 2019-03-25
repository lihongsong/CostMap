#define YosKeepAccountsCircleSpace 27
#import "YosKeepAccountsCircleProgressScene.h"
#import "YosKeepAccountsCircle.h"
#import "YosKeepAccountsControl.h"
@interface YosKeepAccountsCircleProgressScene()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)YosKeepAccountsCircle *circleScene;
@property(nonatomic,assign)float time;
@end
@implementation YosKeepAccountsCircleProgressScene
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    float circleWidth = (self.hj_width - YosKeepAccountsCircleSpace * 5)/4.0;
    NSArray *arr = @[@"2015年",@"2016年",@"2017年",@"2018年"];
    NSArray *colorArr = @[[UIColor colorFromHexCode:@"#FC8E22"],[UIColor colorFromHexCode:@"#3389FF"],[UIColor colorFromHexCode:@"#FD6F93"],[UIColor colorFromHexCode:@"#B269FF"]];
    NSArray *stateArr = @[@"12次",@"8次",@"10次",@"2次"];
    NSArray *percentArr = @[@"0.75",@"0.5",@"0.625",@"0.125"];
    self.time = 0.0;
    for (int i = 0; i < 4; i++) {
        YosKeepAccountsCircle *circleScene = [[YosKeepAccountsCircle alloc]initWithFrame:CGRectMake(YosKeepAccountsCircleSpace + i * (YosKeepAccountsCircleSpace + circleWidth), 10, circleWidth, circleWidth)];
        circleScene.percent = [percentArr[i] floatValue];
        circleScene.tag = 100 + i;
        circleScene.width = 5;
        circleScene.cycleBegColor = [UIColor sepreateColor];
        circleScene.cycleUnfinishColor = colorArr[i];
        circleScene.centerState = stateArr[i];
        circleScene.stateLabel.textColor = colorArr[i];
        [self addSubview:circleScene];
        UILabel *titleLabel = [YosKeepAccountsControl yka_createLabelWithFrame:CGRectMake(YosKeepAccountsCircleSpace/2.0 + i * (YosKeepAccountsCircleSpace + circleWidth), CGRectGetMaxY(circleScene.frame) + 5, circleWidth + YosKeepAccountsCircleSpace , 40) Font:[UIFont stateFont] Text:arr[i]];
        titleLabel.textColor = [UIColor colorFromHexCode:@"333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    return self;
}
-(void)setEntity:(HomeDataEntity *)model{
        for (int i = 0; i < 4; i++) {
            YosKeepAccountsCircle *v = (YosKeepAccountsCircle*)[self viewWithTag:100 + i];
            NSLog(@"____%@",model.credictApplyRecode[i]);
            v.stateLabel.text = [NSString stringWithFormat:@"%@次", model.credictApplyRecode[i]];
        }
}
-(void)refreshData{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateValue) userInfo:nil repeats:false];
}
-(void)updateValue{
    self.time += 0.1;
    if (self.time >= 0.7) {
        self.timer = nil;
    }else{
        NSLog(@"%f",self.time);
        for (int i = 0; i < 4; i++) {
            YosKeepAccountsCircle *v = (YosKeepAccountsCircle*)[self viewWithTag:100 + i];
            v.percent = self.time;
        }
    }
}
@end
