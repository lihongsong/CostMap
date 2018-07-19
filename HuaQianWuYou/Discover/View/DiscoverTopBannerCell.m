//
//  DiscoverTopBannerCell.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverTopBannerCell.h"
@interface DiscoverTopBannerCell()<TopBannerViewProtocol>
@end
@implementation DiscoverTopBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

#pragma - mark UI布局
- (void)setUpUI {
    [self.contentView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma - mark setter && getter
- (TopBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [TopBannerView new];
        _bannerView.bannerViewDelegate = self;
    }
    return _bannerView;
}

- (void)didSelected:(TopBannerView *)bannerView atIndex:(NSInteger)index {
    if ([self.bannerViewDelegate respondsToSelector:@selector(didSelected:atIndex:)]) {
        [self.bannerViewDelegate didSelected:self atIndex:index];
    }
}
@end
