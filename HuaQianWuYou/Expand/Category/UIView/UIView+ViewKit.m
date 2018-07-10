//
//  UIView+ViewKit.m
//  RKKit
//
//  Created by Asiazhang on 15/7/29.
//  Copyright (c) 2015年 AsiaZhang. All rights reserved.
//

#import "UIView+ViewKit.h"
#import "UILabel+LabelKit.h"
#import "GetImagePath.h"

@implementation UIView (ViewKit)

#pragma mark - getter

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)midX{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midY{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)halfWidth{
    return CGRectGetWidth(self.frame)*0.5;
}

- (CGFloat)halfHeight{
    return CGRectGetHeight(self.frame)*0.5;
}

- (CGPoint)internalCenter{
    return CGPointMake(self.halfWidth, self.halfHeight);
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGSize)size{
    return self.frame.size;
}

#pragma mark - setter

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGRect)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
    return self.frame;
}

- (CGRect)setMinX:(CGFloat)minX{
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
    
    return frame;
}

- (CGRect)setMinX:(CGFloat)minX maxX:(CGFloat)maxX{
    return [self setMinX:minX width:maxX - minX];
}

- (CGRect)setMinX:(CGFloat)minX width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.origin.x = minX;
    frame.size.width = width;
    self.frame = frame;
    
    return frame;
}

- (CGRect)setMidX:(CGFloat)midX{
    CGPoint center = self.center;
    center.x = midX;
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x = maxX - self.width;
    self.frame = frame;
    
    return self.frame;
}

- (CGRect)setMinY:(CGFloat)minY{
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
    
    return frame;
}

- (CGRect)setMidY:(CGFloat)midY{
    CGPoint center = self.center;
    center.y = midY;
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y = maxY - self.height;
    self.frame = frame;
    
    return self.frame;
}

- (CGRect)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
    return frame;
}

- (CGRect)setMinX:(CGFloat)minX minY:(CGFloat)minY {
    self.origin = CGPointMake(minX, minY);
    
    return self.frame;
}

- (CGRect)setMinX:(CGFloat)minX midY:(CGFloat)midY{
    CGPoint center = CGPointMake(minX + self.halfWidth, midY);
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMinX:(CGFloat)minX maxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    frame.origin.y = maxY - self.height;
    
    return self.frame = frame;
}

- (CGRect)setMidX:(CGFloat)midX minY:(CGFloat)minY{
    CGPoint center = CGPointMake(midX, minY + self.halfHeight);
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMidX:(CGFloat)midX maxY:(CGFloat)maxY{
    CGPoint center = CGPointMake(midX, maxY - self.halfHeight);
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMaxX:(CGFloat)maxX minY:(CGFloat)minY{
    CGRect frame = self.frame;
    frame.origin.x = maxX - self.width;
    frame.origin.y = minY;
    self.frame = frame;
    
    return self.frame;
}

- (CGRect)setMaxX:(CGFloat)maxX midY:(CGFloat)midY{
    CGPoint center = CGPointMake(maxX - self.halfWidth, midY);
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMaxX:(CGFloat)maxX maxY:(CGFloat)maxY {
    CGPoint center = CGPointMake(maxX - self.halfWidth, maxY - self.halfHeight);
    self.center = center;
    
    return self.frame;
}

- (CGRect)setMinY:(CGFloat)minY maxY:(CGFloat)maxY{
    return [self setMinY:minY height:maxY - minY];
}

- (CGRect)setMinY:(CGFloat)minY height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.origin.y = minY;
    frame.size.height = height;
    self.frame = frame;
    
    return self.frame;
}

#pragma mark - 类方法

+ (void)horizontalArrangeViews:(NSArray*)/*UIView*/views distances:(NSArray*)/*NSString*/distances alignmentType:(RKViewArrangeAlignment)alignment direction:(RKViewArrangeDirection)direction{
    __block UIView* lastView;
    [views enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        CGFloat distance = [distances[idx] doubleValue];
        (direction == RKViewArrangeDirectionRight) ? [view setMinX:(lastView.maxX + distance)] : [view setMinY:(lastView.maxY + distance)];
        
        switch (alignment) {
            case RKViewArrangeAlignmentMid:
                if (idx == 0) break;
                (direction == RKViewArrangeDirectionRight) ? [view setMidY:lastView.midY] : [view setMidX:lastView.midX];
                break;
                
            default:
                break;
        }
        
        lastView = view;
    }];
}

#pragma mark - 对象方法

- (void)addBottomView:(UIView *)bottomView {
    bottomView.origin = CGPointMake(0, self.height);
    [self addSubview:bottomView];
    
    self.height += bottomView.height;
}

- (UIView *)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    line.backgroundColor = color;
    [self addBottomView:line];
    return line;
}

