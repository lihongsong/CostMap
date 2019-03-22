#import "YosKeepAccountsEditOrderToolBar.h"
#import "YosKeepAccountsEditOrderToolBarCell.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#define kYosKeepAccountsEditOrderToolBarHeight 50.0
static YosKeepAccountsEditOrderToolBar *shareYosKeepAccountsEditOrderToolBar;
@interface YosKeepAccountsEditOrderToolBar()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionScene;
@property (nonatomic, copy) YosKeepAccountsEditOrderToolBarSelectedTime selectedTimeHandler;
@property (nonatomic, copy) YosKeepAccountsEditOrderToolBarSelectedClassify selectedClassifyHandler;
@property (nonatomic, weak) UIViewController *superVC;
@property (nonatomic, assign) YosKeepAccountsOrderType orderType;
@property (nonatomic, strong) NSDate *orderTime;
@end
@implementation YosKeepAccountsEditOrderToolBar
+ (instancetype)editOrderToolBar {
    UINib *nib = [UINib nibWithNibName:@"YosKeepAccountsEditOrderToolBar" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}
+ (void)showEditOrderToolBarOnSuperVC:(UIViewController *)superVC
                            orderType:(YosKeepAccountsOrderType)orderType
                            orderTime:(NSDate *)orderTime
                 selectedTimeHandler:(YosKeepAccountsEditOrderToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(YosKeepAccountsEditOrderToolBarSelectedClassify)selectedClassifyHandler {
    if (shareYosKeepAccountsEditOrderToolBar) {
        [self hideEditOrderToolBar];
    }
    shareYosKeepAccountsEditOrderToolBar = [YosKeepAccountsEditOrderToolBar editOrderToolBar];
    shareYosKeepAccountsEditOrderToolBar.selectedTimeHandler = selectedTimeHandler;
    shareYosKeepAccountsEditOrderToolBar.selectedClassifyHandler = selectedClassifyHandler;
    shareYosKeepAccountsEditOrderToolBar.superVC = superVC;
    shareYosKeepAccountsEditOrderToolBar.orderTime = orderTime;
    shareYosKeepAccountsEditOrderToolBar.orderType = orderType;
    [superVC.view addSubview:shareYosKeepAccountsEditOrderToolBar];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    shareYosKeepAccountsEditOrderToolBar.frame = CGRectMake(0, y, width, kYosKeepAccountsEditOrderToolBarHeight);;
    [[NSNotificationCenter defaultCenter] addObserver:shareYosKeepAccountsEditOrderToolBar selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:shareYosKeepAccountsEditOrderToolBar selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
+ (void)hideEditOrderToolBar {
    if (shareYosKeepAccountsEditOrderToolBar) {
        [[NSNotificationCenter defaultCenter] removeObserver:shareYosKeepAccountsEditOrderToolBar];
        [shareYosKeepAccountsEditOrderToolBar removeFromSuperview];
        shareYosKeepAccountsEditOrderToolBar = nil;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionScene.delegate = self;
    self.collectionScene.dataSource = self;
    [self.collectionScene registerNib:[UINib nibWithNibName:@"YosKeepAccountsEditOrderToolBarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YosKeepAccountsEditOrderToolBarCell"];
    [self.collectionScene reloadData];
}
- (void)setOrderType:(YosKeepAccountsOrderType)orderType {
    _orderType = orderType;
    NSInteger index = (NSInteger)orderType;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionScene selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionRight];
}
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    NSValue *endInfo = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect endRect = endInfo.CGRectValue;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, endRect.origin.y - kYosKeepAccountsEditOrderToolBarHeight, width, kYosKeepAccountsEditOrderToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (void)keyboardWillHideNotification:(NSNotification *)noti {
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, y, width, kYosKeepAccountsEditOrderToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (IBAction)selectTimeAction:(UIButton *)sender {
    [KeyWindow endEditing:YES];
    NSString *time = [YosKeepAccountsOrderTool orderTimeStringWithOrderTime:self.orderTime];
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"选择时间"
                                           dateType:YosKeepAccountsCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[YosKeepAccountsOrderTool colorWithType:self.orderType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.orderTime = [YosKeepAccountsOrderTool orderTimeWithOrderTimeString:selectValue];
                                            if (self.selectedTimeHandler) {
                                                self.selectedTimeHandler(self.orderTime);
                                            }
                                        }
                                        cancelBlock:^{
                                            STRONG_SELF
                                            if (self.selectedTimeHandler) {
                                                self.selectedTimeHandler(nil);
                                            }
                                        }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionScene numberOfItemsInSection:(NSInteger)section {
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionScene cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YosKeepAccountsEditOrderToolBarCell *cell = [collectionScene dequeueReusableCellWithReuseIdentifier:@"YosKeepAccountsEditOrderToolBarCell" forIndexPath:indexPath];
    cell.orderType = (YosKeepAccountsOrderType)indexPath.row;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionScene didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedClassifyHandler) {
        self.orderType = (YosKeepAccountsOrderType)indexPath.row;
        self.selectedClassifyHandler(self.orderType);
    }
}
@end
