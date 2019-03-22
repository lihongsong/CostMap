#import "YosKeepAccountsBaseEntity.h"
@class CommunicationActiveEntity,CredictCheckRecondEntity,CredictLendRecord;
@interface HomeDataEntity : NSObject
@property (nonatomic,strong) NSArray <CommunicationActiveEntity *>* communicationActive;
@property (nonatomic,strong) NSArray <CredictCheckRecondEntity *>* credictCheckRecond;
@property (nonatomic,strong) NSArray <CredictLendRecord *>* credictLendRecord;
@property (nonatomic,strong) NSArray <NSString *>*credictUseRate;
@property (nonatomic,copy) NSString *credictUseState;
@property (nonatomic,copy) NSString *applyRecordState;
@property (nonatomic,copy) NSString *lendRecordState;
@property (nonatomic,copy) NSString *communicationState;
@property (nonatomic,copy) NSString *creditScore;
@property (nonatomic,copy) NSString *creditStatus;
@property (nonatomic,copy) NSString *evaluationTime;
@property (nonatomic,strong) NSArray <NSString *>*credictApplyRecode;
@property (nonatomic,strong) NSArray <NSString *>* communicationDistribution;
@end
@interface CommunicationActiveEntity : NSObject
@property (nonatomic,copy) NSString *called;
@property (nonatomic,copy) NSString *calling;
@end
@interface CredictCheckRecondEntity : NSObject
@property (nonatomic,copy) NSString *credictCardCheck;
@property (nonatomic,copy) NSString *approval;
@property (nonatomic,copy) NSString *management;
@end
@interface CredictLendRecord : NSObject
@property(nonatomic,copy) NSString *lendCount;
@property (nonatomic,copy) NSString *repayCount;
@end
