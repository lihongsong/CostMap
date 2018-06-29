//
//  HJCarouselCell.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCarousel-define.h"

@interface HJCarouselCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIColor *shadowColor;

@property (assign, nonatomic) CGFloat shadowWidth;

@property (assign, nonatomic) HJCarouselShadowDirection shadowDirection;

+ (NSString *)cellID;

+ (Class)cellClass;

@end
