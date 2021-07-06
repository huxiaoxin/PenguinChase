

#import "PenguinChaseNotifiCationDetailViewController.h"

@interface PenguinChaseNotifiCationDetailViewController ()

@end

@implementation PenguinChaseNotifiCationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.gk_navTitle = @"详情";
    
    UILabel * PenguinChaseTitlelb = [[UILabel alloc]initWithFrame:CGRectMake(0, K(10)+GK_STATUSBAR_NAVBAR_HEIGHT, SCREEN_Width, K(18))];
    PenguinChaseTitlelb.textAlignment = NSTextAlignmentCenter;
    PenguinChaseTitlelb.font = [UIFont systemFontOfSize:K(15)];
    PenguinChaseTitlelb.text=  @"关于7月29号熊猫追剧维护公告";
    [self.view addSubview:PenguinChaseTitlelb];
    
    CGRect PenguinChaseTitleRect = [@"尊敬的用户，您好～！\n因服务器升级需要，熊猫追剧将于2021年6月29号服务器停机进行升级，届时app将无法访问大概有半个小时左右，还请大家稍安伪造等待一下，感谢各位的配合与支持，谢谢～" cxl_sizeWithMoreString:[UIFont systemFontOfSize:14] maxWidth:SCREEN_Width-K(20)];
    UILabel * PenguinChaseTitleDetailb =[[UILabel alloc]initWithFrame:CGRectMake(K(10), CGRectGetMaxY(PenguinChaseTitlelb.frame)+K(10), PenguinChaseTitleRect.size.width, PenguinChaseTitleRect.size.height)];
    PenguinChaseTitleDetailb.numberOfLines = 0;
    PenguinChaseTitleDetailb.font = [UIFont systemFontOfSize:14];
    PenguinChaseTitleDetailb.textColor = LGDLightBLackColor;
    PenguinChaseTitleDetailb.text = @"尊敬的用户，您好～！\n因服务器升级需要，，熊猫追剧将于2021年6月25号服务器停机进行升级，届时app将无法访问大概有半个小时左右，还请大家稍安伪造等待一下，感谢各位的配合与支持，谢谢～";
    [self.view addSubview:PenguinChaseTitleDetailb];
    
    UILabel *  PenguinChaseTitleDeeplb = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-K(130), CGRectGetMaxY(PenguinChaseTitleDetailb.frame)+K(10), K(120), K(14))];
    PenguinChaseTitleDeeplb.textAlignment = NSTextAlignmentRight;
    PenguinChaseTitleDeeplb.font = [UIFont systemFontOfSize:12];
    PenguinChaseTitleDeeplb.textColor =LGDLightBLackColor;
    PenguinChaseTitleDeeplb.text = @"熊猫追剧";
    [self.view addSubview:PenguinChaseTitleDeeplb];
    

    // Do any additional setup after loading the view.
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

