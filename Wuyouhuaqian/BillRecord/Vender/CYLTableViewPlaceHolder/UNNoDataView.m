//
//  UNNoDataView.m
//  union
//
//  Created by 顾慧超 on 16/4/29.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "UNNoDataView.h"

@interface UNNoDataView ()

@property (nonatomic, strong) UIImageView *noDataImageView;

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;

@end

@implementation UNNoDataView

+ (instancetype)viewAddedTo:(UIView *)view {
    return [self viewAddedTo:view imageName:nil title:nil];
}

+ (instancetype)viewAddedTo:(UIView *)view
                  imageName:(NSString *)imageName
                      title:(NSString *)title {
    UNNoDataView *noDataView = [[UNNoDataView alloc] initWithFrame:view.bounds];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.imageName = imageName;
    noDataView.title = title;
    
    CGPoint center = noDataView.center;
    center.y -= noDataView.noDataImageView.frame.size.height/2;
    noDataView.noDataImageView.center = center;
    [noDataView addSubview:noDataView.noDataImageView];
    
    center.y = CGRectGetMaxY(noDataView.noDataImageView.frame) + 25;
    noDataView.noDataLabel.center = center;
    [noDataView addSubview:noDataView.noDataLabel];
    return noDataView;
}

#pragma mark - Getter & Setter

- (UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        UIImage *image = nil;
        if (_imageName) {
            image = [UIImage imageNamed:_imageName];
        }
        if (!image) {
            image = [UIImage imageNamed:@"img_nodata"];
        }
        _noDataImageView = [[UIImageView alloc] initWithImage:image];
    }
    return _noDataImageView;
}

- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.font = [UIFont systemFontOfSize:15];
        _noDataLabel.textColor = HJHexColor(k0x999999);
        _noDataLabel.text = _title ? _title : @"暂时无数据...";
        [_noDataLabel sizeToFit];
    }
    return _noDataLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = self.center;
    center.y -= self.noDataImageView.frame.size.height/2;
    self.noDataImageView.center = center;
    
    center.y = CGRectGetMaxY(self.noDataImageView.frame) + 25;
    self.noDataLabel.center = center;
}

@end
