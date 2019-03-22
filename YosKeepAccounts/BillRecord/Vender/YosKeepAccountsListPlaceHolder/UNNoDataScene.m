#import "UNNoDataScene.h"
@interface UNNoDataScene ()
@property (nonatomic, strong) UIImageView *noDataImageScene;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@end
@implementation UNNoDataScene
+ (instancetype)viewAddedTo:(UIView *)view {
    return [self viewAddedTo:view imageName:nil title:nil];
}
+ (instancetype)viewAddedTo:(UIView *)view
                  imageName:(NSString *)imageName
                      title:(NSString *)title {
    UNNoDataScene *noDataScene = [[UNNoDataScene alloc] initWithFrame:view.bounds];
    noDataScene.backgroundColor = [UIColor whiteColor];
    noDataScene.imageName = imageName;
    noDataScene.title = title;
    CGPoint center = noDataScene.center;
    center.y -= noDataScene.noDataImageScene.frame.size.height/2;
    noDataScene.noDataImageScene.center = center;
    [noDataScene addSubview:noDataScene.noDataImageScene];
    center.y = CGRectGetMaxY(noDataScene.noDataImageScene.frame) + 25;
    noDataScene.noDataLabel.center = center;
    [noDataScene addSubview:noDataScene.noDataLabel];
    return noDataScene;
}
#pragma mark - Getter & Setter
- (UIImageView *)noDataImageScene {
    if (!_noDataImageScene) {
        UIImage *image = nil;
        if (_imageName) {
            image = [UIImage imageNamed:_imageName];
        }
        if (!image) {
            image = [UIImage imageNamed:@"img_nodata"];
        }
        _noDataImageScene = [[UIImageView alloc] initWithImage:image];
    }
    return _noDataImageScene;
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
    center.y -= self.noDataImageScene.frame.size.height/2;
    self.noDataImageScene.center = center;
    center.y = CGRectGetMaxY(self.noDataImageScene.frame) + 25;
    self.noDataLabel.center = center;
}
@end
