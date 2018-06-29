//
//  CInvestigationViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationViewController.h"
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface CInvestigationViewController () {
    UIView *firstTfBg;
    UIView *secondTfBg;
    UIView *thirdTfBg;
    MASConstraint *heightConstraint;
    BOOL isShowThirTF;
   // BMKLocationService* locService;
   // BMKGeoCodeSearch *searcher;
}

@end

@implementation CInvestigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = [UIColor skinColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)setUpUI {
    self.title = @"报告查询";
    
    UIScrollView *bgScrollView = [UIScrollView new];
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    [self setLelftNavigationItemWithImageName:@"public_back_01_" hidden:NO];
    UIImageView *topView = [UIImageView new];
    [bgScrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SWidth, 190));
        make.centerX.top.mas_equalTo(bgScrollView);
    }];
    topView.image = [UIImage imageNamed:@"c_investigation_banner"];

    firstTfBg = [UIView new];
    [bgScrollView addSubview:firstTfBg];
    [firstTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(bgScrollView.mas_left).mas_offset(15);
        make.right.mas_equalTo(bgScrollView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(48);
    }];

    [firstTfBg addSubview:self.firstTF];
    firstTfBg.backgroundColor = HJHexColor(0xffffff);
    firstTfBg.layer.cornerRadius = 4;
    firstTfBg.layer.borderWidth = 0.5;
    firstTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [self.firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 21));
        make.left.mas_equalTo(self->firstTfBg.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->firstTfBg.mas_right);
        make.centerY.mas_equalTo(self->firstTfBg.mas_centerY);
    }];

    secondTfBg = [UIView new];
    [bgScrollView addSubview:secondTfBg];
    secondTfBg.backgroundColor = HJHexColor(0xffffff);
    secondTfBg.layer.cornerRadius = 4;
    secondTfBg.layer.borderWidth = 0.5;
    secondTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [secondTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(self->firstTfBg);
        make.top.mas_equalTo(self->firstTfBg.mas_bottom).mas_offset(10);
    }];

    [secondTfBg addSubview:self.secondTF];
    [self.secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 21));
        make.left.mas_equalTo(self->secondTfBg.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->secondTfBg.mas_right);
        make.centerY.mas_equalTo(self->secondTfBg.mas_centerY);
    }];

    UIView *thirdTfBg = [UIView new];
    [bgScrollView addSubview:thirdTfBg];
    thirdTfBg.backgroundColor = HJHexColor(0xffffff);
    thirdTfBg.layer.cornerRadius = 4;
    thirdTfBg.layer.borderWidth = 0.5;
    thirdTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [thirdTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self->firstTfBg);
        heightConstraint = make.height.mas_equalTo(0);
        make.top.mas_equalTo(self->secondTfBg.mas_bottom).mas_offset(10);
    }];

    [thirdTfBg addSubview:self.thirdTF];
    [self.thirdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(thirdTfBg).mas_offset(15);
        make.bottom.mas_equalTo(thirdTfBg.mas_bottom).mas_offset(-15);
        make.right.mas_equalTo(thirdTfBg.mas_right);
    }];

    [bgScrollView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thirdTfBg.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(bgScrollView.mas_left).mas_offset(15);
        make.right.mas_equalTo(bgScrollView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(bgScrollView.mas_bottom).mas_offset (-50);
    }];
    self.bottomBtn.layer.cornerRadius = 4;
    [self.bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];

    [self.bottomBtn addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn.enabled = NO;
    [self.bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)setAlert:(NSString*)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:confirAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)bottomButtonAction {
}

- (void)showThridTF {
    heightConstraint.mas_equalTo(48);
    [heightConstraint install];
    isShowThirTF = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITextField *)firstTF {
    if (!_firstTF) {
        _firstTF = [UITextField new];
        _firstTF.clearButtonMode = UITextFieldViewModeAlways;
        _firstTF.delegate = (id<UITextFieldDelegate>)self;
    }
    return _firstTF;
}

- (UITextField *)secondTF {
    if (!_secondTF) {
        _secondTF = [UITextField new];
        _secondTF.clearButtonMode = UITextFieldViewModeAlways;
        _secondTF.delegate = (id<UITextFieldDelegate>)self;
    }
    return _secondTF;
}

- (UITextField *)thirdTF {
    if (!_thirdTF) {
        _thirdTF = [UITextField new];
        _thirdTF.clearButtonMode = UITextFieldViewModeAlways;
        _thirdTF.delegate = (id<UITextFieldDelegate>)self;
    }
    return _thirdTF;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton new];
    }
    return _bottomBtn;
}

- (CInvestigationRequestModel *)requestModel {
    if (!_requestModel) {
        _requestModel = [CInvestigationRequestModel new];
    }
    return _requestModel;
}

- (BOOL)string:(NSString *)string isValidWithRegex:(NSString *)regexString {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
  return [predicate evaluateWithObject:string];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if (isShowThirTF) {
    if (!StrIsEmpty(self.firstTF.text) &&
        !StrIsEmpty(self.secondTF.text) &&
        !StrIsEmpty(self.thirdTF.text)) {
      [self setBottomButtonEnable];
    } else {
      [self.bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    return;
  }
   if (!StrIsEmpty(self.firstTF.text) && !StrIsEmpty(self.secondTF.text)) {
    [self setBottomButtonEnable];
   }else {
     [self.bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
   }
}

- (void)setBottomButtonEnable {
  self.bottomBtn.enabled = YES;
  [self.bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
  [self.bottomBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_pop"] forState:UIControlStateNormal];
  [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  self.bottomBtn.layer.cornerRadius = 4;
}

#pragma - mark 初始化位置信息
/*
- (void)initLocationService {
    //初始化BMKLocationService
    self->locService = [[BMKLocationService alloc] init];
    self->locService.delegate = (id <BMKLocationServiceDelegate>) self;
    //启动LocationService
    [self->locService startUserLocationService];
    self->searcher = [[BMKGeoCodeSearch alloc] init];
    self->searcher.delegate = (id <BMKGeoCodeSearchDelegate>) self;
}
 */

#pragma - mark BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
/*
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D) {userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    [searcher reverseGeoCode:reverseGeocodeSearchOption];
}
*/
#pragma - mark BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
/*
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
      UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
      UILabel *locationLabel = [UILabel new];
      UIImageView *locationImage = [UIImageView new];
      [rightItemView addSubview:locationLabel];
      [rightItemView addSubview:locationImage];
      [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 13));
        make.centerY.mas_equalTo(rightItemView.mas_centerY);
      }];
      [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(locationImage.mas_right).mas_offset(5);
        make.right.mas_equalTo(rightItemView.mas_right);
        make.centerY.mas_equalTo(rightItemView.mas_centerY);
      }];
      locationImage.image = [UIImage imageNamed:@"navbar_location_02"];
      locationLabel.text = result.addressDetail.city;
      locationLabel.textColor = HJHexColor(0xffffff);
      locationLabel.adjustsFontSizeToFitWidth = YES;
      locationLabel.textAlignment = NSTextAlignmentRight;
      locationLabel.font = [UIFont systemFontOfSize:13];
      UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
      self.navigationItem.rightBarButtonItem = barButtonItem;
    } else {
      NSLog(@"地理位置反编码出错 ---> %@",[NSString stringWithFormat:@"%d", error]);
    }
}
 */

@end
