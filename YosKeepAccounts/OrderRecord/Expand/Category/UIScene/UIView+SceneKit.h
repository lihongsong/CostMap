#import <UIKit/UIKit.h>
@interface UIView (SceneKit)
@property(nonatomic, readonly) CGFloat minX;
@property(nonatomic, readonly) CGFloat midX;
@property(nonatomic, readonly) CGFloat maxX;
@property(nonatomic, readonly) CGFloat minY;
@property(nonatomic, readonly) CGFloat midY;
@property(nonatomic, readonly) CGFloat maxY;
@property(nonatomic, readonly) CGFloat width;
@property(nonatomic, readonly) CGFloat height;
@property(nonatomic, readonly) CGFloat halfWidth;
@property(nonatomic, readonly) CGFloat halfHeight;
@property(nonatomic, readonly) CGPoint internalCenter;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGPoint origin;
- (CGRect)setHeight:(CGFloat)height;
- (CGRect)setMinX:(CGFloat)minX;
- (CGRect)setMidX:(CGFloat)midX;
- (CGRect)setMaxX:(CGFloat)maxX;
- (CGRect)setMinY:(CGFloat)minY;
- (CGRect)setMaxY:(CGFloat)maxY;
- (CGRect)setMidY:(CGFloat)midY;
- (CGRect)setWidth:(CGFloat)width;
- (CGRect)setMinX:(CGFloat)minX minY:(CGFloat)minY;
- (CGRect)setMinX:(CGFloat)minX midY:(CGFloat)midY;
- (CGRect)setMinX:(CGFloat)minX maxY:(CGFloat)maxY;
- (CGRect)setMinX:(CGFloat)minX maxX:(CGFloat)maxX;
- (CGRect)setMinX:(CGFloat)minX width:(CGFloat)width;
- (CGRect)setMidX:(CGFloat)midX minY:(CGFloat)minY;
- (CGRect)setMidX:(CGFloat)midX maxY:(CGFloat)maxY;
- (CGRect)setMaxX:(CGFloat)maxX minY:(CGFloat)minY;
- (CGRect)setMaxX:(CGFloat)maxX midY:(CGFloat)midY;
- (CGRect)setMaxX:(CGFloat)maxX maxY:(CGFloat)maxY;
- (CGRect)setMinY:(CGFloat)minY maxY:(CGFloat)maxY;
- (CGRect)setMinY:(CGFloat)minY height:(CGFloat)height;
typedef enum {
    RKSceneArrangeAlignmentLeft,
    RKSceneArrangeAlignmentRight,
    RKSceneArrangeAlignmentTop,
    RKSceneArrangeAlignmentBottom,
    RKSceneArrangeAlignmentMid 
} RKSceneArrangeAlignment;
typedef enum {
    RKSceneArrangeDirectionRight, 
    RKSceneArrangeDirectionLeft,
    RKSceneArrangeDirectionBottom, 
    RKSceneArrangeDirectionTop
} RKSceneArrangeDirection;
+ (void)horizontalArrangeScenes:(NSArray*)views distances:(NSArray*)distances alignmentType:(RKSceneArrangeAlignment)alignment direction:(RKSceneArrangeDirection)direction;
- (void)addBottomScene:(UIView *)bottomScene;
- (UIView *)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height;
- (UIView *)addBottomLineInSceneWithColor:(UIColor *)color height:(CGFloat)height;
- (UIView *)addTopLineInSceneWithColor:(UIColor *)color height:(CGFloat)height;
- (void)addTopScene:(UIView *)topScene;
- (UIView *)addVerticalCenterLineInSceneWithColor:(UIColor *)color size:(CGSize)size;
- (void)showAlertWithContent:(NSString *)content;
- (void)addBorderLineAndShadow;
@end
extern CGRect CGRectMakeLargeByRect(CGRect, UIEdgeInsets);
extern CGRect CGRectMakeLargeByPoint(CGPoint, UIEdgeInsets);
extern UIEdgeInsets UIEdgeInsetsMakeAll(CGFloat);
