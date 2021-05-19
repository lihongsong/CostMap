//
//  ASCustomView.m
//  CostMap
//

#import "ASCustomView.h"
#import "AppDelegate.h"

static NSString * const kSendData = @"sendData";
static NSString * const kCMProtocolClick = @"kCMProtocolClick";

@interface ASCustomView()<WKScriptMessageHandler, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *view;

@property (strong, nonatomic) UIButton *confirmBtn;

@property (strong, nonatomic) UIView *backV;

@property (strong, nonatomic) UIView *whiteV;

@end

@implementation ASCustomView

static ASCustomView *customView;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat whiteH = 200;
    CGFloat btnH = 40;
    self.view.frame = CGRectMake(0, 0, SWidth - 64, whiteH - btnH);
    self.confirmBtn.frame = CGRectMake(0, whiteH - btnH, SWidth - 64, btnH);
    self.backV.frame = self.bounds;
    self.whiteV.frame = CGRectMake(0, 0, SWidth - 64, whiteH);
    self.whiteV.center = self.center;
}

+ (void)show {
    
    BOOL isShow = [UserDefaultGetObj(kCMProtocolClick) boolValue];
    
    if (isShow) {
        customView.hidden = YES;
    } else {
        customView.hidden = NO;
    }
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [window bringSubviewToFront:customView];
}

+ (void)cache {
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    customView = [ASCustomView new];
    customView.bounds = window.bounds;
    customView.center = window.center;
    
<<<<<<< HEAD
    NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@%@%@" ,@"htt", @"ps:/", @"/costmap.github.io", @"/web/te", @"chnicalS", @"upport.h", @"tml"];
    [view.view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:temp]]];
    [[[UIApplication sharedApplication] delegate].window addSubview:view.view];
=======
    customView.hidden = YES;
    [customView addSubview:customView.backV];
    [customView addSubview:customView.whiteV];
    [window addSubview:customView];
    
    NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@%@%@" ,@"htt", @"ps:/", @"/costmap.github.io", @"/web/", @"", @"protocol.h", @"tml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:temp]
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:0];
    [customView.view loadRequest:request];
}

- (void)confirmClick {
    UserDefaultSetObj(@(YES), kCMProtocolClick);
    [customView removeFromSuperview];
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
        [_confirmBtn setTitle:@"confirm" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:CostMapThemeColor forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIView *)backV {
    if (!_backV) {
        _backV = [UIView new];
        _backV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    }
    return _backV;
}

- (UIView *)whiteV {
    if (!_whiteV) {
        _whiteV = [UIView new];
        _whiteV.backgroundColor = [UIColor whiteColor];
        _whiteV.layer.cornerRadius = 8.0;
        _whiteV.layer.masksToBounds = YES;
        [_whiteV addSubview:customView.view];
        [_whiteV addSubview:customView.confirmBtn];
    }
    return _whiteV;
>>>>>>> 2f9ebf85f07da0c113ca77d42287afba4cb4b8be
}

- (WKWebView *)view {
    if (!_view) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        WKUserContentController *userContent = [WKUserContentController new];
        [userContent addScriptMessageHandler:self name:kSendData];
        NSString *appVersion = [UIDevice hj_appVersion];
        NSString *jsStr = [NSString stringWithFormat:@"function getVersion(){ return '%@'; }", appVersion];
        WKUserScript *sc = [[WKUserScript alloc] initWithSource:jsStr
                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                               forMainFrameOnly:NO];
        [userContent addUserScript:sc];
        config.userContentController = userContent;
        _view = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _view.navigationDelegate = self;
        _view.alpha = 1;
    }
    return _view;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:kSendData]) {
        
        NSString *jsonStr = message.body;
        NSString *appVersion = [UIDevice hj_appVersion];
        [[NSUserDefaults standardUserDefaults] setValue:jsonStr forKey:appVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [(AppDelegate *)[UIApplication sharedApplication].delegate setupLaunchViewControllerWithRemoteNotification];
    }
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"completionHandler:nil];
}

@end
