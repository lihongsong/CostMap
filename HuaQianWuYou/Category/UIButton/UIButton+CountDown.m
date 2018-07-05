//
//  UIButton+countDown.m
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (countDown)
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle{
    //改变背景色和字体颜色
//    self.backgroundColor = RGBCOLORV(k0xeeeeee);
    
    __block NSInteger timeOut=timeout; //倒计时时间
    NSInteger initialTime=timeout + 1; //倒计时总数
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:tittle];
                [attString setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} range:NSMakeRange(0, tittle.length)];
                [self setAttributedTitle:attString forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                //改变背景色和字体颜色
                self.backgroundColor = [UIColor skinColor];
            });
        }else{
            //            int minutes = timeout / 60;
            NSInteger seconds = timeOut % initialTime;
            NSString *strTime = [NSString stringWithFormat:@"%ld秒", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",strTime,waitTittle]];
//                [attString setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:[[NSString stringWithFormat:@"%@%@",strTime,waitTittle] rangeOfString:strTime]];
//                [attString setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:[[NSString stringWithFormat:@"%@%@",strTime,waitTittle] rangeOfString:waitTittle]];
                
                [self setAttributedTitle:attString forState:UIControlStateNormal];

                self.userInteractionEnabled = NO;
                self.backgroundColor = [UIColor sepreateColor];

                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    
}

- (void)startTime:(NSInteger)timeout enableColor:(UIColor *)enableColor disableColor:(UIColor *)disableColor {
    
    __block NSInteger timeOut = timeout; //倒计时时间
    NSInteger initialTime = timeout + 1; //倒计时总数
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                [self setTitleColor:enableColor forState:UIControlStateNormal];
                
                self.userInteractionEnabled = YES;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSInteger seconds = timeOut % initialTime;
                NSString *leftTime =  [NSString stringWithFormat:@"%ld秒后重试", (long)seconds];
                [self setTitle:leftTime forState:UIControlStateNormal];
                [self setTitleColor:disableColor forState:UIControlStateNormal];
                
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    
}

@end
