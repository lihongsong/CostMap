#import "YosKeepAccountsEditBillToolBar.h"
#import "YosKeepAccountsEditBillToolBarCell.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#define kYosKeepAccountsEditBillToolBarHeight 50.0
static YosKeepAccountsEditBillToolBar *shareYosKeepAccountsEditBillToolBar;
@interface YosKeepAccountsEditBillToolBar()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionScene;
@property (nonatomic, copy) YosKeepAccountsEditBillToolBarSelectedTime selectedTimeHandler;
@property (nonatomic, copy) YosKeepAccountsEditBillToolBarSelectedClassify selectedClassifyHandler;
@property (nonatomic, weak) UIViewController *superVC;
@property (nonatomic, assign) YosKeepAccountsBillType billType;
@property (nonatomic, strong) NSDate *billTime;
@end
@implementation YosKeepAccountsEditBillToolBar
+ (instancetype)editBillToolBar {
    UINib *nib = [UINib nibWithNibName:@"YosKeepAccountsEditBillToolBar" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}
+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            billType:(YosKeepAccountsBillType)billType
                            billTime:(NSDate *)billTime
                 selectedTimeHandler:(YosKeepAccountsEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(YosKeepAccountsEditBillToolBarSelectedClassify)selectedClassifyHandler {
    if (shareYosKeepAccountsEditBillToolBar) {
        [self hideEditBillToolBar];
    }
    shareYosKeepAccountsEditBillToolBar = [YosKeepAccountsEditBillToolBar editBillToolBar];
    shareYosKeepAccountsEditBillToolBar.selectedTimeHandler = selectedTimeHandler;
    shareYosKeepAccountsEditBillToolBar.selectedClassifyHandler = selectedClassifyHandler;
    shareYosKeepAccountsEditBillToolBar.superVC = superVC;
    shareYosKeepAccountsEditBillToolBar.billTime = billTime;
    shareYosKeepAccountsEditBillToolBar.billType = billType;
    [superVC.view addSubview:shareYosKeepAccountsEditBillToolBar];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    shareYosKeepAccountsEditBillToolBar.frame = CGRectMake(0, y, width, kYosKeepAccountsEditBillToolBarHeight);;
    [[NSNotificationCenter defaultCenter] addObserver:shareYosKeepAccountsEditBillToolBar selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:shareYosKeepAccountsEditBillToolBar selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
+ (void)hideEditBillToolBar {
    if (shareYosKeepAccountsEditBillToolBar) {
        [[NSNotificationCenter defaultCenter] removeObserver:shareYosKeepAccountsEditBillToolBar];
        [shareYosKeepAccountsEditBillToolBar removeFromSuperview];
        shareYosKeepAccountsEditBillToolBar = nil;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionScene.delegate = self;
    self.collectionScene.dataSource = self;
    [self.collectionScene registerNib:[UINib nibWithNibName:@"YosKeepAccountsEditBillToolBarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YosKeepAccountsEditBillToolBarCell"];
    [self.collectionScene reloadData];
}
- (void)setBillType:(YosKeepAccountsBillType)billType {
    _billType = billType;
    NSInteger index = (NSInteger)billType;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionScene selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionRight];
}
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    NSValue *endInfo = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect endRect = endInfo.CGRectValue;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, endRect.origin.y - kYosKeepAccountsEditBillToolBarHeight, width, kYosKeepAccountsEditBillToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (void)keyboardWillHideNotification:(NSNotification *)noti {
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, y, width, kYosKeepAccountsEditBillToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (IBAction)selectTimeAction:(UIButton *)sender {
    [KeyWindow endEditing:YES];
    NSString *time = [YosKeepAccountsBillTool billTimeStringWithBillTime:self.billTime];
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"选择时间"
                                           dateType:YosKeepAccountsCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[YosKeepAccountsBillTool colorWithType:self.billType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.billTime = [YosKeepAccountsBillTool billTimeWithBillTimeString:selectValue];
                                            if (self.selectedTimeHandler) {
                                                self.selectedTimeHandler(self.billTime);
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
    YosKeepAccountsEditBillToolBarCell *cell = [collectionScene dequeueReusableCellWithReuseIdentifier:@"YosKeepAccountsEditBillToolBarCell" forIndexPath:indexPath];
    cell.billType = (YosKeepAccountsBillType)indexPath.row;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionScene didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedClassifyHandler) {
        self.billType = (YosKeepAccountsBillType)indexPath.row;
        self.selectedClassifyHandler(self.billType);
    }
}
@end
