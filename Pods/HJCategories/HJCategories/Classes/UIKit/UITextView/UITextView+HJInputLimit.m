//
//  UITextView+HJInputLimit.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UITextView+HJInputLimit.h"
#import <objc/runtime.h>

static const void *HJTextViewInputLimitMaxLength = &HJTextViewInputLimitMaxLength;

@implementation UITextView (HJInputLimit)

- (NSInteger)hj_maxLength {
    return [objc_getAssociatedObject(self, HJTextViewInputLimitMaxLength) integerValue];
}

- (void)setHj_maxLength:(NSInteger)maxLength {
    
    objc_setAssociatedObject(self, HJTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hj_textViewTextDidChange:)
                                                name:UITextViewTextDidChangeNotification object:self];
    
}

- (void)hj_textViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.hj_maxLength > 0 && toBeString.length > self.hj_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.hj_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.hj_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.hj_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.hj_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
