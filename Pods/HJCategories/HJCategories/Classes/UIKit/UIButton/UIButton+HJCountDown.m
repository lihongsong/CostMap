//
//  UIButton+HJCountDown.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIButton+HJCountDown.h"
#import "UIColor+HJHex.h"

@implementation UIButton (HJCountDown)

- (void)hj_startTime:(NSInteger)timeout
               title:(NSString *)title
    enableTitleColor:(UIColor *)enableTitleColor
   disableTitleColor:(UIColor *)disableTitleColor{
    
    UIColor *enableBackColor = [self backgroundColor];
    UIColor *disableBackColor = [UIColor whiteColor];
    
    [self hj_startTime:timeout
                 title:title
        waitTitleBlock:nil
      enableTitleColor:enableTitleColor
     disableTitleColor:disableTitleColor
       enableBackColor:enableBackColor
      disableBackColor:disableBackColor
             blockTime:0
            completion:nil];
}

- (void)hj_startTime:(NSInteger)timeout{
    
    UIColor *enableTitlecolor = [self titleColorForState:UIControlStateNormal];
    UIColor *disableTitlColor = HJHexColor(0xcccccc);
    
    [self hj_startTime:timeout title:nil enableTitleColor:enableTitlecolor disableTitleColor:disableTitlColor];
}

- (void)hj_startTime:(NSInteger)timeout
               title:(NSString *)title
      waitTitleBlock:(HJWaitTitleBlock)waitTitleBlock
    enableTitleColor:(UIColor *)enableTitleColor
   disableTitleColor:(UIColor *)disableTitleColor
     enableBackColor:(UIColor *)enableBackColor
    disableBackColor:(UIColor *)disableBackColor
           blockTime:(NSInteger)blockTime
          completion:(void (^)(void))completion{
    
    id tempTitle = [self checkTitleAvaliable:title];
    
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
                
                if([tempTitle isKindOfClass:[NSAttributedString class]]){
                    [self setTitle:nil forState:UIControlStateNormal];
                    [self setAttributedTitle:(NSAttributedString *)tempTitle forState:UIControlStateNormal];
                }else{
                    [self setAttributedTitle:nil forState:UIControlStateNormal];
                    [self setTitle:(NSString *)tempTitle forState:UIControlStateNormal];
                    [self setTitleColor:enableTitleColor forState:UIControlStateNormal];
                }
                
                self.backgroundColor = enableBackColor;
                
                self.userInteractionEnabled = YES;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSInteger seconds = timeOut % initialTime;
                NSAttributedString *leftTimeString;
                
                if(waitTitleBlock){
                    leftTimeString = waitTitleBlock(seconds);
                }else{
                    leftTimeString = getWaitTitle(seconds, disableTitleColor);
                }
                
                [self setAttributedTitle:leftTimeString forState:UIControlStateNormal];
                
                self.backgroundColor = disableBackColor;
                
                self.userInteractionEnabled = NO;
                
                if (seconds == blockTime) {
                    !completion?:completion();
                }
            });
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

NSAttributedString * getWaitTitle(NSInteger seconds, UIColor *color){
    
    NSString *string = [NSString stringWithFormat:@"%ld秒后重试",(long)seconds];
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:@{NSForegroundColorAttributeName:color}];
}

- (id)checkTitleAvaliable:(NSString *)title{
    
    NSString *tempTitle = @"";
    NSAttributedString *tempAttributeTitle;
    if(!title){
        if([self titleForState:UIControlStateNormal]){
            tempTitle = [self titleForState:UIControlStateNormal];
        }else{
            if(self.titleLabel.attributedText){
                tempAttributeTitle = self.titleLabel.attributedText;
                return tempAttributeTitle;
            }
        }
    }else{
        tempTitle = title;
    }
    
    return tempTitle;
}

@end

