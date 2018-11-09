//
//  WYHQEditBillToolBar.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQEditBillToolBar.h"
#import "WYHQWYHQEditBillToolBarCell.h"
#import "CLCustomDatePickerView.h"

#define kWYHQEditBillToolBarHeight 50.0

static WYHQEditBillToolBar *shareWYHQEditBillToolBar;

@interface WYHQEditBillToolBar()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, copy) WYHQEditBillToolBarSelectedTime selectedTimeHandler;
@property (nonatomic, copy) WYHQEditBillToolBarSelectedClassify selectedClassifyHandler;
@property (nonatomic, weak) UIViewController *superVC;
@property (nonatomic, assign) WYHQBillType billType;
@property (nonatomic, strong) NSDate *billTime;

@end

@implementation WYHQEditBillToolBar

+ (instancetype)editBillToolBar {
    UINib *nib = [UINib nibWithNibName:@"WYHQEditBillToolBar" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}

+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            billType:(WYHQBillType)billType
                            billTime:(NSDate *)billTime
                 selectedTimeHandler:(WYHQEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(WYHQEditBillToolBarSelectedClassify)selectedClassifyHandler {
    if (shareWYHQEditBillToolBar) {
        [self hideEditBillToolBar];
    }
    
    shareWYHQEditBillToolBar = [WYHQEditBillToolBar editBillToolBar];
    shareWYHQEditBillToolBar.selectedTimeHandler = selectedTimeHandler;
    shareWYHQEditBillToolBar.selectedClassifyHandler = selectedClassifyHandler;
    shareWYHQEditBillToolBar.superVC = superVC;
    shareWYHQEditBillToolBar.billTime = billTime;
    shareWYHQEditBillToolBar.billType = billType;
    [superVC.view addSubview:shareWYHQEditBillToolBar];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    
    shareWYHQEditBillToolBar.frame = CGRectMake(0, y, width, kWYHQEditBillToolBarHeight);;
    
    [[NSNotificationCenter defaultCenter] addObserver:shareWYHQEditBillToolBar selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:shareWYHQEditBillToolBar selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)hideEditBillToolBar {
    if (shareWYHQEditBillToolBar) {
        [[NSNotificationCenter defaultCenter] removeObserver:shareWYHQEditBillToolBar];
        [shareWYHQEditBillToolBar removeFromSuperview];
        shareWYHQEditBillToolBar = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WYHQWYHQEditBillToolBarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WYHQWYHQEditBillToolBarCell"];
    
    [self.collectionView reloadData];
}

- (void)setBillType:(WYHQBillType)billType {
    _billType = billType;
    NSInteger index = (NSInteger)billType;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionRight];
}

- (void)keyboardWillShowNotification:(NSNotification *)noti {
    NSValue *endInfo = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect endRect = endInfo.CGRectValue;
    
    CGFloat width = SWidth;
    
    CGRect frame = CGRectMake(0, endRect.origin.y - kWYHQEditBillToolBarHeight - HJ_NavigationH, width, kWYHQEditBillToolBarHeight);
    
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    NSNumber *animationDuration = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    CGRect frame = CGRectMake(0, y, width, kWYHQEditBillToolBarHeight);
    
    [UIView animateWithDuration:animationDuration.doubleValue animations:^{
        self.frame = frame;
    }];
    
}

- (IBAction)selectTimeAction:(UIButton *)sender {
    [KeyWindow endEditing:YES];
    
    NSString *time = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
    WEAK_SELF
    [CLCustomDatePickerView showDatePickerWithTitle:@"选择时间"
                                           dateType:CLCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:nil
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.billTime = [WYHQBillTool billTimeWithBillTimeString:selectValue];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYHQWYHQEditBillToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYHQWYHQEditBillToolBarCell" forIndexPath:indexPath];
    
    cell.billType = (WYHQBillType)indexPath.row;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedClassifyHandler) {
        self.selectedClassifyHandler((WYHQBillType)indexPath.row);
    }
}

@end
