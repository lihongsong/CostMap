#ifndef UtilitiesDefine_h
#define UtilitiesDefine_h
#define YosKeepAccountsThemeColor HJHexColor(0xFF601A)
#define SafeStr(_str) StrIsEmpty(_str) ? @"" : _str
#define LNAOPSAFESTRING(str) ((((str) != nil) && ![(str) isKindOfClass:[NSNull class]]) ? [NSString stringWithFormat:@"%@", (str)] : @"")
#define kSQLTableName @"YosKeepAccountsOrderRecordTable"
#define kUserArchiverKey @"userInfoEntity"
#define kHasInstallApp @"kHasInstallApp"
#define kCachedTouchIdStatus @"kCachedTouchIdStatus"
#define kUserArchiverFileName @"userInfoFile"
#define KUserBaseMessageFileName_Before @"UserBasicMsg_Before"
#define KUserBaseMessageFileName_After @"UserBasicMsg_After"
#define KLoadingAdvertisement @"RefreshLoadingAdvertisement"
#define KExample_Credit_Score @"example_Credit_Score"
#define KProductHidden @"Productions_Hidden"
#define APP_STORE_ID [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"APP_STORE_ID"] longValue]
#define WEAK_SELF __weak typeof(self)weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf;
#define ThreeInch ([UIScreen mainScreen].bounds.size.height == 480.0)
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)
#define FourSevenInch ([UIScreen mainScreen].bounds.size.height == 667.0)
#define FiveInch ([UIScreen mainScreen].bounds.size.height == 736.0)
#define SHeight [UIScreen mainScreen].bounds.size.height
#define SWidth [UIScreen mainScreen].bounds.size.width
#define KeyWindow [[UIApplication sharedApplication] delegate].window
#define UserDefaultSetObj(obj,key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefaultGetObj(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define IOS_VERSION_10_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))
#define IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define SB(STORY_BOARD_NAME) [UIStoryboard storyboardWithName:STORY_BOARD_NAME bundle:nil]
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
#define SharedApp [UIApplication sharedApplication]
#define SAFESTRING(str)  ( ( ((str)!=nil)&&![(str) isKindOfClass:[NSNull class]])?[NSString stringWithFormat:@"%@",(str)]:@"" )
#define  adjustsScrollSceneInsets_NO(scrollScene,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollScene   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
#define StoryBoard(_name) [UIStoryboard storyboardWithName:_name bundle:[NSBundle bundleForClass:[self class]]]
#define StoryBoardLoaderRoot(_name) [(StoryBoard(_name)) instantiateInitialViewController]
#define StoryBoardLoader(_name,_id) [(StoryBoard(_name)) instantiatePresenterWithIdentifier:_id]
#define ObjIsNilOrNull(_obj)    (((_obj) == nil) || (_obj == (id)kCFNull))
#define StrIsEmpty(_str)        (ObjIsNilOrNull(_str) || (![(_str) isKindOfClass:[NSString class]]) || ([(_str) isEqualToString:@""]))
#define ArrIsEmpty(_arr)        (ObjIsNilOrNull(_arr) || (![(_arr) isKindOfClass:[NSArray class]]) || ([(_arr) count] == 0))
#define DicIsEmpty(_dic)        (ObjIsNilOrNull(_dic) || (![(_dic) isKindOfClass:[NSDictionary class]]) || ([(_dic.allKeys) count] == 0))
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
typedef void(^DefaultBlock)(void);
#endif
