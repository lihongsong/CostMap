@protocol YosKeepAccountsListPlaceHolderDelegate <NSObject>
@required
- (UIView *)makePlaceHolderScene;
@optional
- (BOOL)enableScrollWhenPlaceHolderSceneShowing;
@end
