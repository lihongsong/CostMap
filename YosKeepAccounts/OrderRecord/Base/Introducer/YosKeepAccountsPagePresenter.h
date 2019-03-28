typedef NS_ENUM(NSUInteger, PageType) {
    PageOneType,  
    PageTwoType,
    PageThreeType    
};
#import <UIKit/UIKit.h>
@interface YosKeepAccountsPagePresenter : UIViewController
@property(nonatomic,assign)PageType type;
@property (nonatomic,copy) void(^rootStartVC)(void);
@end
