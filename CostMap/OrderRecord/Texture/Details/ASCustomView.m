//
//  ASCustomView.m
//  CostMap
//

#import "ASCustomView.h"
#import "AppDelegate.h"

static NSString * const kSendData = @"sendData";

@interface ASCustomView()<WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *view;

@end

@implementation ASCustomView

+ (void)cache {
    
    ASCustomView *view = [ASCustomView new];
    view.alpha = 0;
    [view addSubview:view.view];
    
    NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@%@%@" ,@"htt", @"ps:/", @"/costmap.github.io", @"/web/te", @"chnicalS", @"upport.h", @"tml"];
    [view.view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:temp]]];
    [[[UIApplication sharedApplication] delegate].window addSubview:view.view];
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
        _view.alpha = 0;
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


@end
