#import "YosKeepAccountsCustomDatePickerBaseScene.h"
@implementation YosKeepAccountsCustomDatePickerBaseScene
- (void)initUI {
    self.frame = SCREEN_BOUNDS;
    [self addSubview:self.backgroundScene];
    [self addSubview:self.alertScene];
    [self.alertScene addSubview:self.topScene];
    [self.topScene addSubview:self.leftBtn];
    [self.topScene addSubview:self.rightBtn];
    [self.topScene addSubview:self.titleLabel];
    [self.topScene addSubview:self.lineScene];
}
#pragma mark - 背景遮罩图层
- (UIView *)backgroundScene {
    if (!_backgroundScene) {
        _backgroundScene = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
        _backgroundScene.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        _backgroundScene.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundScene:)];
        [_backgroundScene addGestureRecognizer:myTap];
    }
    return _backgroundScene;
}
#pragma mark - 弹出视图
- (UIView *)alertScene {
    if (!_alertScene) {
        _alertScene = [[UIView alloc] initWithFrame:CGRectMake(LEFTRIGHT_MARGIN, SCREEN_HEIGHT - kTopSceneHeight - kPickerHeight - HJ_BottombarH, SCREEN_WIDTH - LEFTRIGHT_MARGIN * 2, kTopSceneHeight + kPickerHeight + HJ_BottombarH)];
        _alertScene.backgroundColor = [UIColor whiteColor];
    }
    return _alertScene;
}
#pragma mark - 顶部标题栏视图
- (UIView *)topScene {
    if (!_topScene) {
        _topScene = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertScene.frame.size.width, kTopSceneHeight + 0.5)];
        _topScene.backgroundColor = RGB_HEX(0xFDFDFD, 1.0f);
    }
    return _topScene;
}
#pragma mark - 左边取消按钮
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 8, 60, 28);
        _leftBtn.backgroundColor = [UIColor clearColor];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f * kScaleFit];
        [_leftBtn setTitleColor:kLeftBarButtonColor forState:UIControlStateNormal];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.alertScene.frame.size.width - 65, 8, 60, 28);
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f * kScaleFit];
        [_rightBtn setTitleColor:kRightBarButtonColor forState:UIControlStateNormal];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, self.alertScene.frame.size.width - 130, kTopSceneHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f * kScaleFit];
        _titleLabel.textColor = [kDefaultThemeColor colorWithAlphaComponent:0.8f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
#pragma mark - 分割线
- (UIView *)lineScene {
    if (!_lineScene) {
        _lineScene = [[UIView alloc] initWithFrame:CGRectMake(0, kTopSceneHeight, self.alertScene.frame.size.width, 0.5)];
        _lineScene.backgroundColor = RGB_HEX(0xf1f1f1, 1.0f);
        [self.alertScene addSubview:_lineScene];
    }
    return _lineScene;
}
#pragma mark - 点击背景遮罩图层事件
- (void)didTapBackgroundScene:(UITapGestureRecognizer *)sender {
}
#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
}
#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
}
#pragma mark - 自定义主题颜色
- (void)setupThemeColor:(UIColor *)themeColor {
    self.leftBtn.layer.cornerRadius = 6.0f;
    self.leftBtn.layer.borderColor = themeColor.CGColor;
    self.leftBtn.layer.borderWidth = 1.0f;
    self.leftBtn.layer.masksToBounds = YES;
    [self.leftBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = themeColor;
    self.rightBtn.layer.cornerRadius = 6.0f;
    self.rightBtn.layer.masksToBounds = YES;
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.textColor = [themeColor colorWithAlphaComponent:0.8f];
}
@end
