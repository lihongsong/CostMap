//
//  AUAlertView.h
//  Pods
//
//  Created by Jacue on 2017/4/18.
//
//

#import <UIKit/UIKit.h>

@protocol AUAlertViewDelegate <NSObject>

- (void)alertView:(UIAlertView *)alertView dismissWithClickedButtonIndex:(NSInteger)buttonIndex;

@end

@interface AUAlertView : UIAlertView

@property(nonatomic,weak) id <AUAlertViewDelegate> auDelegate;

@end
