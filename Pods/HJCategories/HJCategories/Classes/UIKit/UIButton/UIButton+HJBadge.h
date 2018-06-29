//
//  UIButton+HJBadge.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIButton (HJBadge)

@property (strong, nonatomic) UILabel *hj_badge;

/**
 Badge value to be display
 */
@property (nonatomic) NSString *hj_badgeValue;

/**
 Badge background color
 */
@property (nonatomic) UIColor *hj_badgeBGColor;

/**
 Badge text color
 */
@property (nonatomic) UIColor *hj_badgeTextColor;

/**
 Badge font
 */
@property (nonatomic) UIFont *hj_badgeFont;

/**
 Padding value for the badge
 */
@property (nonatomic) CGFloat hj_badgePadding;

/**
 Minimum size badge to small
 */
@property (nonatomic) CGFloat hj_badgeMinSize;

/**
 Values for offsetX the badge over the BarButtonItem you picked
 */
@property (nonatomic) CGFloat hj_badgeOriginX;

/**
 Values for offsetY the badge over the BarButtonItem you picked
 */

@property (nonatomic) CGFloat hj_badgeOriginY;

/**
 In case of numbers, remove the badge when reaching zero
 */
@property BOOL hj_shouldHideBadgeAtZero;

/**
 Badge has a bounce animation when value changes
 */
@property BOOL hj_shouldAnimateBadge;

@end
