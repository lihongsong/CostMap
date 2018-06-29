//
//  HJCarouselDataSource.h
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HJCarouselDataSource <NSObject>

- (UIView *)carouselPageControlItemForSeleted;

- (UIView *)carouselPageControlItemForNormal;

@end
