#import "UIButton+Count.h"
@implementation UIButton (Count)
- (void)startTotalTime:(NSInteger)timer title:(NSString *)title waitingTitle:(NSString *)waitingtitle{
    __block NSInteger second = timer;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t distimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(distimer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    dispatch_source_set_event_handler(distimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second > 0) {
                [self setTitle:[NSString stringWithFormat:@"%lds%@",(long)second,waitingtitle] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor loginGrayColor] forState:UIControlStateNormal];
                second--;
                self.enabled = NO;
            }
            else
            {
                dispatch_source_cancel(distimer);
                 [self setTitleColor:[UIColor skinColor] forState:UIControlStateSelected];
                [self setTitle:title forState:UIControlStateNormal];
                self.enabled = YES;
            }
        });
    });
    dispatch_resume(distimer);
}
@end
