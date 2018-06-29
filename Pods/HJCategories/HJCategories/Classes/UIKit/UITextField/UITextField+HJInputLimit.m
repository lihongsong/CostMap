//
//  UITextField+HJInputLimit.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UITextField+HJInputLimit.h"
#import <objc/runtime.h>

static const void *JKTextFieldInputSpaceIndex = &JKTextFieldInputSpaceIndex;

static const void *JKTextFieldInputLimitMaxLength = &JKTextFieldInputLimitMaxLength;

@implementation UITextField (HJInputLimit)

- (NSInteger)hj_maxLength {
    return [objc_getAssociatedObject(self, JKTextFieldInputLimitMaxLength) integerValue];
}
- (void)setHj_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self,
                             JKTextFieldInputLimitMaxLength,
                             @(maxLength),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTextFieldDidChangeAction];
}

- (NSArray<NSNumber *> *)spaceIndex {
    return objc_getAssociatedObject(self, JKTextFieldInputSpaceIndex);
}

- (void)setSpaceIndex:(NSArray<NSNumber *> *)spaceIndex {
    objc_setAssociatedObject(self,
                             JKTextFieldInputSpaceIndex,
                             spaceIndex,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self needToInsertSpace] && self.hj_maxLength > 0) {
        self.hj_maxLength = self.hj_maxLength + spaceIndex.count;
    }
    
    [self addTextFieldDidChangeAction];
}

- (void)addTextFieldDidChangeAction {
    
    NSArray *actionArray = [self actionsForTarget:self forControlEvent:UIControlEventEditingChanged];
    
    NSString *actionString = NSStringFromSelector(@selector(hj_textFieldTextDidChange));
    
    if (0 == actionArray.count || ![actionArray containsObject:actionString]) {
        [self addTarget:self
                 action:@selector(hj_textFieldTextDidChange)
       forControlEvents:UIControlEventEditingChanged];
    }
}

- (BOOL)needToInsertSpace {
    return [self needToInsertSpaceWithSpaceIndex:self.spaceIndex];
}

- (BOOL)needToInsertSpaceWithSpaceIndex:(NSArray <NSNumber *> *)spaceIndex {
    BOOL flag = NO;
    
    for (int i = 0; i < spaceIndex.count ; i++) {
        
        if ([spaceIndex[i] integerValue] > self.hj_maxLength) {
            flag = YES;
        }
    }
    
    if ((spaceIndex.count > 0 && !flag) || (self.hj_maxLength <= 0 && spaceIndex.count > 0)) {
        return YES;
    }
    
    return NO;
}


- (void)hj_textFieldTextDidChange {
    
    NSString *toBeString;
    if (self.spaceIndex.count > 0) {
        toBeString = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    } else {
        toBeString = self.text;
    }
    
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    NSInteger differIndex = [self needToInsertSpace] ? self.spaceIndex.count : 0 ;
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.hj_maxLength > 0 && toBeString.length > self.hj_maxLength - differIndex))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.hj_maxLength - differIndex];
        if (rangeIndex.length == 1)
        {
            NSString *tempString = [toBeString substringToIndex:self.hj_maxLength - differIndex];
            [self insertSpaceWithString:tempString];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.hj_maxLength - self.spaceIndex.count)];
            NSInteger tmpLength;
            if (rangeRange.length > self.hj_maxLength - differIndex) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            
            NSString *tempString = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
            
            [self insertSpaceWithString:tempString];
        }
    } else {
        // 有高亮状态下的文字不进行裁剪
        if ((!position ||!selectedRange)) {
            
            if (self.spaceIndex.count == 0) {
                return;
            } else {
                [self insertSpaceWithString:toBeString];
            }
        }
    }
}

- (void)insertSpaceWithString:(NSString *)string {
    
    NSMutableString *tempString = [NSMutableString stringWithString:string];
    
    if ([self needToInsertSpace]) {
        
        for (NSInteger i = self.spaceIndex.count - 1; i >= 0 ;i--) {
            NSNumber *obj = self.spaceIndex[i];
            if (tempString.length > [obj integerValue]) {
                [tempString insertString:@" " atIndex:[obj integerValue]];
            }
        }
    }
    
    // 光标问题需要解决
    self.text = tempString;
    
}


@end
