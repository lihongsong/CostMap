//
//  HomeBaseTableViewCell.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//
#define LeftSpace 15

#import "HomeBaseTableViewCell.h"
#import "AreaSplineChartView.h"
#import "GradientCompareBarView.h"
#import "CircleProgressView.h"
#import "ZYZControl.h"

@interface HomeBaseTableViewCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)UIImageView *pointImage;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)AreaSplineChartView *areaView;
@property(nonatomic,strong)GradientCompareBarView *barView;
@property(nonatomic,strong)CircleProgressView *circleView;
@end

@implementation HomeBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//// 1. 初始化子视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor homeBGColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.statementLabel];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.pointImage];
        [self.bgView addSubview:self.analysisLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace - 7 - 5, 40);
    if (_areaView != nil) {
        self.areaView.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.lineView.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
    if (_barView != nil) {
        self.barView.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.lineView.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
    self.lineView.frame = CGRectMake(0, self.bgView.hj_height - 40, self.bgView.hj_width,1);
    self.pointImage.frame = CGRectMake(LeftSpace, self.bgView.hj_height - 20 - 3.5, 7, 7);
  [self updateUI];
}

- (void)updateUI {
    if (_areaView != nil) {
        self.areaView.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.lineView.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
}
    
-(UIView *)bgView
{
    if (_bgView  == nil) {
        _bgView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2)];
        _bgView.cornerRadius = 4;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIImageView *)exampleImage
{
    if (_exampleImage  == nil) {
        _exampleImage = [ZYZControl createImageViewFrame:CGRectMake(CGRectGetMaxX(self.bgView.frame) - 10 - 79, self.bgView.hj_x + 10, 79, 60) imageName:@"home_ic_corner"];
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

-(UIView *)lineView
{
    if (_lineView  == nil) {
        _lineView = [ZYZControl createViewWithFrame:CGRectMake(0, self.bgView.hj_height - 40, self.bgView.hj_width,1)];
        _lineView.backgroundColor = [UIColor colorFromHexCode:@"f0f0f0"];
    }
    return _lineView;
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
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响-稳定性近期发生巨大变化"];
    }
    return _analysisLabel;
}

-(UIImageView *)pointImage
{
    if (_pointImage == nil) {
        _pointImage = [ZYZControl createImageViewFrame:CGRectMake(LeftSpace, self.bgView.hj_height - 20 - 3.5, 7, 7) imageName:@"home_ic_mark"];
    }
    return _pointImage;
}

-(AreaSplineChartView *)areaView{
    if (_areaView == nil) {
        _areaView = [[AreaSplineChartView alloc] init];
    }
    return _areaView;
}

-(GradientCompareBarView *)barView{
    if (_barView == nil) {
        _barView = [[GradientCompareBarView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.lineView.hj_y - CGRectGetMaxY(self.statementLabel.frame) - 5)];
    }
    return _barView;
}

-(CircleProgressView *)circleView{
    if (_circleView == nil) {
        _circleView = [[CircleProgressView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, CircleHeight + 40 + 10)];
    }
    return _circleView;
}

-(void)config:(HomeDataModel *)model example:(BOOL)isExample withType:(cellType)type{
    
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
    switch (type) {
//        case CredictUseRateType:
//            {
//                self.titleLabel.text = @"使用率";
//                self.statementLabel.text = @"反映您的持续情况";
//                 self.areaView.chartType = AreaSplineTypeSingle;
//                [self.bgView addSubview:self.areaView];
//            }
//            break;
//        case ApplyRecordType:
//        {
//            self.titleLabel.text = @"记录";
//            self.statementLabel.text = @"反映您的需求";
//            [self.bgView addSubview:self.circleView];
//            self.circleView.model = model;
//        }
//            break;
//        case LendRecordType:
//        {
//            self.titleLabel.text = @"信贷记录";
//            self.statementLabel.text = @"反映您的负债情况";
//            [self.bgView addSubview:self.barView];
//        }
//            break;
        case CommunicationActiveType:
        {
            self.titleLabel.text = @"通讯稳定性";
            self.statementLabel.text = @"反应您的社会交往稳定性";
             [self.bgView addSubview:self.areaView];
            if (isExample == true && model != nil && [model.credictUseRate count] > 0) {
                self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.communicationState];
                NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
                NSMutableArray *murArr2 = [[NSMutableArray alloc]init];
                for (CommunicationActiveModel *dicModel in model.communicationActive) {
                    [murArr1 addObject:[NSNumber numberWithInteger:dicModel.calling.integerValue]];
                    [murArr2 addObject:[NSNumber numberWithInteger:dicModel.called.integerValue]];
                    if ([dicModel isEqual:model.communicationActive.lastObject]) {
                        //NSLog(@"____%@",murArr1);
                        //NSLog(@"____%@",murArr2);
                        self.areaView.callArr = murArr1;
                        self.areaView.beCallArr = murArr2;
                        self.areaView.chartType = AreaSplineTypeCompare;
                    }
                }
            }else{
                self.areaView.callArr = @[@3,@5,@3,@4,@3,@5];
                self.areaView.beCallArr = @[@7, @9, @6, @8, @9, @6];
                self.areaView.chartType = AreaSplineTypeCompare;
            }
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
