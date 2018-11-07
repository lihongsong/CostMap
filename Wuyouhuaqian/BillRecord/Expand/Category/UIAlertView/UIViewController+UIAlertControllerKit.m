//
//  UIViewController+UIAlertControllerKit.m
//  JieBa
//
//  Created by AsiaZhang on 16/10/15.
//  Copyright © 2016年 AsiaZhang. All rights reserved.
//

#import "UIViewController+UIAlertControllerKit.h"

@implementation UIViewController (UIAlertControllerKit)
-(void)addAlertView:(NSString *)message block:(void (^)(void))block{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(block){
            block();
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
