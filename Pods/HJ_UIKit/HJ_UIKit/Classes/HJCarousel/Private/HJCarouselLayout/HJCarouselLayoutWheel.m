//
//  HJCarouselLayoutWheel.m
//  HJCarousel
//
//  Created by yoser on 2017/12/27.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselLayoutWheel.h"

#define WheelDefaultRadius 300

@implementation HJCarouselLayoutWheel

+ (UICollectionViewLayout *)layoutWithItemSize:(CGSize)itemSize
                                   lineSpacing:(CGFloat)lineSpacing
                                  sectionInset:(UIEdgeInsets)sectionInset{
    HJCarouselLayoutWheel *wheel = [HJCarouselLayoutWheel new];
    wheel.itemSize = itemSize;
    wheel.minimumLineSpacing = lineSpacing;
    wheel.sectionInset = sectionInset;
    wheel.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return wheel;
}

- (void)prepareLayout{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewLayoutAttributes *)transformLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute{
    
    // 中心的点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 对于中心点的偏移量
    CGFloat differAbsX =  abs((int)attribute.center.x - (int)centerX);
    
    CGFloat differX = attribute.center.x - centerX;
    
    CGFloat radius = attribute.frame.size.width + self.minimumLineSpacing + 50;
    
    if(differAbsX > radius){
        return attribute;
    }
    
    CGFloat y = sqrt((radius * radius) - (differAbsX * differAbsX));
    
    // y方向上的偏移量
    CGFloat differY = radius - y;
    
    // 旋转角度
    CGFloat tanX_Y = differX / y;

    CGFloat angleX_Y = atan(tanX_Y);
    
    CGAffineTransform transform = CGAffineTransformRotate(attribute.transform, angleX_Y);
    
    CGPoint itemCenter = attribute.center;
    
    attribute.center = CGPointMake(itemCenter.x, itemCenter.y + differY);
    
    attribute.transform = transform;
    
    return attribute;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSArray *attributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];

    NSMutableArray *tempArray = [NSMutableArray array];

    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        UICollectionViewLayoutAttributes *newAttribute = [self transformLayoutAttributes:attribute];
        [tempArray addObject:newAttribute];
    }
    return [tempArray copy];
}


@end
