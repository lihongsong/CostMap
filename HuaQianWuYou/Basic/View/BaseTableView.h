//
//  BaseTableView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableView;

@protocol BaseTableViewDelegate <UITableViewDelegate>

@optional

- (void)tableView:(BaseTableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(BaseTableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(BaseTableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)tableView:(BaseTableView *)tableView changeFrame:(CGRect)frame;
@end

@interface BaseTableView : UITableView
@property (nonatomic, weak) id<BaseTableViewDelegate> delegate;


@end
