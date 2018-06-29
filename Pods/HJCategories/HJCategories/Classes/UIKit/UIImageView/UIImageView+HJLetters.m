//
//  UIImageView+HJLetters.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIImageView+HJLetters.h"

// This multiplier sets the font size based on the view bounds
static const CGFloat hj_FontResizingProportion = 0.42f;

@implementation UIImageView (HJLetters)

- (void)hj_setImageWithString:(NSString *)string {
    [self hj_setImageWithString:string color:nil circular:NO textAttributes:nil];
}

- (void)hj_setImageWithString:(NSString *)string color:(UIColor *)color {
    [self hj_setImageWithString:string color:color circular:NO textAttributes:nil];
}

- (void)hj_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular {
    [self hj_setImageWithString:string color:color circular:isCircular textAttributes:nil];
}

- (void)hj_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName {
    [self hj_setImageWithString:string color:color circular:isCircular textAttributes:@{
                                                                                        NSFontAttributeName:[self hj_fontForFontName:fontName],
                                                                                        NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                        }];
}

- (void)hj_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    if (!textAttributes) {
        textAttributes = @{
                           NSFontAttributeName: [self hj_fontForFontName:nil],
                           NSForegroundColorAttributeName: [UIColor whiteColor]
                           };
    }
    
    NSMutableString *displayString = [NSMutableString stringWithString:@""];
    
    NSMutableArray *words = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    
    //
    // Get first letter of the first and last word
    //
    if ([words count]) {
        NSString *firstWord = [words firstObject];
        if ([firstWord length]) {
            // Get character range to handle emoji (emojis consist of 2 characters in sequence)
            NSRange firstLetterRange = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
            [displayString appendString:[firstWord substringWithRange:firstLetterRange]];
        }
        
        if ([words count] >= 2) {
            NSString *lastWord = [words lastObject];
            
            while ([lastWord length] == 0 && [words count] >= 2) {
                [words removeLastObject];
                lastWord = [words lastObject];
            }
            
            if ([words count] > 1) {
                // Get character range to handle emoji (emojis consist of 2 characters in sequence)
                NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
                [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
            }
        }
    }
    
    UIColor *backgroundColor = color ? color : [self hj_letter_randomColor];
    
    self.image = [self hj_imageSnapshotFromText:[displayString uppercaseString] backgroundColor:backgroundColor circular:isCircular textAttributes:textAttributes];
}

#pragma mark - Helpers

- (UIFont *)hj_fontForFontName:(NSString *)fontName {
    
    CGFloat fontSize = CGRectGetWidth(self.bounds) * hj_FontResizingProportion;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        return [UIFont systemFontOfSize:fontSize];
    }
    
}

- (UIColor *)hj_letter_randomColor {
    
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIImage *)hj_imageSnapshotFromText:(NSString *)text backgroundColor:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize size = self.bounds.size;
    if (self.contentMode == UIViewContentModeScaleToFill ||
        self.contentMode == UIViewContentModeScaleAspectFill ||
        self.contentMode == UIViewContentModeScaleAspectFit ||
        self.contentMode == UIViewContentModeRedraw)
    {
        size.width = floorf(size.width * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (isCircular) {
        //
        // Clip context to a circle
        //
        CGPathRef path = CGPathCreateWithEllipseInRect(self.bounds, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    //
    // Fill background of context
    //
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    //
    // Draw text in the context
    //
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    CGRect bounds = self.bounds;
    
    [text drawInRect:CGRectMake(bounds.size.width/2 - textSize.width/2,
                                bounds.size.height/2 - textSize.height/2,
                                textSize.width,
                                textSize.height)
      withAttributes:textAttributes];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}


@end
