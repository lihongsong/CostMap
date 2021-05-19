#import "CospMapThemeController.h"
#import "ASThemeManager.h"

@interface CospMapThemeController ()

@end

@implementation CospMapThemeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barTitleColor = [UIColor whiteColor];
    WEAK_SELF
    [self.pluginManager registerActionPlugin:@"setColor"
                                     handler:^(id  _Nonnull data) {
        STRONG_SELF
        [ASThemeManager changeThemeColor:data];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
