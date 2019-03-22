#import "YosKeepAccountsAboutPresenter.h"
@interface YosKeepAccountsAboutPresenter ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end
@implementation YosKeepAccountsAboutPresenter
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"版本: %@", app_Version];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end
