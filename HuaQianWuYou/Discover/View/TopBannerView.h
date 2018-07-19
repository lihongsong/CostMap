//
//  TopBannerView.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HJ_UIKit/HJCarousel.h>
#import <HJ_UIKit/HJCarouselItemModel.h>
#import "DiscoverPageModel.h"
@class TopBannerView;
@protocol TopBannerViewProtocol <NSObject>

@optional

- (void)didSelected:(TopBannerView *)bannerView atIndex:(NSInteger)index;

@end

@interface TopBannerView : UIView<HJCarouselDelegate>

@property (nonatomic, weak) id<TopBannerViewProtocol>bannerViewDelegate;


@property(nonatomic,strong) NSArray <BannerModel *> *modelArray;

@end
