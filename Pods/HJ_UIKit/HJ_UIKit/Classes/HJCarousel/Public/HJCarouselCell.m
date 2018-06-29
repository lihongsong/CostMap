//
//  HJCarouselCell.m
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselCell.h"

@interface HJCarouselCell()

@property (strong, nonatomic) UIView *shadowView;

@property (strong, nonatomic) UIView *baseView;

@end


@implementation HJCarouselCell

+ (NSString *)cellID{
    return NSStringFromClass([HJCarouselCell class]);
}

+(Class)cellClass{
    return [HJCarouselCell class];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundView.clipsToBounds = NO;
        self.clipsToBounds = NO;
        self.contentView.clipsToBounds = NO;
        
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.userInteractionEnabled = YES;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
                self.baseView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.shadowView];
        [self.contentView addSubview:self.baseView];
        [self.contentView addSubview:_imageView];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_imageView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _shadowView.layer.shadowOffset = CGSizeMake(0, 4);
        _shadowView.layer.shadowRadius = 5.0;
        _shadowView.layer.shadowColor = self.shadowColor.CGColor;
        _shadowView.layer.shadowOpacity = 0.9;
        _shadowView.layer.borderColor = self.shadowColor.CGColor;
        _shadowView.layer.borderWidth = 2.0;
        _shadowView.layer.cornerRadius = 10.0;
        
    }
    return self;
}

#pragma mark - Getter & Setter

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    _shadowView.layer.shadowColor = self.shadowColor.CGColor;
    _shadowView.layer.borderColor = self.shadowColor.CGColor;
}

- (void)setShadowWidth:(CGFloat)shadowWidth {
    _shadowWidth = shadowWidth;
    _shadowView.layer.borderWidth = 2.0;
    _shadowView.layer.shadowOffset = CGSizeMake(0, shadowWidth);
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [UIView new];
    }
    return _baseView;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIView new];
    }
    return _shadowView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //    UIColor *shadowColor = _shadowColor;
    
    _baseView.layer.cornerRadius = _imageView.layer.cornerRadius;
    _baseView.layer.masksToBounds = YES;
    
    _shadowView.frame = self.bounds;
    _baseView.frame = self.bounds;
}

//- (CGRect)shadowLayerRect {
//
//    if (!_shadowColor) {
//        return CGRectZero;
//
//    }
//
//    CGFloat w = 0;
//    CGFloat h = 0;
//    CGFloat x = 0;
//    CGFloat y = 0;
//
//    if (_shadowDirection == HJCarouselShadowDirectionTop ||
//        _shadowDirection == HJCarouselShadowDirectionBottom) {
//        h = _shadowWidth * 2;
//        w = self.frame.size.width;
//    } else if (_shadowDirection ==  HJCarouselShadowDirectionLeft ||
//               _shadowDirection ==  HJCarouselShadowDirectionRight){
//        h = self.frame.size.height;
//        w = _shadowWidth * 2;
//    }
//
//    if (_shadowDirection == HJCarouselShadowDirectionRight) {
//        x = self.frame.size.width - _shadowWidth;
//    }
//    if (_shadowDirection == HJCarouselShadowDirectionLeft) {
//        x = -_shadowWidth;
//    }
//    if (_shadowDirection == HJCarouselShadowDirectionTop) {
//        y = -_shadowWidth;
//    }
//    if (_shadowDirection == HJCarouselShadowDirectionBottom) {
//        y = self.frame.size.height - _shadowWidth;
//    }
//
//    if (_shadowDirection == HJCarouselShadowDirectionAll) {
//        return CGRectMake(-_shadowWidth,
//                          -_shadowWidth,
//                          self.frame.size.width + _shadowWidth * 2,
//                          self.frame.size.height + _shadowWidth * 2);
//    }
//
//    return CGRectMake(x, y, w, h);
//}
//
//- (CGRect)shadowRect {
//
//    if (!_shadowColor) {
//        return CGRectZero;
//    }
//
//    CGFloat w = self.frame.size.width;
//    CGFloat h = self.frame.size.height;
//    CGFloat x = 0;
//    CGFloat y = 0;
//
//    switch (_shadowDirection) {
//        case HJCarouselShadowDirectionTop:
//            y = -_shadowWidth;
//            h += _shadowWidth;
//            break;
//        case HJCarouselShadowDirectionRight:
//            w += _shadowWidth;
//            break;
//        case HJCarouselShadowDirectionBottom:
//            h += _shadowWidth;
//            break;
//        case HJCarouselShadowDirectionLeft:
//            x = -_shadowWidth;
//            w += _shadowWidth;
//            break;
//
//        default:
//            x = -_shadowWidth;
//            y = -_shadowWidth;
//            w += _shadowWidth * 2;
//            h += _shadowWidth * 2;
//            break;
//    }
//
//    return CGRectMake(x, y, w, h);
//}


@end
