#define LeftSpace 15
#import "HomeBaseListCell.h"
#import "AreaSplineChartScene.h"
#import "GradientCompareBarScene.h"
#import "CircleProgressScene.h"
#import "ZYZControl.h"
@interface HomeBaseListCell()
@property(nonatomic,strong)UIView *bgScene;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)UIImageView *pointImage;
@property(nonatomic,strong)UIView *lineScene;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)AreaSplineChartScene *areaScene;
@property(nonatomic,strong)GradientCompareBarScene *barScene;
@property(nonatomic,strong)CircleProgressScene *circleScene;
@end
@implementation HomeBaseListCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor homeBGColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgScene];
        [self.bgScene addSubview:self.titleLabel];
        [self.bgScene addSubview:self.statementLabel];
        [self.bgScene addSubview:self.lineScene];
        [self.bgScene addSubview:self.pointImage];
        [self.bgScene addSubview:self.analysisLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgScene.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace - 7 - 5, 40);
    if (_areaScene != nil) {
        self.areaScene.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.lineScene.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
    if (_barScene != nil) {
        self.barScene.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.lineScene.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
    self.lineScene.frame = CGRectMake(0, self.bgScene.hj_height - 40, self.bgScene.hj_width,1);
    self.pointImage.frame = CGRectMake(LeftSpace, self.bgScene.hj_height - 20 - 3.5, 7, 7);
  [self updateUI];
}
- (void)updateUI {
    if (_areaScene != nil) {
        self.areaScene.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.lineScene.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
}
-(UIView *)bgScene
{
    if (_bgScene  == nil) {
        _bgScene = [ZYZControl createSceneWithFrame:CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2)];
        _bgScene.cornerRadius = 4;
        _bgScene.backgroundColor = [UIColor whiteColor];
    }
    return _bgScene;
}
-(UIImageView *)exampleImage
{
    if (_exampleImage  == nil) {
        _exampleImage = [ZYZControl createImageSceneFrame:CGRectMake(CGRectGetMaxX(self.bgScene.frame) - 10 - 79, self.bgScene.hj_x + 10, 79, 60) imageName:@"home_ic_corner"];
    }
    return _exampleImage;
}
-(UILabel *)titleLabel
{
    if (_titleLabel  == nil) {
        _titleLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 10, 150, 40) Font:[UIFont BigTitleFont] Text:@"使用率"];
    }
    return _titleLabel;
}
-(UIView *)lineScene
{
    if (_lineScene  == nil) {
        _lineScene = [ZYZControl createSceneWithFrame:CGRectMake(0, self.bgScene.hj_height - 40, self.bgScene.hj_width,1)];
        _lineScene.backgroundColor = [UIColor colorFromHexCode:@"f0f0f0"];
    }
    return _lineScene;
}
-(UILabel *)statementLabel
{
    if (_statementLabel  == nil) {
        _statementLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 50, 200, 30) Font:[UIFont normalFont] Text:@"反映您的持续情况"];
    }
    return _statementLabel;
}
-(UILabel *)analysisLabel
{
    if (_analysisLabel  == nil) {
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响-稳定性近期发生巨大变化"];
    }
    return _analysisLabel;
}
-(UIImageView *)pointImage
{
    if (_pointImage == nil) {
        _pointImage = [ZYZControl createImageSceneFrame:CGRectMake(LeftSpace, self.bgScene.hj_height - 20 - 3.5, 7, 7) imageName:@"home_ic_mark"];
    }
    return _pointImage;
}
-(AreaSplineChartScene *)areaScene{
    if (_areaScene == nil) {
        _areaScene = [[AreaSplineChartScene alloc] init];
    }
    return _areaScene;
}
-(GradientCompareBarScene *)barScene{
    if (_barScene == nil) {
        _barScene = [[GradientCompareBarScene alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.lineScene.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5)];
    }
    return _barScene;
}
-(CircleProgressScene *)circleScene{
    if (_circleScene == nil) {
        _circleScene = [[CircleProgressScene alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, CircleHeight + 40 + 10)];
    }
    return _circleScene;
}
-(void)config:(HomeDataEntity *)model example:(BOOL)isExample withType:(cellType)type{
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
    switch (type) {
        case CommunicationActiveType:
        {
            self.titleLabel.text = @"通讯稳定性";
            self.statementLabel.text = @"反应您的社会交往稳定性";
             [self.bgScene addSubview:self.areaScene];
            if (isExample == true && model != nil && [model.credictUseRate count] > 0) {
                self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.communicationState];
                NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
                NSMutableArray *murArr2 = [[NSMutableArray alloc]init];
                for (CommunicationActiveEntity *dicEntity in model.communicationActive) {
                    [murArr1 addObject:[NSNumber numberWithInteger:dicEntity.calling.integerValue]];
                    [murArr2 addObject:[NSNumber numberWithInteger:dicEntity.called.integerValue]];
                    if ([dicEntity isEqual:model.communicationActive.lastObject]) {
                        self.areaScene.callArr = murArr1;
                        self.areaScene.beCallArr = murArr2;
                        self.areaScene.chartType = AreaSplineTypeCompare;
                    }
                }
            }else{
                self.areaScene.callArr = @[@3,@5,@3,@4,@3,@5];
                self.areaScene.beCallArr = @[@7, @9, @6, @8, @9, @6];
                self.areaScene.chartType = AreaSplineTypeCompare;
            }
        }
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
