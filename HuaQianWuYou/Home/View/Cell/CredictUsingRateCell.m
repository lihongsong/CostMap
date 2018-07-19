//
//  CredictUsingRateCell.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/18.
//  Copyright © 2018年 jason. All rights reserved.
//
#define LeftSpace 15
#import "CredictUsingRateCell.h"
#import "AreaSplineChartView.h"
@interface CredictUsingRateCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)AreaSplineChartView *areaView;
@end
@implementation CredictUsingRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace - 7 - 5, 40);

    if (_areaView != nil) {
        self.areaView.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.bgView.hj_height - 40 - 5 - CGRectGetMaxY(self.statementLabel.frame) - 5);
    }
}

-(UIView *)bgView
{
    if (_bgView  == nil) {
        _bgView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2)];
        _bgView.cornerRadius = 4;
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        _bgView.layer.shadowOpacity = 0.8f;
        _bgView.layer.shadowRadius = 4.f;
        _bgView.layer.shadowOffset = CGSizeMake(4,4);

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

-(UILabel *)statementLabel
{
    if (_statementLabel  == nil) {
        _statementLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, 50, 200, 30) Font:[UIFont normalFont] Text:@"反应您的公积金缴纳和提取情况"];
    }
    return _statementLabel;
}

-(UILabel *)analysisLabel
{
    if (_analysisLabel  == nil) {
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，您多次提取公积金"];
    }
    return _analysisLabel;
}

-(AreaSplineChartView *)areaView{
    if (_areaView == nil) {
        _areaView = [[AreaSplineChartView alloc] init];
    }
    return _areaView;
}

-(void)config:(HomeDataModel *)model example:(BOOL)isExample withType:(cellType)type{
    
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
            self.titleLabel.text = @"公积金账户";
            self.statementLabel.text = @"反应您的公积金缴纳和提取情况";
            [self.bgView addSubview:self.areaView];
    if (isExample == true && model != nil && [model.credictUseRate count] > 0) {
        self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.credictUseState];
        NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
        for (NSString *rate in model.credictUseRate) {
            [murArr1 addObject:[NSNumber numberWithInteger:rate.integerValue]];
            if ([rate isEqual:model.credictUseRate.lastObject]) {
                NSLog(@"____%@",murArr1);
                self.areaView.callArr = murArr1;
                self.areaView.chartType = AreaSplineTypeSingle;
                //self.areaView.beCallArr = murArr2;
            }
        }
    }else{
        self.areaView.callArr = @[@4, @5, @3, @4, @5, @2];
        self.areaView.chartType = AreaSplineTypeSingle;
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
