//
//  ApplyRecordCell.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/18.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "ApplyRecordCell.h"
#import "CircleProgressView.h"
#import "ZYZControl.h"

#define LeftSpace 15

@interface ApplyRecordCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *statementLabel;
@property(nonatomic,strong)UIImageView *exampleImage;
//@property(nonatomic,strong)UIImageView *pointImage;
//@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *analysisLabel;
@property(nonatomic,strong)CircleProgressView *circleView;
@end

@implementation ApplyRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        _analysisLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace + 7 + 5,self.bgView.hj_height - 40 , self.bgView.hj_width - LeftSpace * 2, 40) Font:[UIFont normalFont] Text:@"解读：中度影响，工作较不稳定"];
    }
    return _analysisLabel;
}
/*
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
*/

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
            self.titleLabel.text = @"社保缴纳记录";
            self.statementLabel.text = @"反应您工作的稳定性";
            [self.bgView addSubview:self.circleView];
    if(isExample == true && model != nil && [model.credictUseRate count] > 0){
        self.analysisLabel.text = [NSString stringWithFormat:@"解读：%@", model.applyRecordState];
        self.circleView.model = model;
    }
//    else{
//        [self.circleView refreshData];
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
