//
//  ZYZMBProgressHUD.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ZYZMBProgressHUD.h"

@implementation ZYZMBProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    UIImage *image = [UIImage jk_animatedGIFNamed:@"MBProgressloading"];
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width/2, image.size.height/2)];
    gifview.image=image;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = gifview;
    [hud showAnimated:animated];
    return hud;
}

@end
