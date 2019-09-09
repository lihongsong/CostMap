#import "YosKeepAccountsEditOrderPresenter.h"
#import "YosKeepAccountsEditOrderToolBar.h"
#import "YosKeepAccountsLocation.h"
#import "YosKeepAccountsOrderTool.h"
#import "YosKeepAccountsTranstionAnimationPop.h"
#import "YosKeepAccountsHomePresenter.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#import <HJCityPickerManager.h>
#import <HJAlertView.h>
#import <HJProgressHUD.h>

@interface YosKeepAccountsEditOrderPresenter () <UITextFieldDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLb;
@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *saveOrderButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollScene;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customNavHeight;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, assign) NSInteger pIndex;
@property (nonatomic, assign) NSInteger cIndex;
@property (nonatomic, assign) NSInteger dIndex;
@property (weak, nonatomic) UIView *curruntInputScene;
@property (nonatomic, assign) YosKeepAccountsOrderType orderType;
@property (nonatomic, strong) NSDate *orderTime;
@property (nonatomic, copy) NSString *orderCity;
@property (weak, nonatomic) IBOutlet UIButton *addAddressButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextf;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (assign, nonatomic) BOOL friendShipSelected;
@property (weak, nonatomic) IBOutlet UIView *friendView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTips;

