//
//  PhotoCollectionReusableView.h
//  zhifuERP
//
//  Created by AsiaZhang on 2017/5/16.
//  Copyright © 2017年 zhifu360. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol collectionReusableViewDelegate<NSObject>
-(void)addTakePhotoClick:(NSInteger)tag;
@end
@interface PhotoCollectionReusableView : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)id<collectionReusableViewDelegate> delegate;
-(void)config:(NSIndexPath*)index;
@end
