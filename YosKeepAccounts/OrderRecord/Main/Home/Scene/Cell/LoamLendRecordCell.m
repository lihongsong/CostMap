#define LeftSpace 15
#import "LoamLendRecordCell.h"
#import "GradientCompareBarScene.h"
#import "ZYZControl.h"
@interface LoamLendRecordCell()
@property(nonatomic,strong)UIView *bgScene;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)GradientCompareBarScene *barScene;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)UIImageView *pointImage;
@property(nonatomic,strong)UIView *lineScene;
@end
@implementation LoamLendRecordCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)updateUI{
    self.bgScene.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace - 7 - 5, 40);
    if (_barScene != nil) {
        self.barScene.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgScene.hj_width, self.bgScene.hj_height - 40 - 1 - CGRectGetMaxY(self.statementLabel.frame) - 5);
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
        _titleLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 10, 150, 40) Font:[UIFont BigTitleFont] Text:@"通讯时段与分布"];
    }
    return _titleLabel;
}
-(UILabel *)statementLabel
{
    if (_statementLabel  == nil) {
        _statementLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 50, 200, 30) Font:[UIFont normalFont] Text:@"反应您的生活与工作习惯"];
    }
    return _statementLabel;
}
-(UILabel *)analysisLabel
{
    if (_analysisLabel  == nil) {
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，夜间通话偏多"];
    }
    return _analysisLabel;
}
-(UIView *)lineScene
{
    if (_lineScene  == nil) {
        _lineScene = [ZYZControl createSceneWithFrame:CGRectMake(0, self.bgScene.hj_height - 40, self.bgScene.hj_width,1)];
        _lineScene.backgroundColor = [UIColor colorFromHexCode:@"f0f0f0"];
    }
    return _lineScene;
}
-(UIImageView *)pointImage
{
    if (_pointImage == nil) {
        _pointImage = [ZYZControl createImageSceneFrame:CGRectMake(LeftSpace, self.bgScene.hj_height - 20 - 3.5, 7, 7) imageName:@"home_ic_mark"];
    }
    return _pointImage;
}
-(GradientCompareBarScene *)barScene {
    if (_barScene == nil) {
        _barScene = [[GradientCompareBarScene alloc] init];
    }
    return _barScene;
}
- (void)config:(HomeDataEntity *)model example:(BOOL)isExample withType:(cellType)type{
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
            self.titleLabel.text = @"通讯时段与分布";
            self.statementLabel.text = @"反应您的生活与工作习惯";
            [self.bgScene addSubview:self.barScene];
    if(isExample == true && model != nil && [model.credictUseRate count] > 0){
       self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.lendRecordState];
        NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
        NSMutableArray *murArr2 = [[NSMutableArray alloc]init];
        for (CredictLendRecord *dicEntity in model.credictLendRecord) {
            [murArr1 addObject:[NSNumber numberWithInteger:dicEntity.lendCount.integerValue]];
            [murArr2 addObject:[NSNumber numberWithInteger:dicEntity.repayCount.integerValue]];
            if ([dicEntity isEqual:model.credictLendRecord.lastObject]) {
                self.barScene.lendArr = murArr1;
                self.barScene.repayArr = murArr2;
                [self.barScene refreshData];
            }
        }
    }else{
        self.barScene.lendArr = @[@3,@2,@5,@3,@9,@5];
        self.barScene.repayArr = @[@1,@4,@7,@6,@8,@4];
        [self.barScene refreshData];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
