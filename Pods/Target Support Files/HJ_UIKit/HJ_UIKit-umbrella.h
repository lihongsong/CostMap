#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HJCarousel-define.h"
#import "HJCarousel.h"
#import "HJCarouselCell.h"
#import "HJCarouselDataSource.h"
#import "HJCarouselDelegate.h"
#import "HJCarouselItemModel.h"
#import "HJGuidePage.h"
#import "HJGuidePageUtility.h"
#import "HJGuidePageViewController.h"
#import "HJGuidePageWindow.h"

FOUNDATION_EXPORT double HJ_UIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HJ_UIKitVersionString[];

