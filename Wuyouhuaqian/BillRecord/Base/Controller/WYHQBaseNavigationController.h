//
//  WYHQBaseNavigationController.h
//  JiKeLoan
//
//  Created by AndyMu on 16/12/27.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYHQBaseNavigationController;

@protocol WYHQNavigationControllerShouldPopDelegate<NSObject>

@optional
- (BOOL)navigationControllerShouldPopViewController;

@end

@interface WYHQBaseNavigationController : UINavigationController

@end
