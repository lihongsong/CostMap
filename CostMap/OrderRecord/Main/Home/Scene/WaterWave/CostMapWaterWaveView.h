//
//  SHWWaterView.h
//
//  Created by on 16/9/8.//

#import <UIKit/UIKit.h>
#import "CostMapWaterWeakProxy.h"

@interface CostMapWaterWaveView : UIView

@property(nonatomic, assign) CGFloat firstWaveSpeed;
@property(nonatomic, assign) CGFloat secondWaveSpeed;

@property(nonatomic, assign) CGFloat firstWaveHeight;
@property(nonatomic, assign) CGFloat secondWaveHeight;

@property(nonatomic, strong) UIColor *firstWaveColor;
@property(nonatomic, strong) UIColor *secondWaveColor;

@property(nonatomic, assign) CGFloat progress;

@property(nonatomic, assign) NSUInteger waterWaveNum;

@property(nonatomic, assign) BOOL showSecondWave;

@property(nonatomic, assign, readonly, getter = isAnimationing) BOOL animationing;

- (void)startWaveAnimate;

- (void)stopWaveAnimate;

@end
