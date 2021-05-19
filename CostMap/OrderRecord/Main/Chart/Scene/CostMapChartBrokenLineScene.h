//
//  CostMapChartBrokenLineScene.h
//  CostMap
//
//

#import <UIKit/UIKit.h>

@class CostMapChartLineEntity;

NS_ASSUME_NONNULL_BEGIN

@interface CostMapChartBrokenLineScene : UIView

@property (copy, nonatomic) NSArray<CostMapChartLineEntity *> *entitys;

@end

NS_ASSUME_NONNULL_END
