//
//  UITextView+HJPlaceHolder.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UITextView+HJPlaceHolder.h"

#import <objc/runtime.h>

static const char *hj_placeHolderTextView = "hj_placeHolderTextView";

@implementation UITextView (HJPlaceHolder)

- (UITextView *)hj_placeHolderTextView {
    return objc_getAssociatedObject(self,hj_placeHolderTextView);
}
- (void)setHj_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, hj_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hj_addPlaceHolder:(NSString *)placeHolder {
    if (![self hj_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setHj_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    self.hj_placeHolderTextView.text = placeHolder;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.hj_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.hj_placeHolderTextView.hidden = NO;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
