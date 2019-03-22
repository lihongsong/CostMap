#import <UIKit/UIKit.h>
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
#define kScaleFit ((SCREEN_WIDTH < SCREEN_HEIGHT) ? SCREEN_WIDTH / 375.0f : SCREEN_WIDTH / 667.0f)
#define kPickerHeight 216
#define kTopSceneHeight 44
#define LEFTRIGHT_MARGIN (SCREEN_WIDTH == 812 && SCREEN_HEIGHT == 375 ? 44 : 0)
#define kDefaultThemeColor RGB_HEX(0x464646, 1.0)
#define kLeftBarButtonColor RGB_HEX(0x666666, 1.0)
#define kRightBarButtonColor RGB_HEX(0x5491FC, 1.0)
@interface YosKeepAccountsCustomDatePickerBaseScene : UIView
@property(nonatomic, strong) UIView *backgroundScene;
@property(nonatomic, strong) UIView *alertScene;
@property(nonatomic, strong) UIView *topScene;
@property(nonatomic, strong) UIButton *leftBtn;
@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineScene;
- (void)initUI;
- (void)didTapBackgroundScene:(UITapGestureRecognizer *)sender;
- (void)clickLeftBtn;
- (void)clickRightBtn;
- (void)setupThemeColor:(UIColor *)themeColor;
@end
