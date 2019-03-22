#import <UIKit/UIKit.h>
@class YosKeepAccountsScrollDisplayPresenter;
@protocol YosKeepAccountsScrollDisplayPresenterDelegate <NSObject>
@optional
- (void)scrollDisplayPresenter:(YosKeepAccountsScrollDisplayPresenter *)scrollDisplayPresenter didSelectedIndex:(NSInteger)index;
- (void)scrollDisplayPresenter:(YosKeepAccountsScrollDisplayPresenter *)scrollDisplayPresenter currentIndex:(NSInteger)index;
@end
@interface YosKeepAccountsScrollDisplayPresenter : UIViewController
@property(nonatomic,readonly) NSArray *controllers;
@property(nonatomic,readonly) UIPageViewController *pageVC;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic, strong) id<YosKeepAccountsScrollDisplayPresenterDelegate> delegate;
- (instancetype)initWithControllers:(NSArray *)controllers;
@end
