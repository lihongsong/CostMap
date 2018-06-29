//
//  HJCarouselLayoutSubcontract.m
//  HJCarousel
//
//  Created by yoser on 2017/12/28.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselLayoutSubcontract.h"

@implementation HJCarouselLayoutSubcontract

+ (UICollectionViewLayout *)layoutWithItemSize:(CGSize)itemSize
                                   lineSpacing:(CGFloat)lineSpacing
                                  sectionInset:(UIEdgeInsets)sectionInset{
    HJCarouselLayoutSubcontract *subcontract = [HJCarouselLayoutSubcontract new];
    subcontract.itemSize = itemSize;
    subcontract.minimumLineSpacing = lineSpacing;
    subcontract.sectionInset = sectionInset;
    subcontract.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return subcontract;
}

- (void)prepareLayout{
    [super prepareLayout];
}

- (UICollectionViewLayoutAttributes *)transformLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute{
    
    // 局部变小实现
    CGFloat inset = 20;
    
    // 中心的点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 对于中心点的绝对值偏移量
    CGFloat differAbsX =  abs((int)attribute.center.x - (int)centerX);
    
    CGFloat differMaxX = self.itemSize.width + self.minimumLineSpacing;
    
    if(differAbsX >= differMaxX){
        differAbsX = differMaxX;
    }
    
    CGFloat scale = differAbsX / differMaxX;
    
    CGAffineTransform originTransform = attribute.transform;
    
    CGFloat scaleX = (attribute.frame.size.width - scale * inset) / attribute.frame.size.width;
    CGFloat scaleY = (attribute.frame.size.height - scale * inset) / attribute.frame.size.height;
    
    CGAffineTransform newTransform = CGAffineTransformScale(originTransform, scaleX, scaleY);
    attribute.transform = newTransform;
    
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

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end
