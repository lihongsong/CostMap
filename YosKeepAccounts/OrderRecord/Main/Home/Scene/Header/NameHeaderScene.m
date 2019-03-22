#import "NameHeaderScene.h"
#import "ZYZControl.h"
@implementation NameHeaderScene
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initControls:frame];
    return self;
}
-(void)initControls:(CGRect)frame{
    UIImageView *faceImage = [ZYZControl createImageSceneFrame:CGRectMake(17, frame.size.height/2.0 - 10, 33, 23) imageName:@"home_ic_smile"];
    [self addSubview:faceImage];
    self.nameLabel = [ZYZControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(faceImage.frame) + 20, 10, 140, 40) Font:[UIFont BigTitleFont] Text:@"Hi, 王XX 先生"];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:self.nameLabel];
    self.exampleImage = [ZYZControl createImageSceneFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5,self.nameLabel.center.y - 8.5, 58, 17) imageName:@"home_ic_label"];
    [self addSubview:self.exampleImage];
    UILabel *stateLabel = [ZYZControl createLabelWithFrame:CGRectMake(CGRectGetMaxX(faceImage.frame) + 20, CGRectGetMaxY(self.nameLabel.frame), frame.size.width - CGRectGetMaxX(faceImage.frame) - 20, 25) Font:[UIFont NormalTitleFont] Text:@"您的评分报告已完成"];
    stateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.nameLabel.textColor = [UIColor colorFromHexCode:@"#FF601A"];
    stateLabel.textColor = [UIColor colorFromHexCode:@"#3B364D"];
    [self addSubview:stateLabel];
}
@end
