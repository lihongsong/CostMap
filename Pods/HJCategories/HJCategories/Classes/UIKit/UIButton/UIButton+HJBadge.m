//
//  UIButton+HJBadge.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIButton+HJBadge.h"
#import <objc/runtime.h>

NSString const *hj_UIButton_badgeKey = @"hj_UIButton_badgeKey";

NSString const *hj_UIButton_badgeBGColorKey = @"hj_UIButton_badgeBGColorKey";
NSString const *hj_UIButton_badgeTextColorKey = @"hj_UIButton_badgeTextColorKey";
NSString const *hj_UIButton_badgeFontKey = @"hj_UIButton_badgeFontKey";
NSString const *hj_UIButton_badgePaddingKey = @"hj_UIButton_badgePaddingKey";
NSString const *hj_UIButton_badgeMinSizeKey = @"hj_UIButton_badgeMinSizeKey";
NSString const *hj_UIButton_badgeOriginXKey = @"hj_UIButton_badgeOriginXKey";
NSString const *hj_UIButton_badgeOriginYKey = @"hj_UIButton_badgeOriginYKey";
NSString const *hj_UIButton_shouldHideBadgeAtZeroKey = @"hj_UIButton_shouldHideBadgeAtZeroKey";
NSString const *hj_UIButton_shouldAnimateBadgeKey = @"hj_UIButton_shouldAnimateBadgeKey";
NSString const *hj_UIButton_badgeValueKey = @"hj_UIButton_badgeValueKey";

@implementation UIButton (HJBadge)

@dynamic hj_badgeValue, hj_badgeBGColor, hj_badgeTextColor, hj_badgeFont;
@dynamic hj_badgePadding, hj_badgeMinSize, hj_badgeOriginX, hj_badgeOriginY;
@dynamic hj_shouldHideBadgeAtZero, hj_shouldAnimateBadge;

- (void)hj_badgeInit
{
    // Default design initialization
    self.hj_badgeBGColor   = [UIColor redColor];
    self.hj_badgeTextColor = [UIColor whiteColor];
    self.hj_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.hj_badgePadding   = 6;
    self.hj_badgeMinSize   = 8;
    self.hj_badgeOriginX   = self.frame.size.width - self.hj_badge.frame.size.width/2;
    self.hj_badgeOriginY   = -4;
    self.hj_shouldHideBadgeAtZero = YES;
    self.hj_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)hj_refreshBadge
{
    // Change new attributes
    self.hj_badge.textColor        = self.hj_badgeTextColor;
    self.hj_badge.backgroundColor  = self.hj_badgeBGColor;
    self.hj_badge.font             = self.hj_badgeFont;
}

- (CGSize) hj_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self hj_duplicateLabel:self.hj_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)hj_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self hj_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.hj_badgeMinSize) ? self.hj_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.hj_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.hj_badge.frame = CGRectMake(self.hj_badgeOriginX, self.hj_badgeOriginY, minWidth + padding, minHeight + padding);
    self.hj_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.hj_badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)hj_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.hj_shouldAnimateBadge && ![self.hj_badge.text isEqualToString:self.hj_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.hj_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.hj_badge.text = self.hj_badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self hj_updateBadgeFrame];
    }];
}

- (UILabel *)hj_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)hj_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.hj_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.hj_badge removeFromSuperview];
        self.hj_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)hj_badge {
    return objc_getAssociatedObject(self, &hj_UIButton_badgeKey);
}
-(void)setHj_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &hj_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)hj_badgeValue {
    return objc_getAssociatedObject(self, &hj_UIButton_badgeValueKey);
}
-(void) setHj_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &hj_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.hj_shouldHideBadgeAtZero)) {
        [self hj_removeBadge];
    } else if (!self.hj_badge) {
        // Create a new badge because not existing
        self.hj_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.hj_badgeOriginX, self.hj_badgeOriginY, 20, 20)];
        self.hj_badge.textColor            = self.hj_badgeTextColor;
        self.hj_badge.backgroundColor      = self.hj_badgeBGColor;
        self.hj_badge.font                 = self.hj_badgeFont;
        self.hj_badge.textAlignment        = NSTextAlignmentCenter;
        [self hj_badgeInit];
        [self addSubview:self.hj_badge];
        [self hj_updateBadgeValueAnimated:NO];
    } else {
        [self hj_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)hj_badgeBGColor {
    return objc_getAssociatedObject(self, &hj_UIButton_badgeBGColorKey);
}
-(void)setHj_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &hj_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_refreshBadge];
    }
}

// Badge text color
-(UIColor *)hj_badgeTextColor {
    return objc_getAssociatedObject(self, &hj_UIButton_badgeTextColorKey);
}
-(void)setHj_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &hj_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_refreshBadge];
    }
}

// Badge font
-(UIFont *)hj_badgeFont {
    return objc_getAssociatedObject(self, &hj_UIButton_badgeFontKey);
}
-(void)setHj_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &hj_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) hj_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setHj_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &hj_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) hj_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setHj_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &hj_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) hj_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setHj_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &hj_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_updateBadgeFrame];
    }
}

-(CGFloat) hj_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setHj_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &hj_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.hj_badge) {
        [self hj_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) hj_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setHj_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &hj_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) hj_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &hj_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setHj_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &hj_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
