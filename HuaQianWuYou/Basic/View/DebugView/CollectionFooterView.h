//
//  CollectionFooterView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ApiSelectFooterDelegate <NSObject>
//  跳过
-(void)footerJumpClick;
// 确认
-(void)footerConfirmClick;
@end

@interface CollectionFooterView : UIView
@property (nonatomic,strong)id<ApiSelectFooterDelegate>delegate;
@end