- (UIView *)addBottomLineInViewWithColor:(UIColor *)color height:(CGFloat)height {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    line.backgroundColor = color;
    [line setMaxY:self.height];
    [self addSubview:line];
    return line;
}

- (UIView *)addTopLineInViewWithColor:(UIColor *)color height:(CGFloat)height {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    line.backgroundColor = color;
    [self addSubview:line];
    return line;
}

- (void)addTopView:(UIView *)topView {
    self.height += topView.height;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.minY += topView.height;
    }];
    [self addSubview:topView];
}

- (UIView *)addVerticalCenterLineInViewWithColor:(UIColor *)color size:(CGSize)size {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    line.backgroundColor = color;
    line.center = self.internalCenter;
    [self addSubview:line];
    return line;
}

- (void)showAlertWithContent:(NSString *)content {
    static UILabel *remindLabel;
    if (!remindLabel) {
        remindLabel = [[UILabel alloc] init];
        remindLabel.text = content;
        remindLabel.font = [UIFont normalFont];
        remindLabel.textColor = [UIColor whiteColor];
        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.size = CGRectMakeLargeByRect([remindLabel autosize], UIEdgeInsetsMakeAll(15)).size;
        remindLabel.layer.cornerRadius = 3;
        remindLabel.clipsToBounds = YES;
        remindLabel.backgroundColor = [UIColor blackColor];
        remindLabel.alpha = 0;
        remindLabel.center = self.internalCenter;
        [self addSubview:remindLabel];
        
        [UIView animateWithDuration:.25 animations:^{
            remindLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.25 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                remindLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [remindLabel removeFromSuperview];
                remindLabel = nil;
            }];
        }];
    }
}

- (void)addBorderLineAndShadow {
    self.clipsToBounds = NO;
    
    UIColor *sepaColor = [UIColor sepreateColor];
    
    UIView *sepa1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];;
    UIView *sepa2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, .5, self.height)];
    UIView *sepa3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, .5, self.height)];
    UIImageView *sepa4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1.5)];
    
    sepa1.backgroundColor = sepa2.backgroundColor = sepa3.backgroundColor = sepaColor;
    sepa4.image = [GetImagePath getImagePath:@"bottomShadow"];
    
    [sepa3 setMaxX:self.width];
    [sepa4 setMinY:self.height];
    
    [self addSubview:sepa1];
    [self addSubview:sepa2];
    [self addSubview:sepa3];
    [self addSubview:sepa4];
}

@end

extern CGRect CGRectMakeLargeByRect(CGRect frame, UIEdgeInsets edgeInsets) {
    CGFloat minX = frame.origin.x - edgeInsets.left;
    CGFloat minY = frame.origin.y - edgeInsets.top;
    CGFloat width = frame.size.width + edgeInsets.left + edgeInsets.right;
    CGFloat height = frame.size.height + edgeInsets.top + edgeInsets.bottom;
    return CGRectMake(minX, minY, width, height);
}

extern CGRect CGRectMakeLargeByPoint(CGPoint point, UIEdgeInsets edgeInsets) {
    CGFloat minX = point.x - edgeInsets.left;
    CGFloat minY = point.y - edgeInsets.top;
    CGFloat width = edgeInsets.left + edgeInsets.right;
    CGFloat height = edgeInsets.top + edgeInsets.bottom;
    return CGRectMake(minX, minY, width, height);
}

extern UIEdgeInsets UIEdgeInsetsMakeAll(CGFloat margin) {
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

