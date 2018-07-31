//
//  MineViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/9.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineTopHeaderView.h"
#import "MineNoticeView.h"
#import "MineFooterView.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "CInvestigationOneViewController.h"
#import "CInvestigationProgressViewController.h"
#import "LoginViewController.h"
#import "LoginInfoModel.h"

#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource, MineTableViewCellDelegate,QBMineHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> {
    CGFloat footerHeight;
}
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) MineTopHeaderView *topHeaderView;
@property(nonatomic, strong) NSArray *showDataArray;

@end

@implementation MineViewController

#pragma - mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    LoginUserInfoModel *loginModel = [LoginUserInfoModel cachedLoginModel];
    if (loginModel) {
        [self updateLoginStatus:YES];
    } else {
        [self updateLoginStatus:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   [self.navigationController setNavigationBarHidden:false animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma - mark UI布局

- (void)setUpUI {
    WeakObj(self);
    footerHeight = 0.00001f;
    self.topHeaderView = [MineTopHeaderView new];
  self.topHeaderView.delegate = self;
    [self.view addSubview:self.topHeaderView];
    self.topHeaderView.loginBlock = ^{
        StrongObj(self);
        [self login];
    };
    [self.topHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SWidth, 160));
    }];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.topHeaderView.mas_bottom);
        make.left.right.bottom.centerX.mas_equalTo(self.view);
    }];
}

#pragma - mark 更新登录状态

- (void)updateLoginStatus:(BOOL)isLogin {
    self.topHeaderView.isUserLogin = isLogin;
    footerHeight = isLogin ? 70.0f : 0.00001f;
    [self.tableview reloadData];
}

#pragma - mark setter && getter

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = HJHexColor(0xF2F2F2);
    }
    return _tableview;
}

#pragma - mark UITableViewDataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.0001f;
            break;
        case 1:
            return 36.5;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.00001f;
            break;
        case 1:
            return footerHeight;
            break;
        default:
            return 0.00001f;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineTableViewCell"];
    }
    cell.delegate = self;
    [cell updateCellInfo:self.showDataArray[indexPath.section][indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        MineNoticeView *noticeView = [MineNoticeView new];
        return noticeView;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: {
                LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
                if (!userInfo) {
                    LoginViewController *loginvc = [LoginViewController new];
                    loginvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:loginvc animated:YES];
                } else {
                    FeedbackViewController *vc = [FeedbackViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
                break;
            case 1: {
                AboutUsViewController *vc = [AboutUsViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LoginUserInfoModel *userLoginModel = [LoginUserInfoModel cachedLoginModel];
    if (section == 1 && userLoginModel != nil) {
        MineFooterView *footerView = [MineFooterView new];
        WeakObj(self);
        footerView.tapLogout = ^() {
            StrongObj(self);
            [self logOut];
        };
        return footerView;
    } else {   
        return 0;
    }
}


- (NSArray *)showDataArray {
    return @[@[@{
            @"logo": @"mine_fingerprint",
            @"itemName": @"安全访问",
            @"celltType": @2,
    }],
            @[@{
                    @"logo": @"mine_feedback",
                    @"itemName": @"意见反馈",
            },
                    @{
                            @"logo": @"mine_about",
                            @"itemName": @"关于我们",
                    }]];
}

#pragma - mark MineTableViewCellDelegate

- (void)MineTableViewCellDidTapSwitch:(UISwitch *)switchView {
    BOOL isOn = switchView.on;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isOn forKey:@"kCachedTouchIdStatus"];
    [userDefault synchronize];
}

#pragma - mark 退出登录

- (void)logOut {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"是否要退出当前帐号？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *_Nonnull action) {
                                                        NSLog(@"点击退出了");
                                                        [LoginUserInfoModel cacheLoginModel:nil];
                                                        [self updateLoginStatus:NO];
                                                    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma - mark 登录回调

- (void)login {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark header delegate
- (void)mineHeaderClick{
  if (self.topHeaderView.isUserLogin) {
    UIActionSheet * sheet = [[UIActionSheet alloc]init];
    sheet.tag = 10001;
    sheet.delegate = self;
    [sheet addButtonWithTitle:@"拍照上传"];
    [sheet addButtonWithTitle:@"从手机相册获取"];
    [sheet addButtonWithTitle:@"取消"];
    [sheet showInView:self.view];
  }else{
    [self login];
  }
  
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
  if (actionSheet.tag == 10001 && buttonIndex == 0) {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
      AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
      if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
          authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
      {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相机\"选项中，允许花钱无忧访问你的手机相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          // 无权限 引导去开启
          NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
          if ( [UIDevice currentDevice].systemVersion.integerValue >= 10.0) {
              if (@available(iOS 10.0, *)) {
                  [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                      
                  }];
              } 
          }else{
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
              [[UIApplication sharedApplication]openURL:url];
            }
          }
        }];
        [alert addAction:ok];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
        }];
        [alert addAction:cancle];
        [self presentViewController:alert animated:true completion:^{
          
        }];
      }else{
        UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
      }
    }else{
      
      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备相机不可使用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      [alert show];
      return;
    }
  }else if (actionSheet.tag == 10001 && buttonIndex == 1){
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
      ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
      
      if (author ==ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设备的\"设置-隐私-相册\"选项中，允许花钱无忧访问你的手机相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          // 无权限 引导去开启
          NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
              if (@available(iOS 10.0, *)) {
                  [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                      
                  }];
          }else{
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
              [[UIApplication sharedApplication]openURL:url];
            }
          }
        }];
        [alert addAction:ok];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
        }];
        [alert addAction:cancle];
        [self presentViewController:alert animated:true completion:^{
          
        }];
      }else{
        UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
      }
      return ;
    }else{
      UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备相册不可使用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      [alert show];
      return;
    }
  }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
  UIImage *image;
  if (picker.allowsEditing) {
    image = info[UIImagePickerControllerEditedImage];
  }else{
    image = info[UIImagePickerControllerOriginalImage];
  }
  [self.topHeaderView.headButton setImage:image forState:UIControlStateNormal];
  NSData *data = UIImageJPEGRepresentation(image, 1.0);
  SetUserDefault(data, @"mineHeader");
  [picker dismissViewControllerAnimated:YES completion:nil];
  
}


@end