@end
@implementation YosKeepAccountsEditOrderPresenter
+ (id)targetInstance {
    return [YosKeepAccountsEditOrderPresenter instance];
}
+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"EditOrder");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Record";
    [self setupUI];
    [self updateUI];
    [self addEditOrderToolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    self.addAddressButton.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[self navigationController] setDelegate:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.momeyTextField becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [YosKeepAccountsEditOrderToolBar hideEditOrderToolBar];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    self.orderTypeLb.hidden = YES;
    self.titleLabel.text = self.orderTypeLb.text;
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.orderTypeLb.hidden = NO;
    self.titleLabel.text = @"Record";
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)endEditing {
    [self.view endEditing:YES];
}
- (void)setupUI {
    self.momeyTextField.hj_maxLength = 10;
    self.noteTextField.hj_maxLength = 30;
    self.momeyTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"¥ 0.00" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5], NSFontAttributeName: [UIFont boldSystemFontOfSize:35]}];
    self.noteTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"remark"
                                                                                attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5], NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    self.momeyTextField.delegate = self;
    self.noteTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.contentView addGestureRecognizer:tap];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = UIColor.whiteColor;
    self.navigationItem.titleView = titleLabel;
    self.customNavHeight.constant = HJ_NavigationH;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)updateUI {
    if (self.orderEntity) {
        YosKeepAccountsOrderType orderType = self.orderEntity.yka_type_id.integerValue;
        self.orderType = orderType;
        NSString *wealth = [self.orderEntity.yka_wealth stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.momeyTextField.text = [NSString stringWithFormat:@"￥%@",[wealth moneyStyle]];
        self.noteTextField.text = self.orderEntity.yka_desc;
        NSTimeInterval time = self.orderEntity.yka_time.doubleValue;
        if (time > 0) {
            self.orderTime = [NSDate dateWithTimeIntervalSince1970:time];
        } else {
            self.orderTime = [NSDate date];
        }
        self.orderCity = self.orderEntity.yka_city;
        [self.cityButton setTitle:self.orderCity forState:UIControlStateNormal];
        self.deleteButton.hidden = NO;
        self.nameTF.text = self.orderEntity.yka_firend_name?:@"";
        self.phoneTextf.text = self.orderEntity.yka_firend_phone?:@"";

    } else {
        self.orderTime = [NSDate date];
        WEAK_SELF
        [[YosKeepAccountsLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            if (!StrIsEmpty(city)) {
                self.orderCity = city;
                [self.cityButton setTitle:self.orderCity forState:UIControlStateNormal];
                [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }];
        self.deleteButton.hidden = YES;
    }
    [self.timeButton setTitle:[YosKeepAccountsOrderTool orderTimeStringWithOrderTime:self.orderTime] forState:UIControlStateNormal];
    UIColor *color = [YosKeepAccountsOrderTool colorWithType:self.orderType];
    [self setContentColor:color];
    if ([self.cityButton.currentTitle isEqualToString:@"choose city"]) {
        [self.cityButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
    }
    self.orderTypeLb.text = [YosKeepAccountsOrderTool typeNameWithIndex:_orderType];
}

- (void)setOrderType:(YosKeepAccountsOrderType)orderType {
    _orderType = orderType;
    
    self.orderTypeLb.text = [YosKeepAccountsOrderTool typeNameWithIndex:orderType];
    
    if (self.orderTypeLb.hidden) {
        self.titleLabel.text = [YosKeepAccountsOrderTool typeNameWithIndex:orderType];
    }
    
    self.friendView.hidden = (orderType == YosKeepAccountsOrderTypeFriend)?NO:YES;
    
    if (orderType == YosKeepAccountsOrderTypeFriend && !self.orderEntity) {
      
    }
}
- (void)addEditOrderToolBar {
    WEAK_SELF
    [YosKeepAccountsEditOrderToolBar showEditOrderToolBarOnSuperVC:self orderType:self.orderType orderTime:self.orderTime selectedTimeHandler:^(NSDate * _Nullable orderTime) {
        STRONG_SELF
        if (orderTime) {
            self.orderTime = orderTime;
            [self.timeButton setTitle: [YosKeepAccountsOrderTool orderTimeStringWithOrderTime:orderTime] forState:UIControlStateNormal];
        }
        if (self.curruntInputScene) {
            [self.curruntInputScene becomeFirstResponder];
        }
    } selectedClassifyHandler:^(YosKeepAccountsOrderType orderType) {
        STRONG_SELF
        self.orderType = orderType;
        [UIView animateWithDuration:0.5 animations:^{
            UIColor *color = [YosKeepAccountsOrderTool colorWithType:orderType];
            [self setContentColor:color];
        }];
    }];
}
- (void)setContentColor:(UIColor *)color {
    self.view.backgroundColor = color;
    self.contentView.backgroundColor = color;
    self.contentScrollScene.backgroundColor = color;
}

- (IBAction)saveOrderButtonClick:(id)sender {
    if (StrIsEmpty(self.momeyTextField.text)) {
        [KeyWindow hj_showToastHUD:@"Please enter the bill amount."];
        return;
    }
    NSString *memeyStr = [self.momeyTextField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    memeyStr = [memeyStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *memey = [memeyStr cleanMoneyStyle];
    if (StrIsEmpty(memey)) {
        [KeyWindow hj_showToastHUD:@"Please enter the bill amount."];
        return;
    }
    if (memey.integerValue == 0) {
        [KeyWindow hj_showToastHUD:@"Please enter the bill amount."];
        return;
    }
    [self.view endEditing:YES];
    
    YosKeepAccountsOrderEntity *model = self.orderEntity;
    BOOL newOrder = NO;
    if (!model) {
        model = [YosKeepAccountsOrderEntity new];
        newOrder = YES;
    }
    model.yka_wealth = [NSString stringWithFormat:@"-%@", memey];
    model.yka_type_name = [YosKeepAccountsOrderTool typeNameWithIndex:self.orderType];
    model.yka_type_id = @(self.orderType).stringValue;
    model.yka_year = @(self.orderTime.hj_year).stringValue;
    model.yka_month = @(self.orderTime.hj_month).stringValue;
    model.yka_day = @(self.orderTime.hj_day).stringValue;
    model.yka_time = @(self.orderTime.timeIntervalSince1970).stringValue;
    model.yka_desc = self.noteTextField.text;
    model.yka_city = self.orderCity ?: @"";
    model.yka_username = @"nobody";
    model.yka_firend_name = self.nameTF.text?:@"";
    model.yka_firend_phone = self.phoneTextf.text?:@"";

    if (newOrder) {
        [[YosKeepAccountsSQLManager share] insertData:model tableName:kSQLTableName];
    } else {
        [[YosKeepAccountsSQLManager share] updateData:model tableName:kSQLTableName];
    }
    [self saveOrderDone];
}
- (void)setOrderTypeStr:(NSString *)orderTypeStr {
    _orderTypeStr = orderTypeStr;
    self.orderType = orderTypeStr.integerValue;
}
- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deletButtonClick:(id)sender {
    if (self.orderEntity) {
        [self.view endEditing:YES];
        WEAK_SELF
        HJAlertView *alertScene = [[HJAlertView alloc] initWithTitle:@"Warm Prompt" message:@"Are you sure you want to delete the bill?" cancelBlock:^{
        } confirmBlock:^{
            STRONG_SELF
            [[YosKeepAccountsSQLManager share] deleteData:kSQLTableName yka_id:self.orderEntity.yka_id];
            [KeyWindow hj_showToastHUD:@"The bill has been deleted."];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        alertScene.confirmColor = YosKeepAccountsThemeColor;
        [alertScene show];
    }
}

- (IBAction)selectOrderTime:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputScene = nil;
    }
    NSString *time = [YosKeepAccountsOrderTool orderTimeStringWithOrderTime:self.orderTime];
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"Choose Time"
                                           dateType:YosKeepAccountsCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[YosKeepAccountsOrderTool colorWithType:self.orderType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.orderTime = [YosKeepAccountsOrderTool orderTimeWithOrderTimeString:selectValue];
                                            [self.timeButton setTitle:selectValue forState:UIControlStateNormal];
                                            if (self.curruntInputScene) {
                                                [self.curruntInputScene becomeFirstResponder];
                                            }
                                        }
                                        cancelBlock:^{
                                            STRONG_SELF
                                            if (self.curruntInputScene) {
                                                [self.curruntInputScene becomeFirstResponder];
                                            }
                                        }];
}
- (IBAction)selectOrderCity:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputScene = nil;
    }
    HJCityPickerManager *cityPicker = [HJCityPickerManager cityPickerManagerWithTitle:@"choose city" type:HJCityPickerTypeAll regionList:[HJCPMLocalData provinceArray] cityPickSelected:^(HJCPMProvinceModel * _Nullable selectedProvinceEntity, HJCPMCityModel * _Nullable selectedCityEntity, HJCPMDistrictModel * _Nullable selectedDistrictEntity) {
        self.orderCity = selectedDistrictEntity.name;
        [self.cityButton setTitle:self.orderCity forState:UIControlStateNormal];
        [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pIndex = selectedProvinceEntity.index;
        self.cIndex = selectedCityEntity.index;
        self.dIndex = selectedDistrictEntity.index;
    }];
    UIColor *color = [YosKeepAccountsOrderTool colorWithType:self.orderType];
    [cityPicker.commitBtn setTitleColor:color forState:UIControlStateNormal];
    cityPicker.titleLabel.textColor = color;
    cityPicker.pickerViewRowSelectedTextColor = color;
    [cityPicker selecteCityWithProvinceIndex:self.pIndex cityIndex:self.cIndex districtIndex:self.dIndex animated:YES];
    [cityPicker showPickerFromController:self];
}
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    CGFloat offset = (SHeight/2) - 178 - HJ_NavigationH;
    CGFloat navHeight = HJ_NavigationH;
    if (offset < navHeight) {
        offset = navHeight;
    }
    [self.contentScrollScene setContentInset:UIEdgeInsetsMake(0 - offset, 0, 0, 0)];
}
- (void)keyboardWillHideNotification:(NSNotification *)noti {
    [self.contentScrollScene setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)saveOrderDone {
    UIColor *color = [YosKeepAccountsOrderTool colorWithType:self.orderType];
    UIImage *image = [UIImage imageNamed:[YosKeepAccountsOrderTool typePressedImage:self.orderType]];
    [self.saveOrderButton setTitle:@"" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.momeyTextField.textColor = color;
        self.noteTextField.textColor = color;
        [self.timeButton setTitleColor:color forState:UIControlStateNormal];
        self.saveOrderButton.layer.borderColor = color.CGColor;
        [self.saveOrderButton setImage:image forState:UIControlStateNormal];
        self.backButton.tintColor = color;
        self.deleteButton.tintColor = color;
        self.titleLabel.textColor = color;
        self.orderTypeLb.textColor = color;
        if (self.orderCity) {
            [self.cityButton setTitleColor:color forState:UIControlStateNormal];
        }
        [self setContentColor:UIColor.whiteColor];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.momeyTextField) {
        NSString *tfString = textField.text;
        if (!StrIsEmpty(tfString)) {
            if ([tfString containsString:@"￥"]) {
                tfString = [tfString stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                tfString = [tfString stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            tfString = [NSString stringWithFormat:@"￥%@",[tfString moneyStyle]];
            textField.text = tfString;
        } else {
            self.momeyTextField.text = @"";
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.curruntInputScene = textField;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([fromVC isKindOfClass:[YosKeepAccountsEditOrderPresenter class]] &&
        ([toVC isKindOfClass:[YosKeepAccountsHomePresenter class]]) &&
        operation == UINavigationControllerOperationPop) {
        return [YosKeepAccountsTranstionAnimationPop new];
    } else {
        return nil;
    }
}

@end
