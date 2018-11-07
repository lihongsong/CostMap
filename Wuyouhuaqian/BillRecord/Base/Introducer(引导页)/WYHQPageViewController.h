//
//  PageViewController.h
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/14.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//
typedef NS_ENUM(NSUInteger, PageType) {
    PageOneType,  //
    PageTwoType,
    PageThreeType    //
};

#import <UIKit/UIKit.h>

@interface WYHQPageViewController : UIViewController
@property(nonatomic,assign)PageType type;
@property (nonatomic,copy) void(^rootStartVC)(void);
@end
