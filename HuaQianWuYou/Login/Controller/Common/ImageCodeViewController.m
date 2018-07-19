//
//  ImageCodeViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ImageCodeViewController.h"
#import "ImageCodePopView.h"
#import "ImageCodeModel.h"
#import "ImageCodeModel+Service.h"
@interface ImageCodeViewController ()

/* <#cintent#> */
@property (nonatomic, strong) ImageCodePopView  *codeView;



@end

@implementation ImageCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:self.codeView];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.mas_equalTo(48);
        make.right.mas_equalTo(-48);
        make.height.mas_equalTo(self.codeView.mas_width).multipliedBy(0.63);
    }];
    self.codeView.base64ImageStr = self.imageStr;
    self.codeView.codeImageVIew.userInteractionEnabled = YES;
    [self.codeView.canceButton addTarget:self action:@selector(canceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.codeView.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.codeView.codeImageVIew addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadImageCode)]];
    // Do any additional setup after loading the view.
}

//刷新图片
- (void)reloadImageCode{
    
    [KeyWindow ln_showLoadingHUD];
    [ImageCodeModel requsetImageCodeCompletion:^(ImageCodeModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                  message:error.hqwy_errorMessage];
            return;
        } else {
            [KeyWindow ln_hideProgressHUD];
        }
        if (result.outputImage) {
            self.codeView.base64ImageStr = result.outputImage;
            self.codeView.imageCodeInputLable.text = nil;
            self.serialNumber = result.serialNumber;
        }
    }];
 }

- (void)canceAction{
    [self eventId:HQWY_Login_ImageCodeCheck_click];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)sureAction{
    [self eventId:HQWY_Login_ImageCode_click];
    if (self.codeView.imageCodeInputLable.text.length == 0) {
        [KeyWindow ln_showToastHUD:@"请输入图形验证码"];
        return;
    }
    if (self.block) {
        self.block(self.codeView.imageCodeInputLable.text,self.serialNumber);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (ImageCodePopView *)codeView{
    if (!_codeView) {
        _codeView = [[NSBundle mainBundle] loadNibNamed:@"ImageCodePopView" owner:self options:nil].firstObject;
    }
    return _codeView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
