#import "UITableView+YosKeepAccountsListPlaceHolder.h"
#import "YosKeepAccountsListPlaceHolderDelegate.h"
#import <objc/runtime.h>
@interface UITableView ()
@property (nonatomic, assign) BOOL scrollWasEnabled;
@property (nonatomic, strong) UIView *placeHolderScene;
@end
@implementation UITableView (YosKeepAccountsListPlaceHolder)
- (BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = objc_getAssociatedObject(self, @selector(scrollWasEnabled));
    return [scrollWasEnabledObject boolValue];
}
- (void)setScrollWasEnabled:(BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = [NSNumber numberWithBool:scrollWasEnabled];
    objc_setAssociatedObject(self, @selector(scrollWasEnabled), scrollWasEnabledObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)placeHolderScene {
    return objc_getAssociatedObject(self, @selector(placeHolderScene));
}
- (UIView *)cyl_placeHolderScene {
    return [self placeHolderScene];
}
- (void)setPlaceHolderScene:(UIView *)placeHolderScene {
    objc_setAssociatedObject(self, @selector(placeHolderScene), placeHolderScene, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)cyl_reloadData {
    [self reloadData];
    [self cyl_checkEmpty];
}
- (void)cyl_checkEmpty {
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector: @selector(numberOfSectionsInList:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i<sections; ++i) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    if (!isEmpty != !self.placeHolderScene) {
        if (isEmpty) {
            self.scrollWasEnabled = self.scrollEnabled;
            BOOL scrollEnabled = NO;
            if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderSceneShowing)]) {
                 scrollEnabled = (BOOL)[self performSelector:@selector(enableScrollWhenPlaceHolderSceneShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderSceneShowing`, it will be NO by default";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            } else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderSceneShowing)]) {
                scrollEnabled = (BOOL)[self.delegate performSelector:@selector(enableScrollWhenPlaceHolderSceneShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderSceneShowing`, it will be NO by default";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            }
            self.scrollEnabled = scrollEnabled;
            if ([self respondsToSelector:@selector(makePlaceHolderScene)]) {
                self.placeHolderScene = [self performSelector:@selector(makePlaceHolderScene)];
            } else if ( [self.delegate respondsToSelector:@selector(makePlaceHolderScene)]) {
                self.placeHolderScene = [self.delegate performSelector:@selector(makePlaceHolderScene)];
            } else {
                NSString *selectorName = NSStringFromSelector(_cmd);
                NSString *reason = [NSString stringWithFormat:@"You must implement makePlaceHolderScene method in your custom tableScene or its delegate class if you want to use %@", selectorName];
                @throw [NSException exceptionWithName:NSGenericException
                                               reason:reason
                                             userInfo:nil];
            }
            self.placeHolderScene.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [self addSubview:self.placeHolderScene];
        } else {
            self.scrollEnabled = self.scrollWasEnabled;
            [self.placeHolderScene removeFromSuperview];
            self.placeHolderScene = nil;
        }
    } else if (isEmpty) {
        [self.placeHolderScene removeFromSuperview];
        if ([self respondsToSelector:@selector(makePlaceHolderScene)]) {
            self.placeHolderScene = [self performSelector:@selector(makePlaceHolderScene)];
        } else if ( [self.delegate respondsToSelector:@selector(makePlaceHolderScene)]) {
            self.placeHolderScene = [self.delegate performSelector:@selector(makePlaceHolderScene)];
        } else {
            NSString *selectorName = NSStringFromSelector(_cmd);
            NSString *reason = [NSString stringWithFormat:@"You must implement makePlaceHolderScene method in your custom tableScene or its delegate class if you want to use %@", selectorName];
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:reason
                                         userInfo:nil];
        }
        self.placeHolderScene.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.placeHolderScene];
    }
}
@end
