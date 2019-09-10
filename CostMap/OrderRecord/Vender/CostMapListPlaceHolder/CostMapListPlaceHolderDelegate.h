@protocol CostMapListPlaceHolderDelegate <NSObject>
@required
- (UIView *)makePlaceHolderScene;
@optional
- (BOOL)enableScrollWhenPlaceHolderSceneShowing;
@end
