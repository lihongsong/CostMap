//
//  DiscoverDetailTopView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverDetailTopView.h"

@interface DiscoverDetailTopView()
@property (nonatomic,copy) UILabel *titleLabel;
@property (nonatomic,copy) UILabel *tipLabel;
@property (nonatomic,copy) UILabel *updateTimeLabel;
@property (nonatomic,copy) UILabel *readTimeLabel;
@end
@implementation DiscoverDetailTopView

- (instancetype)init {
    if ([super init]) {
        [self setUpUI];
    }
    return  self;
}

#pragma - mark UI布局
- (void)setUpUI {
    WeakObj(self);
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.updateTimeLabel];
    [self addSubview:self.readTimeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.mas_top).mas_offset(13);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(75);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(self.readTimeLabel.mas_left).mas_offset(-10);
    }];

    [self.readTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.height.top.centerY.mas_equalTo(self.tipLabel);
        make.width.mas_equalTo(100);
    }];
    
    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.height.height.centerY.mas_equalTo(self.tipLabel);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.width.mas_greaterThanOrEqualTo(67);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = HJHexColor(0x111111);
    }
    return _titleLabel;
}


-(UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
//        _tipLabel.text = @"世界的焦点";
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = HJHexColor(0x999999);
    }
    return _tipLabel;
}

- (UILabel *)updateTimeLabel {
    if (!_updateTimeLabel) {
        _updateTimeLabel = [UILabel new];
//        _updateTimeLabel.text = @"2017-12-26";
        _updateTimeLabel.font = [UIFont systemFontOfSize:12];
        _updateTimeLabel.textColor = HJHexColor(0x999999);
    }
    return _updateTimeLabel;
}

- (UILabel *)readTimeLabel {
    if (!_readTimeLabel) {
        _readTimeLabel = [UILabel new];
//        _readTimeLabel.text = @"4876人已阅读";
        _readTimeLabel.font = [UIFont systemFontOfSize:12];
        _readTimeLabel.textColor = HJHexColor(0x999999);
    }
    return _readTimeLabel;
}

- (void)updataInfoWithModel:(DiscoverDetailModel*)model {
    _titleLabel.text = model.title;
    _tipLabel.text = model.theme;
    if (model.create_time.length >= 10) {
        _updateTimeLabel.text = [model.create_time substringWithRange:NSMakeRange(0, 10)];
    } else {
        _updateTimeLabel.text = model.create_time;
    }
    _readTimeLabel.text = [NSString stringWithFormat:@"%@人已阅读",model.read_num];
}

@end
