#import "YosChartScene.h"
#import <WebKit/WebKit.h>
#define YosSYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#ifdef DEBUG 
#define YosDetailLog(fmt, ...) NSLog((@"-------> %@ [Line %d] \n" fmt "\n\n"), [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__);
#else 
#define YosDetailLog(...)
#endif
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@interface YosChartScene()<WKNavigationDelegate,UIWebViewDelegate> {
    UIWebView *_UIWebView;
    WKWebView *_WKWebView;
    NSString  *_optionJson;
    NSDictionary *_dictAdditionalOptions;
}
@end
@implementation YosChartScene
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBasicWebScene];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpBasicWebScene];
    }
    return self;
}
- (void)setUpBasicWebScene {
    if (YosSYSTEM_VERSION >= 9.0) {
        _WKWebView = [[WKWebView alloc] init];
        _WKWebView.navigationDelegate = self;
        _WKWebView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_WKWebView];
        _WKWebView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[self configureTheConstraintArrayWithItem:_WKWebView toItem:self]];
    } else {
        _UIWebView = [[UIWebView alloc] init];
        _UIWebView.delegate = self;
        _UIWebView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_UIWebView];
        _UIWebView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[self configureTheConstraintArrayWithItem:_UIWebView toItem:self]];
    }
}
- (NSArray *)configureTheConstraintArrayWithItem:(UIView *)childScene toItem:(UIView *)fatherScene{
    return  @[[NSLayoutConstraint constraintWithItem:childScene
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:fatherScene
                                           attribute:NSLayoutAttributeLeft
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:childScene
                                           attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:fatherScene
                                           attribute:NSLayoutAttributeRight
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:childScene
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:fatherScene
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:childScene
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:fatherScene
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0],
              ];
}
- (NSURLRequest *)getJavaScriptFileURLRequest {
    NSString *webPath = [[NSBundle mainBundle] pathForResource:@"YosChartScene" ofType:@"html"];
    NSURL *webURL = [NSURL fileURLWithPath:webPath];
    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:webURL];
    return URLRequest;
}
- (void)configureTheOptionsJsonStringWithYosOptions:(YosOptions *)options {
    if (self.isClearBackgroundColor == YES) {
        options.chart.backgroundColor = @"rgba(0,0,0,0)";
    }
    _optionJson = [YosJsonConverter getPureOptionsString:options];
    if (_dictAdditionalOptions) {
        NSData *data = [_optionJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSMutableDictionary *jsonDictTemp = [jsonDict mutableCopy];
        for (id key in _dictAdditionalOptions) {
            if (![[jsonDict allKeys] containsObject:key])  {
                [jsonDictTemp setObject:[_dictAdditionalOptions objectForKey:key] forKey:key];
            } else {
                [jsonDictTemp removeObjectForKey:key];
                [jsonDictTemp setObject:[_dictAdditionalOptions objectForKey:key] forKey:key];
            }
        }
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictTemp options:0 error:&err];
        NSString * myString = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] substringFromIndex:1];
        _optionJson=[NSString stringWithFormat:@"%@%@",@"{", myString];
    }
}
- (NSString *)configTheJavaScriptString {
    CGFloat chartSceneContentWidth = self.contentWidth;
    CGFloat contentHeight = self.frame.size.height;
    if (kDevice_Is_iPhoneX == YES) {
        contentHeight = contentHeight - 20;
    }
    CGFloat chartSceneContentHeight = self.contentHeight == 0 ? contentHeight : self.contentHeight;
    NSString *javaScriptStr = [NSString stringWithFormat:@"loadTheHighChartScene('%@','%@','%@')",_optionJson,[NSNumber numberWithFloat:chartSceneContentWidth],[NSNumber numberWithFloat:chartSceneContentHeight-1]];
    return javaScriptStr;
}
- (void)yos_method_drawChartWithChartEntity:(YosChartEntity *)chartEntity {
    YosOptions *options = [YosOptionsConstructor configureChartOptionsWithYosChartEntity:chartEntity];
    _dictAdditionalOptions = chartEntity.additionalOptions;
    [self yos_method_drawChartWithOptions:options];
}
- (void)yos_method_refreshChartWithChartEntity:(YosChartEntity *)chartEntity {
    [self yos_method_drawChartWithChartEntity:chartEntity];
}
- (void)yos_method_onlyRefreshTheChartDataWithChartEntitySeries:(NSArray<NSDictionary *> *)series {
    [self yos_method_onlyRefreshTheChartDataWithOptionsSeries:series];
}
- (void)yos_method_drawChartWithOptions:(YosOptions *)options {
    if (!_optionJson) {
        [self configureTheOptionsJsonStringWithYosOptions:options];
        NSURLRequest *URLRequest = [self getJavaScriptFileURLRequest];
        if (YosSYSTEM_VERSION >= 9.0) {
            [_WKWebView loadRequest:URLRequest];
        } else {
            [_UIWebView loadRequest:URLRequest];
        }
    } else {
        [self configureTheOptionsJsonStringWithYosOptions:options];
        [self drawChart];
    }
}
- (void)yos_method_refreshChartWithOptions:(YosOptions *)options {
    [self yos_method_drawChartWithOptions:options];
}
- (void)yos_method_onlyRefreshTheChartDataWithOptionsSeries:(NSArray<NSDictionary *> *)series {
    NSString *seriesJsonStr = [YosJsonConverter getPureSeriesString:series];
    NSString *javaScriptStr = [NSString stringWithFormat:@"onlyRefreshTheChartDataWithSeries('%@')",seriesJsonStr];
    [self evaluateJavaScriptWithFunctionNameString:javaScriptStr];
}
- (void)drawChart {
    NSString *javaScriptStr = [self configTheJavaScriptString];
    [self evaluateJavaScriptWithFunctionNameString:javaScriptStr];
}
- (void)webScene:(WKWebView *)webScene didFinishNavigation:(WKNavigation *)navigation {
    [self drawChart];
    [self.delegate YosChartSceneDidFinishLoad];
}
- (void)webSceneDidFinishLoad:(UIWebView *)webScene {
    [self drawChart];
    [self.delegate YosChartSceneDidFinishLoad];
}
- (void)yos_method_showTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex {
    NSString *javaScriptStr = [NSString stringWithFormat:@"showTheSeriesElementContentWithIndex(%ld)",(long)elementIndex];
    [self evaluateJavaScriptWithFunctionNameString:javaScriptStr];
}
- (void)yos_method_hideTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex {
    NSString *javaScriptStr = [NSString stringWithFormat:@"hideTheSeriesElementContentWithIndex(%ld)",(long)elementIndex];
    [self evaluateJavaScriptWithFunctionNameString:javaScriptStr];
}
- (void)evaluateJavaScriptWithFunctionNameString:(NSString *)funcitonNameStr {
    if (YosSYSTEM_VERSION >= 9.0) {
        [_WKWebView  evaluateJavaScript:funcitonNameStr completionHandler:^(id item, NSError * _Nullable error) {
            if (error) {
                YosDetailLog(@"☠️☠️💀☠️☠️WARNING!!!!! THERE ARE SOME ERROR INFOMATION_______%@",error);
            }
        }];
    } else {
        [_UIWebView  stringByEvaluatingJavaScriptFromString:funcitonNameStr];
    }
}
#pragma mark -- setter method
- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    if (YosSYSTEM_VERSION >= 9.0) {
        _WKWebView.scrollView.scrollEnabled = _scrollEnabled;
    } else {
        _UIWebView.scrollView.scrollEnabled = _scrollEnabled;
    }
}
- (void)setContentWidth:(CGFloat)contentWidth {
    _contentWidth = contentWidth;
    NSString *javaScriptStr = [NSString stringWithFormat:@"setTheChartSceneContentWidth(%f)",_contentWidth];
    [self evaluateJavaScriptWithSetterMethodNameString:javaScriptStr];
}
- (void)setContentHeight:(CGFloat)contentHeight {
    _contentHeight = contentHeight;
    NSString *javaScriptStr = [NSString stringWithFormat:@"setTheChartSceneContentHeight(%f)",_contentHeight];
    [self evaluateJavaScriptWithSetterMethodNameString:javaScriptStr];
}
- (void)setChartSeriesHidden:(BOOL)chartSeriesHidden {
    _chartSeriesHidden = chartSeriesHidden;
        NSString *jsStr = [NSString stringWithFormat:@"setChartSeriesHidden(%d)",_chartSeriesHidden];
        [self evaluateJavaScriptWithSetterMethodNameString:jsStr];
}
- (void)evaluateJavaScriptWithSetterMethodNameString:(NSString *)JSFunctionStr {
    if (_optionJson) {
          [self evaluateJavaScriptWithFunctionNameString:JSFunctionStr];
    }
}
- (void)setIsClearBackgroundColor:(BOOL)isClearBackgroundColor {
    _isClearBackgroundColor = isClearBackgroundColor;
    if (_isClearBackgroundColor == YES) {
        self.backgroundColor = [UIColor clearColor];
        if (YosSYSTEM_VERSION >= 9.0) {
            [_WKWebView setBackgroundColor:[UIColor clearColor]];
            [_WKWebView setOpaque:NO];
        } else {
            [_UIWebView setBackgroundColor:[UIColor clearColor]];
            [_UIWebView setOpaque:NO];
        }
    }
}
- (void)setBlurEffectEnabled:(BOOL)blurEffectEnabled {
    _blurEffectEnabled = blurEffectEnabled;
    if (_blurEffectEnabled) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectScene = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:effectScene];
        [self sendSubviewToBack:effectScene];
        effectScene.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[self configureTheConstraintArrayWithItem:effectScene toItem:self]];
    }
}
@end
#import <objc/runtime.h>
@implementation YosJsonConverter
+ (NSDictionary*)getObjectData:(id)obj {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    Class superClass = [obj class];
    do {
        objc_property_t *props = class_copyPropertyList(superClass, &propsCount);
        for (int i = 0;i < propsCount; i++) {
            objc_property_t prop = props[i];
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            id value = [obj valueForKey:propName];
            if (value == nil) {
                value = [NSNull null];
                continue;
            } else {
                value = [self getObjectInternal:value];
            }
            [dic setObject:value forKey:propName];
        }
        free(props);
        superClass = [superClass superclass];
    } while (superClass != [NSObject class]);
    return dic;
}
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error {
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}
+ (id)getObjectInternal:(id)obj {
    if (   [obj isKindOfClass:[NSString class]]
        || [obj isKindOfClass:[NSNumber class]]
        || [obj isKindOfClass:[NSNull   class]] ) {
        return obj;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for (int i = 0;i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for (NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}
+ (NSString*)convertDictionaryIntoJson:(NSDictionary *)dictionary {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *string =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}
+ (NSString*)wipeOffTheLineBreakAndBlankCharacter:(NSString *)originalString {
    NSString *str =[originalString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}
+ (NSString *)getPureOptionsString:(id)optionsObject {
    NSDictionary *dic = [self getObjectData:optionsObject];
    NSString *str = [self convertDictionaryIntoJson:dic];
    return [self wipeOffTheLineBreakAndBlankCharacter:str];
}
+ (NSString *)getPureSeriesString:(NSArray<NSDictionary*> *)series {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:series options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *seriesStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self wipeOffTheLineBreakAndBlankCharacter:seriesStr];
}
@end
