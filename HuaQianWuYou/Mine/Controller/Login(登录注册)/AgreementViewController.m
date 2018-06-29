//
//  AgreementViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *statementScrollView;
@property (weak, nonatomic) IBOutlet UITextView *statementTextView;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUi];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.statementScrollView.contentOffset = CGPointZero;
    self.statementScrollView.contentInset = UIEdgeInsetsZero;
    self.statementTextView.contentInset = UIEdgeInsetsZero;
    self.statementTextView.contentOffset = CGPointZero;
}

-(void)initUi{
    if (self.isXieYi)  {
        self.navigationItem.title = @"服务条款";
        self.statementTextView.text = @"\n花钱无忧APP依照以下注册协议向您提供本注册协议涉及的相关服务。请您使用花钱无忧APP服务前仔细阅读本注册协议。您只有完全同意所有注册协议，才能成为花钱无忧APP的用户并使用相应服务。\n您在注册为花钱无忧APP用户时即表示您已仔细阅读并明确同意遵守本注册协议以及经参引而并入其中的所有条款、政策以及指南，并受该等规则的约束。\n一、服务内容\n1.1 花钱无忧APP的具体服务内容由我们根据实际情况提供并不时更新，包括但不限于报告查询、报告分析、文章、链接等，我们将定期或不定期根据用户的意愿以电子邮件、短信、电话或站内信等方式为用户提供活动信息，并向用户提供相应服务。我们对提供的服务拥有最终解释权。\n1.2 花钱无忧APP服务仅供个人用户使用。除我们书面同意，您或其他用户均不得将花钱无忧APP上的任何信息用于商业目的。\n1.3 您使用花钱无忧APP服务时所需的相关的设备以及网络资源等（如个人电脑、手机及其他与接入互联网或移动网有关的装置）及所需的费用均由您自行负担。\n二、使用准则\n2.1 您在使用花钱无忧APP服务过程中，必须遵循国家的相关法律法规，不通过花钱无忧APP发布、复制、上传、散播、分发、存储、创建或以其它方式公开含有违反宪法和法律、行政法规或规章制度的信息。\n2.2 用户不得利用花钱无忧APP的服务从事危害互联网信息网络安全的活动：\n2.3 我们保留在任何时候为任何理由而不经通知地过滤、移除、筛查或编辑本APP上发布或存储的任何内容的权利，您须自行负责备份和替换在本APP发布或存储的任何内容，成本和费用自理。\n2.4 您须对自己在使用花钱无忧APP服务过程中的行为承担法律责任。若您为限制行为能力或无行为能力者，则您的法定监护人应承担相应的法律责任。\n三、免责声明\n3.1 您违反本注册协议、违反道德或法律的，侵犯他人权利（包括但不限于知识产权）的，我们不承担任何责任。同时，我们对任何第三方通过花钱无忧APP发送服务或包含在服务中的任何内容不承担责任。\n3.2 因任何非花钱无忧APP原因造成的网络服务中断或其他缺陷，我们不承担任何责任。\n3.3 我们不保证服务一定能满足您的要求；不保证服务不会中断，也不保证服务的及时性、安全性、准确性。\n四、知识产权及其它权利\n4.1 未经相关内容权利人的事先书面同意，您不得擅自复制、传播在花钱无忧APP的内容，或将其用于任何商业目的，所有这些资料或资料的任何部分仅可作为个人或非商业用途而保存在某台计算机或其他电子设备内。否则，我们及/或权利人将追究您的法律责任。\n4.2 如有权利人发现您在花钱无忧APP发表的内容侵犯其权利，并依相关法律、行政法规的规定向我们发出书面通知的，我们有权在不事先通知您的情况下自行移除相关内容，并依法保留相关数据。您同意不因该种移除行为向我们主张任何赔偿，如我们因此遭受任何损失，您应向赔偿我们的损失（包括但不限于赔偿各种费用及律师费）。\n五、特别约定\n5.1 您使用本服务的行为若有任何违反国家法律法规或侵犯任何第三方的合法权益的情形时，我们有权直接删除该等违反规定之信息，并可以暂停或终止向您提供服务。\n5.2 若您利用花钱无忧APP服务从事任何违法或侵权行为，由您自行承担全部责任，因此给我们或任何第三方造成任何损失，您应负责全额赔偿，并使我们免受由此产生的任何损害。\n5.3 如您有任何有关与花钱无忧APP服务的个人信息保护相关投诉，请您与我们联系，我们将在接到投诉之日起15日内进行答复。\n5.4 本注册协议之效力、解释、执行均适用中华人民共和国法律。";
    }else{
        self.navigationItem.title = @"隐私政策";
        self.statementTextView.text = @"\n花钱无忧APP尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，花钱无忧APP会按照本隐私权政策的规定使用和披露您的个人信息。但花钱无忧APP将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，花钱无忧APP不会将这些信息对外披露或向第三方提供。花钱无忧APP会不时更新本隐私权政策。您在同意花钱无忧APP用户协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于花钱无忧APP用户协议不可分割的一部分。\n1. 适用范围\na) 在您注册花钱无忧APP帐号或使用花钱无忧APP的服务时，您根据花钱无忧APP要求提供的个人注册信息；\nb) 花钱无忧APP通过合法途径从商业伙伴处取得的用户个人数据。\n您了解并同意，以下信息不适用本隐私权政策：\na) 花钱无忧APP收集到的您在花钱无忧APP发布的有关信息数据；\nb) 违反法律规定或违反花钱无忧APP规则行为及花钱无忧APP已对您采取的措施。\n2. 信息使用\na) 花钱无忧APP不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和花钱无忧APP单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。\nb) 花钱无忧APP亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何花钱无忧APP平台用户如从事上述活动，一经发现，花钱无忧APP有权立即终止与该用户的服务协议。\nc) 为服务用户的目的，花钱无忧APP可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与花钱无忧APP合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。\n3. 信息披露\n在如下情况下，花钱无忧APP将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：\na) 经您事先同意，向第三方披露；\nb) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\nc) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\nd) 如您出现违反中国有关法律、法规或者花钱无忧APP服务协议或相关规则的情况，需要向第三方披露；\ne) 其它花钱无忧APP根据法律、法规或者网站政策认为合适的披露。\n4. 信息存储和交换\n花钱无忧APP收集的有关您的信息和资料将保存在花钱无忧APP的服务器上，这些信息和资料可能传送至您所在国家、地区或花钱无忧APP收集信息和资料所在地的境外并在境外被访问、存储和展示。\n5. 信息安全\na) 花钱无忧APP帐号均有安全保护功能，请妥善保管您的用户名及密码信息。花钱无忧APP将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。\nb) 在使用花钱无忧APP网络服务时，请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是花钱无忧APP用户名及密码发生泄露，请您立即联络花钱无忧APP客服，以便花钱无忧APP采取相应措施。";
    }
}

- (void)setIsXieYi:(BOOL)isXieYi{
    _isXieYi = isXieYi;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
