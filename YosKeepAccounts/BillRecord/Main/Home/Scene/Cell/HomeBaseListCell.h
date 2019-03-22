#define CircleSpace 27    
#define CircleHeight (SWidth - CircleSpace * 5)/4.0
#define CircleCellHeight  205 + CircleHeight
typedef NS_ENUM(NSInteger, cellType){
    CredictUseRateType,
    ApplyRecordType,
    LendRecordType,
    CommunicationActiveType,
};
#import <UIKit/UIKit.h>
#import "HomeDataEntity.h"
@interface HomeBaseListCell : UITableViewCell
@property(nonatomic,assign)BOOL *isExample;
-(void)config:(HomeDataEntity *)model example:(BOOL)isExample withType:(cellType)type;
@end
