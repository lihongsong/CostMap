//
//  PageViewController.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/14.
//  Copyright © 2018年 jason. All rights reserved.
//
typedef NS_ENUM(NSUInteger, PageType) {
    PageOneType,  //
    PageTwoType,
    PageThreeType    //
};

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController
@property(nonatomic,assign)PageType type;
@end
