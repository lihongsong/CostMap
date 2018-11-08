//
//  WYHQEditBillToolBar.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQEditBillToolBar.h"
#import "WYHQWYHQEditBillToolBarCell.h"
#import "WYHQBillTool.h"

#define kWYHQEditBillToolBarHeight 50.0

static WYHQEditBillToolBar *shareWYHQEditBillToolBar;

@interface WYHQEditBillToolBar()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, copy) WYHQEditBillToolBarSelectedTime selectedTimeHandler;
@property (nonatomic, copy) WYHQEditBillToolBarSelectedClassify selectedClassifyHandler;
@property (nonatomic, weak) UIViewController *superVC;
@property (nonatomic, copy) NSString *classify;

@end

@implementation WYHQEditBillToolBar

+ (instancetype)editBillToolBar {
    UINib *nib = [UINib nibWithNibName:@"WYHQEditBillToolBar" bundle:[NSBundle mainBundle]];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}

+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            classify:(NSString * _Nullable)classify
                 selectedTimeHandler:(WYHQEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(WYHQEditBillToolBarSelectedClassify)selectedClassifyHandler {
    if (shareWYHQEditBillToolBar) {
        [self hideEditBillToolBar];
    }
    
    shareWYHQEditBillToolBar = [WYHQEditBillToolBar editBillToolBar];
    shareWYHQEditBillToolBar.selectedTimeHandler = selectedTimeHandler;
    shareWYHQEditBillToolBar.selectedClassifyHandler = selectedClassifyHandler;
    shareWYHQEditBillToolBar.superVC = superVC;
    [superVC.view addSubview:shareWYHQEditBillToolBar];
    CGFloat y = SHeight;
    CGFloat width = SWidth;
    
    shareWYHQEditBillToolBar.frame = CGRectMake(0, y, width, kWYHQEditBillToolBarHeight);;
    
    [[NSNotificationCenter defaultCenter] addObserver:shareWYHQEditBillToolBar selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:shareWYHQEditBillToolBar selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    if (classify) {
        shareWYHQEditBillToolBar.classify = classify;
    } else {
        shareWYHQEditBillToolBar.classify = @"餐饮";
        if (selectedClassifyHandler) {
            selectedClassifyHandler(shareWYHQEditBillToolBar.classify);
        }
    }
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

- (void)setClassify:(NSString *)classify {
    _classify = classify.copy;
    if (classify) {
        NSInteger index = [WYHQBillTool indexWithClassify:classify];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionRight];
    }
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
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYHQWYHQEditBillToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYHQWYHQEditBillToolBarCell" forIndexPath:indexPath];
    
    cell.typeStr = [WYHQBillTool classifyWithIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedClassifyHandler) {
        NSString *type = [WYHQBillTool classifyWithIndex:indexPath.row];
        self.selectedClassifyHandler(type);
    }
}

@end
