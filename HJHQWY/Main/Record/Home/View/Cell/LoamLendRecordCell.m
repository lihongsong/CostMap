//
//  LoamLendRecordCell.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/18.
//  Copyright © 2018年 jason. All rights reserved.
//
#define LeftSpace 15
#import "LoamLendRecordCell.h"
#import "GradientCompareBarView.h"

@interface LoamLendRecordCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
@property(nonatomic,strong)GradientCompareBarView *barView;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)UIImageView *pointImage;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation LoamLendRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateUI{
    self.bgView.frame = CGRectMake(LeftSpace, LeftSpace, SWidth - LeftSpace * 2, self.contentView.hj_height - LeftSpace * 2);
    self.analysisLabel.frame = CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace - 7 - 5, 40);
    if (_barView != nil) {
        self.barView.frame = CGRectMake(0,  CGRectGetMaxY(self.statementLabel.frame) + 5, self.bgView.hj_width, self.bgView.hj_height - 40 - 1 - CGRectGetMaxY(self.statementLabel.frame) - 5);
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
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，夜间通话偏多"];
    }
    return _analysisLabel;
}

-(UIView *)lineView
{
    if (_lineView  == nil) {
        _lineView = [ZYZControl createViewWithFrame:CGRectMake(0, self.bgView.hj_height - 40, self.bgView.hj_width,1)];
        _lineView.backgroundColor = [UIColor colorFromHexCode:@"f0f0f0"];
    }
    return _lineView;
}
-(UIImageView *)pointImage
{
    if (_pointImage == nil) {
        _pointImage = [ZYZControl createImageViewFrame:CGRectMake(LeftSpace, self.bgView.hj_height - 20 - 3.5, 7, 7) imageName:@"home_ic_mark"];
    }
    return _pointImage;
}
 

-(GradientCompareBarView *)barView{
    if (_barView == nil) {
        _barView = [[GradientCompareBarView alloc] init];
    }
    return _barView;
}

-(void)config:(HomeDataModel *)model example:(BOOL)isExample withType:(cellType)type{
    
    if (isExample == false) {
        [self addSubview:self.exampleImage];
    }else{
        [self.exampleImage removeFromSuperview];
    }
            self.titleLabel.text = @"通讯时段与分布";
            self.statementLabel.text = @"反应您的生活与工作习惯";
            [self.bgView addSubview:self.barView];
    if(isExample == true && model != nil && [model.credictUseRate count] > 0){
       self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.lendRecordState];
        NSMutableArray *murArr1 = [[NSMutableArray alloc]init];
        NSMutableArray *murArr2 = [[NSMutableArray alloc]init];
        for (CredictLendRecord *dicModel in model.credictLendRecord) {
            [murArr1 addObject:[NSNumber numberWithInteger:dicModel.lendCount.integerValue]];
            [murArr2 addObject:[NSNumber numberWithInteger:dicModel.repayCount.integerValue]];
            if ([dicModel isEqual:model.credictLendRecord.lastObject]) {
                self.barView.lendArr = murArr1;
                self.barView.repayArr = murArr2;
                [self.barView refreshData];
            }
        }
    }else{
        self.barView.lendArr = @[@3,@2,@5,@3,@9,@5];
        self.barView.repayArr = @[@1,@4,@7,@6,@8,@4];
        [self.barView refreshData];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
