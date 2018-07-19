//
//  DiscoverTopBannerCell.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBannerView.h"

@class DiscoverTopBannerCell;
@protocol DiscoverTopBannerCellProtocol <NSObject>

@optional

//- (void)didSelected:(HJCarouselCell *)cell atIndex:(NSInteger)index;
- (void)didSelected:(DiscoverTopBannerCell *)bannerView atIndex:(NSInteger)index;

@end
@interface DiscoverTopBannerCell : UITableViewCell
@property (nonatomic, weak) id<DiscoverTopBannerCellProtocol>bannerViewDelegate;

@property (nonatomic, strong) TopBannerView *bannerView;
//@property(nonatomic,strong) NSArray <TopBannerModel *> *modelArray;
@end
