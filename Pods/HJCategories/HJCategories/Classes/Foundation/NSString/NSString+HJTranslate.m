//
//  NSString+HJTranslate.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "NSString+HJTranslate.h"

@implementation NSString (HJTranslate)


- (NSAttributedString *)hj_setAttributeFormatString:(NSString *)formatString
                                         attributes:(NSDictionary *)attributes{
    if(!formatString){
        return nil;
    }
    
    NSString *tempString = [NSString stringWithFormat:formatString,self];
    
    NSMutableAttributedString *tempAttributeString = [[NSMutableAttributedString alloc] initWithString:tempString];
    
    NSRange range = [tempString rangeOfString:self];
    
    if(NSNotFound == range.location){
        return nil;
    }
    
    [tempAttributeString setAttributes:attributes range:range];
    
    return tempAttributeString;
}

- (NSAttributedString *)hj_setAttributeSubString:(NSString *)subString
                                      attributes:(NSDictionary *)attributes{
    
    if(!subString){
        return nil;
    }
    
    NSMutableAttributedString *tempAttributeString = [[NSMutableAttributedString alloc] initWithString:[self mutableCopy]];
    
    NSRange range = [self rangeOfString:subString];
    
    if(NSNotFound == range.location){
        return nil;
    }
    
    [tempAttributeString setAttributes:attributes range:range];
    
    return tempAttributeString;
}


- (NSString *)hj_stringByInsert:(NSString *)insertedString
                  firstLocation:(NSInteger)firstLocation
                       distance:(NSInteger)distance{
    
    NSMutableString *mutableSelf = self.mutableCopy;
    NSInteger insertCount = 0;
    
    for (NSInteger index=0; index < self.length; index++){
        
        if (index > 0 && (index - firstLocation) % distance == 0) {
            [mutableSelf insertString:insertedString atIndex: (index + insertCount)];
            insertCount++;
        }
    }
    
    return mutableSelf;
}

- (NSString *)hj_convertMark:(NSString *)mark inRange:(NSRange)range{
    
    if(range.location > self.length || range.location + range.length > self.length){
        NSAssert(1, @"range is out of string length");
        return @"";
    }
    
    NSInteger count = range.length;
    
    NSArray *marks = [self copyMarkToArray:mark number:count];
    
    NSString *markString = [marks componentsJoinedByString:@""];
    
    NSMutableString *tempString = [NSMutableString stringWithString:self];
    
    [tempString replaceCharactersInRange:range withString:markString];
    
    return tempString;
}

- (NSArray *)copyMarkToArray:(NSString *)mark number:(NSInteger)number{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0 ; i < number ; i ++){
        [tempArray addObject:mark];
    }
    return tempArray;
}

@end
