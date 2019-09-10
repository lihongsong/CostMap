#import "CostMapEditOrderToolBar.h"
#import "CostMapEditOrderToolBarCell.h"
#import "CostMapCustomDatePickerScene.h"
#define kCostMapEditOrderToolBarHeight 50.0
static CostMapEditOrderToolBar *shareCostMapEditOrderToolBar;
@interface CostMapEditOrderToolBar()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionScene;
@property (nonatomic, copy) CostMapEditOrderToolBarSelectedTime selectedTimeHandler;
@property (nonatomic, copy) CostMapEditOrderToolBarSelectedClassify selectedClassifyHandler;
@property (nonatomic, weak) UIViewController *superVC;
@property (nonatomic, assign) CostMapOrderType orderType;
@property (nonatomic, strong) NSDate *orderTime;
@end
@implementation CostMapEditOrderToolBar
+ (instancetype)editOrderToolBar {
    UINib *nib = [UINib nibWithNibName:@"CostMapEditOrderToolBar" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}
+ (void)showEditOrderToolBarOnSuperVC:(UIViewController *)superVC
                            orderType:(CostMapOrderType)orderType
                            orderTime:(NSDate *)orderTime
                 selectedTimeHandler:(CostMapEditOrderToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(CostMapEditOrderToolBarSelectedClassify)selectedClassifyHandler {
    if (shareCostMapEditOrderToolBar) {
        [self hideEditOrderToolBar];
    }
    shareCostMapEditOrderToolBar = [CostMapEditOrderToolBar editOrderToolBar];
    shareCostMapEditOrderToolBar.selectedTimeHandler = selectedTimeHandler;
    shareCostMapEditOrderToolBar.selectedClassifyHandler = selectedClassifyHandler;
    shareCostMapEditOrderToolBar.superVC = superVC;
    shareCostMapEditOrderToolBar.orderTime = orderTime;
    shareCostMapEditOrderToolBar.orderType = orderType;
    [superVC.view addSubview:shareCostMapEditOrderToolBar];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    shareCostMapEditOrderToolBar.frame = CGRectMake(0, y, width, kCostMapEditOrderToolBarHeight);;
    [[NSNotificationCenter defaultCenter] addObserver:shareCostMapEditOrderToolBar selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:shareCostMapEditOrderToolBar selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
+ (void)hideEditOrderToolBar {
    if (shareCostMapEditOrderToolBar) {
        [[NSNotificationCenter defaultCenter] removeObserver:shareCostMapEditOrderToolBar];
        [shareCostMapEditOrderToolBar removeFromSuperview];
        shareCostMapEditOrderToolBar = nil;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionScene.delegate = self;
    self.collectionScene.dataSource = self;
    [self.collectionScene registerNib:[UINib nibWithNibName:@"CostMapEditOrderToolBarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CostMapEditOrderToolBarCell"];
    [self.collectionScene reloadData];
}
- (void)setOrderType:(CostMapOrderType)orderType {
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
    CGRect frame = CGRectMake(0, endRect.origin.y - kCostMapEditOrderToolBarHeight, width, kCostMapEditOrderToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (void)keyboardWillHideNotification:(NSNotification *)noti {
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, y, width, kCostMapEditOrderToolBarHeight);
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}
- (IBAction)selectTimeAction:(UIButton *)sender {
    [KeyWindow endEditing:YES];
    NSString *time = [CostMapOrderTool orderTimeStringWithOrderTime:self.orderTime];
    WEAK_SELF
    [CostMapCustomDatePickerScene showDatePickerWithTitle:@"Select Time"
                                           dateType:CostMapCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[CostMapOrderTool colorWithType:self.orderType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.orderTime = [CostMapOrderTool orderTimeWithOrderTimeString:selectValue];
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
    CostMapEditOrderToolBarCell *cell = [collectionScene dequeueReusableCellWithReuseIdentifier:@"CostMapEditOrderToolBarCell" forIndexPath:indexPath];
    cell.orderType = (CostMapOrderType)indexPath.row;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionScene didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedClassifyHandler) {
        self.orderType = (CostMapOrderType)indexPath.row;
        self.selectedClassifyHandler(self.orderType);
    }
}
@end
