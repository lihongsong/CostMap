#import "YosKeepAccountsPagePresenter.h"
#import "YosKeepAccountsControl.h"
@interface YosKeepAccountsPagePresenter ()
@property (strong, nonatomic)UIImageView *pageImageScene;
@property (strong, nonatomic)UIButton *startButton;
@end
@implementation YosKeepAccountsPagePresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageImageScene];
}
-(UIImageView *)pageImageScene
{
    if (_pageImageScene == nil) {
        _pageImageScene = [YosKeepAccountsControl yka_createImageSceneFrame:CGRectMake(0, 0, SWidth, SHeight) imageName:@"yka_Introducer_01"];
    }
    return _pageImageScene;
}
-(UIButton *)startButton
{
    if (_startButton == nil) {
        _startButton = [YosKeepAccountsControl yka_createButtonWithFrame:CGRectMake(SWidth/2.0 - 90,SHeight - 100 - 40, 180, 40) target:self SEL:@selector(startButtonClick) title:@"开启旅程"];
        [_startButton setImage:[UIImage imageNamed:@"introduce_LaunchImage_Button"] forState:UIControlStateNormal];
        [_startButton setImage:[UIImage imageNamed:@"introduce_LaunchImage_Button"] forState:UIControlStateHighlighted];
    }
    return _startButton;
}
-(void)setType:(PageType)type{
    switch (type) {
        case PageOneType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_01_iphonex"];
            }else{
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_01"];
            }
        }
            break;
        case PageTwoType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_02_iphonex"];
            }else{
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_02"];
            }
        }
            break;
        case PageThreeType:
        {
            if ([UIDevice hj_isIPhoneXSizedDevice]) {
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_03_iphonex"];
            }else{
                 self.pageImageScene.image = [UIImage imageNamed:@"yka_Introducer_03"];
            }
            [self.view addSubview:self.startButton];
            if ([UIDevice hj_isIPhone6SizedDevice]) {
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 100 - 20, 180, 40);
            }else if ([UIDevice hj_isIPhone6PlusSizedDevice]){
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 40 - 80, 180, 40);
            }else{
                self.startButton.frame = CGRectMake(SWidth/2.0 - 90,SHeight - 40 - 50, 180, 40);
            }
        }
            break;
        default:
            break;
    }
}
- (void)startButtonClick{
    self.rootStartVC();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
