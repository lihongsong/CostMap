//
//  DefaultView.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/23.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadButtonBlock)(void);

@interface DefaultView : UIView
@property (nonatomic,strong) ReloadButtonBlock reloadBlock;
@property (nonatomic,copy) NSString *imageNameString;
@property (nonatomic,copy) NSString *tip1String;
@property (nonatomic,copy) NSString *tip2String;

@end
