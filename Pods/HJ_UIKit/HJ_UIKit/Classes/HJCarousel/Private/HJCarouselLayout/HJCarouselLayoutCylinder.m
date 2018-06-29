//
//  HJCarouselLayoutCylinder.m
//  HJCarousel
//
//  Created by yoser on 2017/12/28.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselLayoutCylinder.h"

@implementation HJCarouselLayoutCylinder

+ (UICollectionViewLayout *)layoutWithItemSize:(CGSize)itemSize
                                   lineSpacing:(CGFloat)lineSpacing
                                  sectionInset:(UIEdgeInsets)sectionInset{
    HJCarouselLayoutCylinder *cylinder = [HJCarouselLayoutCylinder new];
    cylinder.itemSize = itemSize;
    cylinder.minimumLineSpacing = lineSpacing;
    cylinder.sectionInset = sectionInset;
    cylinder.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return cylinder;
}

- (void)prepareLayout{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewLayoutAttributes *)transformLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute{
    
    // y 轴方向上的旋转
    
    // 中心的点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 对于中心点的绝对值偏移量
    CGFloat differAbsX =  abs((int)attribute.center.x - (int)centerX);
    
    // 对于中心点的偏移量
    CGFloat differX = attribute.center.x - centerX;
    
    CGFloat radius = attribute.frame.size.width + self.minimumLineSpacing + 50;
    
    if(differAbsX > radius){
        return attribute;
    }
    
    CGFloat y = sqrt((radius * radius) - (differAbsX * differAbsX));
    
    // y方向上的偏移量
    
    // 旋转角度tan∂值
    CGFloat tanX_Y = differX / y;
    
    // 旋转角度的∂值
    CGFloat angleX_Y = atan(tanX_Y) * 2;
    
    CATransform3D  transform = attribute.transform3D;
    transform.m34 = -1.0 / 400;
    transform  = CATransform3DRotate(transform,angleX_Y, 0, 1, 0);
    
    attribute.transform3D = transform;
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *originsArray = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:originsArray copyItems:YES];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        UICollectionViewLayoutAttributes *tempAttribute = [self transformLayoutAttributes:attribute];
        [tempArray addObject:tempAttribute];
    }
    return [tempArray copy];
}

@end
