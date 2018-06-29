//
//  MineTableViewCell.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *rightImageView;
@property(nonatomic, assign) MineTableViewCellType cellType;
@property(nonatomic, strong) UISwitch *switchView;
@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellType = MineTableViewCellType_Default;
    }
    return self;
}

#pragma - mark UI布局

- (void)setUpUI {
    WeakObj(self);
    UIView *bgView = [UIView new];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SWidth, 50));
    }];

    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.switchView];

    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
    }];

    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(7.5, 11));
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-10);
        make.height.mas_equalTo(30);
    }];

    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(48, 28));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
    }];
}

#pragma - mark setter && getter

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = HJHexColor(0x111111);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.image = [UIImage imageNamed:@"public_arrow_01"];
    }
    return _rightImageView;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [UISwitch new];
        _switchView.onTintColor = HJHexColor(0xFC612B);
        [_switchView addTarget:self action:@selector(onSwitchViewTapped:) forControlEvents:UIControlEventValueChanged];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        _switchView.on = [userDefault boolForKey:@"kCachedTouchIdStatus"];
    }
    return _switchView;
}

- (void)updateCellInfo:(NSDictionary *)info {
    self.titleLabel.text = info[@"itemName"];
    self.leftImageView.image = [UIImage imageNamed:info[@"logo"]];
    [self setCellType:[info[@"celltType"] integerValue]];
}

- (void)setCellType:(MineTableViewCellType)cellType {
    _cellType = cellType;
    switch (cellType) {
        case MineTableViewCellType_None: {
            self.rightImageView.hidden = YES;
            self.switchView.hidden = YES;
        }
            break;
        case MineTableViewCellType_Switch: {
            self.rightImageView.hidden = YES;
            self.switchView.hidden = NO;
        }
            break;
        case MineTableViewCellType_Default:
        default: {
            self.rightImageView.hidden = NO;
            self.switchView.hidden = YES;
        }
            break;
    }
}

#pragma - mark Events

- (void)onSwitchViewTapped:(UISwitch *)sender {
    if (self.delegate) {
        [self.delegate MineTableViewCellDidTapSwitch:sender];
    }
}
@end
