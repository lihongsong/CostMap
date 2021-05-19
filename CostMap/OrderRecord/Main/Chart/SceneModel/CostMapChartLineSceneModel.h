//
//  CostMapChartLineSceneModel.h
//  CostMap
//
//

#import <Foundation/Foundation.h>

@class CostMapChartLineEntity;

@class RACSubject;

typedef NS_ENUM(NSInteger, CostMapChartType) {
    CostMapChartUnknow = 0,
    CostMapChartDay = 1,
    CostMapChartMonth = 2,
    CostMapChartYear = 3,
};

NS_ASSUME_NONNULL_BEGIN

@interface CostMapChartLineSceneModel : NSObject

@property (assign, nonatomic) CGFloat totalAccount;

@property (assign, nonatomic) CostMapChartType type;

- (RACSubject *)yka_requestLineDataWithType:(CostMapChartType)type;

@end

NS_ASSUME_NONNULL_END
