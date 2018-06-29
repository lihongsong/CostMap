//
//  HJCarouselLayoutManager.m
//  HJCarousel
//
//  Created by yoser on 2017/12/26.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "HJCarouselLayoutManager.h"
#import "HJLayoutInitialization.h"

#import "HJCarouseLayoutTimeMachine.h"
#import "HJCarouselLayoutLinear.h"
#import "HJCarouselLayoutWheel.h"
#import "HJCarouselLayoutCylinder.h"
#import "HJCarouselLayoutSubcontract.h"

static NSString * const HJCarouselCustomLayoutKey = @"HJCarouselCustomLayoutKey";

static NSString * const HJCarouselSystemLayoutKey = @"HJCarouselSystemLayoutKey";

static HJCarouselLayoutManager *layoutManager = nil;

@interface HJCarouselLayoutManager()

@property (strong, nonatomic) NSMutableDictionary <NSString *, Class> *layoutDic;

@end

@implementation HJCarouselLayoutManager

+ (instancetype)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        layoutManager = [HJCarouselLayoutManager new];
        [layoutManager registerLayout];
    });
    return layoutManager;
}

+ (void)registerCustomerLayout:(Class)layoutClass{
    [[HJCarouselLayoutManager shared].layoutDic setObject:layoutClass forKey:HJCarouselCustomLayoutKey];
}

+ (UICollectionViewLayout *)layoutWithType:(HJCarouselType)type
                                  itemSize:(CGSize)itemSize
                               lineSpacing:(CGFloat)lineSpacing
                              sectionInset:(UIEdgeInsets)sectionInset{
    if(type == HJCarouselTypeCustom){
        return [self customLayoutWithItemSize:itemSize
                                  lineSpacing:lineSpacing
                                 sectionInset:sectionInset];
    }else{
        return [self systemLayoutWithType:type
                                 itemSize:itemSize
                              lineSpacing:lineSpacing
                             sectionInset:sectionInset];
    }
}

+ (UICollectionViewLayout *)customLayoutWithItemSize:(CGSize)itemSize
                                         lineSpacing:(CGFloat)lineSpacing
                                        sectionInset:(UIEdgeInsets)sectionInset{
    
    Class customLayout = (Class)[[HJCarouselLayoutManager shared].layoutDic valueForKey:HJCarouselCustomLayoutKey];
    
    if(customLayout == nil || ![customLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        return nil;
    }
    
    return (UICollectionViewLayout *)[customLayout new];
}

+ (UICollectionViewLayout *)systemLayoutWithType:(HJCarouselType)type
                                        itemSize:(CGSize)itemSize
                                     lineSpacing:(CGFloat)lineSpacing
                                    sectionInset:(UIEdgeInsets)sectionInset {
    
    NSString *key = systemLayoutKey(type);
    
    Class customLayout = (Class)[[HJCarouselLayoutManager shared].layoutDic valueForKey:key];
    
    if (customLayout == nil ||
        ![customLayout isSubclassOfClass:[UICollectionViewLayout class]] ||
        ![customLayout conformsToProtocol:@protocol(HJLayoutInitialization)]){
        return nil;
    }
    
    return [(id<HJLayoutInitialization>)customLayout layoutWithItemSize:itemSize
                                                            lineSpacing:lineSpacing
                                                           sectionInset:sectionInset];
}

- (void)registerLayout{
    
    // 注册一些自带排列的layout
    
    [self registerLayoutWithType:HJCarouselTypeLinear value:[HJCarouselLayoutLinear class]];
    
//    [self registerLayoutWithType:HJCarouselTypeTimeMachine value:[HJCarouseLayoutTimeMachine class]];
    
    [self registerLayoutWithType:HJCarouselTypeWheel value:[HJCarouselLayoutWheel class]];
    
    [self registerLayoutWithType:HJCarouselTypeCylinder value:[HJCarouselLayoutCylinder class]];
    
    [self registerLayoutWithType:HJCarouselTypeSubcontract value:[HJCarouselLayoutSubcontract class]];
    
}

- (void)registerLayoutWithType:(HJCarouselType)type value:(Class)class{
    
    NSString *key = systemLayoutKey(type);
    [self.layoutDic setValue:class forKey:key];
}

NSString * systemLayoutKey(HJCarouselType type){
    
    NSString *key = [NSString stringWithFormat:@"%@_%@",HJCarouselSystemLayoutKey,@(type)];
    return key;
}

#pragma mark Get & Set
- (NSMutableDictionary<NSString *,Class> *)layoutDic{
    if(!_layoutDic){
        _layoutDic = [NSMutableDictionary new];
    }
    return _layoutDic;
}

@end
