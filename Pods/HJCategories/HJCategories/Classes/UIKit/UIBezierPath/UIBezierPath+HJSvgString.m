//
//  UIBezierPath+HJSvgString.m
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import "UIBezierPath+HJSvgString.h"

static void HJSVGApplier(void* info, const CGPathElement* element);

@implementation UIBezierPath (HJSvgString)

/**
 *  @brief  UIBezierPath转成SVG
 *
 *  @return SVG
 */
- (NSString*)hj_SVGString
{
    CGPathRef path = [self CGPath];
    NSMutableString* SVGString = [NSMutableString string];
    [SVGString appendString:@"<path id=\"temporaryID\" d=\""];
    CGPathApply(path, (__bridge_retained void*)SVGString, HJSVGApplier);
    NSString *lineCap;
    switch (self.lineCapStyle) {
        case kCGLineCapRound:
            lineCap = @"round";
            break;
        case kCGLineCapSquare:
            lineCap = @"square";
            break;
        default:
            lineCap = @"butt";
            break;
    }
    [SVGString appendFormat:@"\" stroke-linecap=\"%@\" stroke-width=\"%i\" fill=\"none\" stroke=\"red\" />", lineCap, (int)self.lineWidth];
    return [NSString stringWithFormat:@"%@", SVGString];
}

@end

static void HJSVGApplier(void* info, const CGPathElement* element)
{
    NSMutableString* SVGString = (__bridge NSMutableString*) info;
    int nPoints;
    char elementKey;
    switch (element->type)
    {
        case kCGPathElementMoveToPoint:
            nPoints = 1;
            elementKey = 'M';
            break;
        case kCGPathElementAddLineToPoint:
            nPoints = 1;
            elementKey = 'L';
            break;
        case kCGPathElementAddQuadCurveToPoint:
            nPoints = 2;
            elementKey = 'Q';
            break;
        case kCGPathElementAddCurveToPoint:
            nPoints = 3;
            elementKey = 'C';
            break;
        case kCGPathElementCloseSubpath:
            nPoints = 0;
            elementKey = 'Z';
            break;
        default:
            SVGString = nil;
            return;
    }
    NSString* nextElement = [NSString stringWithFormat:@" %c", elementKey];
    for (int i = 0; i < nPoints; i++) {
        nextElement = [nextElement stringByAppendingString:[NSString stringWithFormat:@" %i %i", (int)element->points[i].x, (int)element->points[i].y]];
    }
    [SVGString appendString:nextElement];
}

