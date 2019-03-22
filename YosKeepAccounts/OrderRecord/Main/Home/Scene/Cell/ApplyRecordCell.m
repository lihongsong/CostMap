#import "ApplyRecordCell.h"
#import "CircleProgressScene.h"
#import "ZYZControl.h"
#define LeftSpace 15
@interface ApplyRecordCell()
@property(nonatomic,strong)UIView *bgScene;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)CircleProgressScene *circleScene;
@end
@implementation ApplyRecordCell
- (void)awakeFromNib {
    [super awakeFromNib];
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
        _titleLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 10, 150, 40) Font:[UIFont BigTitleFont] Text:@"记录"];
    }
    return _titleLabel;
}
-(UILabel *)statementLabel
{
    if (_statementLabel  == nil) {
        _statementLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 50, 150, 30) Font:[UIFont normalFont] Text:@"反映您的持续情况"];
    }
    return _statementLabel;
}
-(UILabel *)analysisLabel
{
    if (_analysisLabel  == nil) {
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgScene.hj_height - 40 , self.bgScene.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，工作较不稳定"];
    }
    return _analysisLabel;
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
            self.titleLabel.text = @"社保缴纳记录";
            self.statementLabel.text = @"反应您工作的稳定性";
            [self.bgScene addSubview:self.circleScene];
    if(isExample == true && model != nil && [model.credictUseRate count] > 0){
        self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.applyRecordState];
        self.circleScene.model = model;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
