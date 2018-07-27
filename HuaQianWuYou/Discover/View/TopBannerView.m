//
//  TopBannerView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "TopBannerView.h"

@interface TopBannerView()
@property (nonatomic, strong) HJCarousel *carousel;
@property (nonatomic, strong) UILabel *tipLabel1;
@property (nonatomic, strong) UILabel *tipLabel2;
@property (nonatomic, strong) UIView *tipBgView;

@end

@implementation TopBannerView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

#pragma - mark UI布局
- (void)setUpUI {
    WeakObj(self);
    [self addSubview:self.carousel];
    [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.tipBgView = [UIView new];
    //初始化时候tag设置为0
    self.tipBgView.tag = 0;
    [self insertSubview:self.tipBgView aboveSubview:self.carousel];
    [self.tipBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerX.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, SWidth, 40);
    [self.tipBgView.layer addSublayer:gradientLayer];

    
    [self.tipBgView addSubview:self.tipLabel1];
    [self.tipBgView addSubview:self.tipLabel2];
    
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.tipBgView.mas_centerY);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(23);
        make.right.mas_equalTo(self.tipLabel2.mas_left).mas_offset(-10);
        
    }];
    
    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerY.height.mas_equalTo(self.tipLabel1);
        make.right.mas_equalTo(self.tipBgView.mas_right).mas_offset(-15);
        make.width.mas_equalTo(30);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipSelected:)];
    [self.tipBgView addGestureRecognizer:tap];
    
}

- (void)tipSelected:(UITapGestureRecognizer *)sender {
    if ([self.bannerViewDelegate respondsToSelector:@selector(didSelected:atIndex:)]) {
        [self.bannerViewDelegate didSelected:self atIndex:sender.view.tag];
    }
}


-(void)setModelArray:(NSArray<BannerModel *> *)modelArray{
    _modelArray = modelArray;
    NSMutableArray<HJCarouselItemModel *> *imageNamesArray = [@[] mutableCopy];
    for (int i = 0; i < modelArray.count; i++) {
        BannerModel *bannerInfo = modelArray[i];
        HJCarouselItemModel *model = [HJCarouselItemModel new];
        model.source = bannerInfo.bigImageUrl;
        model.imagePlaceHolder = [UIImage imageNamed:@"home_banner_defaultimg"];
        model.sourceType = HJCarouselContentTypeUrl;
        [imageNamesArray addObject:model];
    }
    self.carousel.source = imageNamesArray;
    if (modelArray.count > 0) {
        [self.carousel run];
        self.tipLabel2.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)modelArray.count];
        self.tipLabel1.text = [NSString stringWithFormat:@"%@",SafeStr(modelArray[0].title)];
    }
}

#pragma - mark setter && getter

- (HJCarousel *)carousel {
    if (_carousel == nil) {
        _carousel = [HJCarousel carouselWithMaker:^(HJCarousel *maker) {
            maker.sourceType = HJCarouselContentTypeUrl;
            maker.delegate = self;
            maker.duration = 4.0f;
            maker.frame = self.bounds;
            maker.itemSize = CGSizeMake(SWidth , 200);
            maker.shadowColor = [UIColor clearColor];
            maker.shadowWidth = 5.0f;
            maker.shadowDirection = HJCarouselShadowDirectionBottom;
            maker.scrollType = HJCarouselScrollTypeInertia;
            maker.pageControlColor = [UIColor clearColor];
            maker.pageControlSeletedColor = [UIColor clearColor];
            maker.source = @[[HJCarouselItemModel new],[HJCarouselItemModel new]];
        }];
        
    }
    return _carousel;
}

- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [UILabel new];
        _tipLabel1.textColor = [UIColor whiteColor];
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2 {
    if (!_tipLabel2) {
        _tipLabel2 = [UILabel new];
        _tipLabel2.textColor = [UIColor whiteColor];
    }
    return _tipLabel2;
}

- (void)carouselDidDisplayItemAtIndex:(NSInteger)index {
    NSInteger bannerInde = index < 0 ? self.modelArray.count - 1 : index;
    self.tipLabel1.text = self.modelArray[bannerInde].title;
    self.tipLabel2.text = [NSString stringWithFormat:@"%ld/%ld",bannerInde + 1,self.modelArray.count];
    self.tipBgView.tag = bannerInde;
}

- (void)carouselDidSelectedItem:(HJCarouselCell *)cell atIndex:(NSInteger)index {
    if ([self.bannerViewDelegate respondsToSelector:@selector(didSelected:atIndex:)]) {
        [self.bannerViewDelegate didSelected:self atIndex:index];
    }
}

@end
