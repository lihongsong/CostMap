#import "ASBaseSpecialViewController.h"
typedef void (^loginFinishBlock)(void);
typedef void (^RightClickBlock)(void);
typedef NS_ENUM(NSInteger, ASBusinessType){
    ASBusinessTypeHome = 0,
    ASBusinessTypeThird = 1,
    ASBusinessTypeLogin = 2,
} ;
@interface ASHomeViewController : ASBaseSpecialViewController
@property (nonatomic, assign) BOOL gotoThirdPart;
@property (nonatomic, strong) NSDictionary *navigationDic;
@property (nonatomic, copy) RightClickBlock rightBlock;
@property (nonatomic, copy) loginFinishBlock loginBlock;
@property (nonatomic, copy) NSString *specialW;
+ (instancetype)createWithBusinessType:(ASBusinessType)type;
@end
