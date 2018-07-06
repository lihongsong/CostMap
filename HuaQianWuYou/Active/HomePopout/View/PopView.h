//
//  PopView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionBlock)(void);
@interface PopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

/* contentImageView ActionBlock */
@property (nonatomic, copy) actionBlock  block;;

@end
