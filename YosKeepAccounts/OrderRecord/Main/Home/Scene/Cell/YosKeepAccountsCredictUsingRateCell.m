#define LeftSpace 15
#import "YosKeepAccountsCredictUsingRateCell.h"
#import "YosKeepAccountsAreaSplineChartScene.h"
#import "YosKeepAccountsControl.h"
@interface YosKeepAccountsCredictUsingRateCell()
@property(nonatomic,strong)UIView *bgScene;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)YosKeepAccountsAreaSplineChartScene *areaScene;
@end
@implementation YosKeepAccountsCredictUsingRateCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgScene.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace - 7 - 5, 40);
    if (_areaScene != nil) {
        self.areaScene.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.bgScene.hj_height - 40 - 5 - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
}
-(UIView *)bgScene
{
    if (_bgScene  == nil) {
        _bgScene = [YosKeepAccountsControl yka_createSceneWithFrame:CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2)];
        _bgScene.cornerRadius = 4;
        _bgScene.backgroundColor = [UIColor whiteColor];
        _bgScene.layer.shadowColor = [UIColor blackColor].CGColor;
        _bgScene.layer.shadowOpacity = 0.8f;
        _bgScene.layer.shadowRadius = 4.f;
        _bgScene.layer.shadowOffset = CGSizeMake(4,4);
    }
    return _bgScene;
}
-(UIImageView *)exampleImage
{
    if (_exampleImage  == nil) {
        _exampleImage = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(CGRectGetMaxX(self.bgScene.frame) - 10 - 79, self.bgScene.hj_x + 10, 79, 60) imageName:@"home_ic_corner"];
    }
    return _exampleImage;
}
-(UILabel *)titleLabel
{
    if (_titleLabel  == nil) {
        _titleLabel = [YosKeepAccountsControl yka_createLabelWithFrame:CGRectMake(LeftSpace, 10, 150, 40) Font:[UIFont BigTitleFont] Text:@"使用率"];
    }
    return _titleLabel;
}
-(UILabel *)statementLabel
{
    if (_statementLabel  == nil) {
        _statementLabel = [YosKeepAccountsControl yka_createLabelWithFrame:CGRectMake(LeftSpace, 50, 200, 30) Font:[UIFont normalFont] Text:@"反应您的公积金缴纳和提取情况"];
    }
    return _statementLabel;
}
-(UILabel *)analysisLabel
{
    if (_analysisLabel  == nil) {
        _analysisLabel = [YosKeepAccountsControl yka_createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，您多次提取公积金"];
    }
    return _analysisLabel;
}
-(YosKeepAccountsAreaSplineChartScene *)areaScene{
    if (_areaScene == nil) {
        _areaScene = [[YosKeepAccountsAreaSplineChartScene alloc] init];
    }
    return _areaScene;
}
-(void)config:(HomeDataEntity *)model example:(BOOL)isExample withType:(cellType)type{
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
            self.titleLabel.text = @"公积金账户";
            self.statementLabel.text = @"反应您的公积金缴纳和提取情况";
            [self.bgScene addSubview:self.areaScene];
    if (isExample == true && model != nil && [model.credictUseRate count] > 0) {
        self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.credictUseState];
        NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
        for (NSString *rate in model.credictUseRate) {
            [murArr1 addObject:[NSNumber numberWithInteger:rate.integerValue]];
            if ([rate isEqual:model.credictUseRate.lastObject]) {
                NSLog(@"____%@",murArr1);
                self.areaScene.callArr = murArr1;
                self.areaScene.chartType = AreaSplineTypeSingle;
            }
        }
    }else{
        self.areaScene.callArr = @[@4, @5, @3, @4, @5, @2];
        self.areaScene.chartType = AreaSplineTypeSingle;
    };
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
