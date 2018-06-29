//
//  DiscoverTableViewCell.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiscoverTableViewCell()
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *updateTimeLabel;
@property(nonatomic,strong) UILabel *readTimeLabel;
@property(nonatomic,strong) UIImageView *articalImage;
@end
@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUpUI {
    WeakObj(self);
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.updateTimeLabel];
    [self.contentView addSubview:self.readTimeLabel];
    [self.contentView addSubview:self.articalImage];
    
    [self.articalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(100, 75));
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.right.bottom.mas_equalTo(self.contentView).mas_offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.top.mas_equalTo(self.contentView).mas_offset(15);
        make.right.mas_equalTo(self.articalImage.mas_left).mas_offset(-15);
        make.height.mas_equalTo(45);
    }];
    
    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-14);
        make.width.mas_equalTo(90);
    }];
    
    [self.readTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.updateTimeLabel.mas_right).mas_offset(10);
        make.width.mas_greaterThanOrEqualTo(50);
        make.centerY.height.mas_equalTo(self.updateTimeLabel);
    }];
}

- (void)updateCellModel:(DiscoverItemModel *)itemModel {
    self.titleLabel.text = itemModel.title;
    self.updateTimeLabel.text = itemModel.time;
    self.readTimeLabel.text = [NSString stringWithFormat:@"%@阅读",itemModel.readers];
    [self.articalImage sd_setImageWithURL:[NSURL URLWithString:itemModel.smallImageUrl]];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"什么口子不还会影响征信？哪些可能不用还？";
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HJHexColor(0x111111);
    }
    return _titleLabel;
}

- (UILabel *)updateTimeLabel {
    if (!_updateTimeLabel) {
        _updateTimeLabel = [UILabel new];
        _updateTimeLabel.text = @"2017-12-24";
        _updateTimeLabel.font = [UIFont systemFontOfSize:12];
        _updateTimeLabel.textColor = HJHexColor(0x999999);
    }
    return _updateTimeLabel;
}

- (UILabel *)readTimeLabel {
    if (!_readTimeLabel) {
        _readTimeLabel = [UILabel new];
        _readTimeLabel.text = @"1238阅读";
        _readTimeLabel.font = [UIFont systemFontOfSize:12];
        _readTimeLabel.textColor = HJHexColor(0x999999);
    }
    return _readTimeLabel;
}

- (UIImageView *)articalImage {
    if (!_articalImage) {
        _articalImage = [UIImageView new];
        [_articalImage sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3897286508,1658629498&fm=173&app=25&f=JPEG?w=218&h=146&s=56A698E66E532BDECFB9E42303006011"]];
    }
    return _articalImage;
}

@end
