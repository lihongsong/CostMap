//
//  ImageCodeView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ImageCodePopView.h"
@interface ImageCodePopView()

@end

@implementation ImageCodePopView

- (void)setBase64ImageStr:(NSString *)base64ImageStr{
    _base64ImageStr = base64ImageStr;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64ImageStr options:0];
    UIImage *image = [UIImage imageWithData:data];
    self.codeImageVIew.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
