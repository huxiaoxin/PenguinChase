

#import "PenguinChase_MyInfoViewController.h"
#import "PenguinChaseMyInfoEditViewController.h"
#import "PenguinChaseMyinfoTableViewCell.h"
@interface PenguinChase_MyInfoViewController ()

@end

@implementation PenguinChase_MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle= @"编辑资料";
    self.PenguinChaseTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-RealWidth(100));
    
    UIButton * PenguinLogoinoutBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [PenguinLogoinoutBtn setFrame:CGRectMake(RealWidth(50), GK_SCREEN_HEIGHT-RealWidth(100), GK_SCREEN_WIDTH-RealWidth(100), RealWidth(40))];
    PenguinLogoinoutBtn.titleLabel.font = KBlFont(14);
    PenguinLogoinoutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [PenguinLogoinoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [PenguinLogoinoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PenguinLogoinoutBtn  setBackgroundColor:LGDMianColor];
    PenguinLogoinoutBtn.layer.cornerRadius = RealWidth(5);
    PenguinLogoinoutBtn.layer.masksToBounds = YES;
    [PenguinLogoinoutBtn addTarget:self action:@selector(PenguinLogoinoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PenguinLogoinoutBtn];
    // Do any additional setup after loading the view.
}
-(void)PenguinLogoinoutBtnClick{
    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PenguinChaseLoginoutNotiFication" object:nil];
        [LCProgressHUD hide];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PenguinLoginStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseMyinfoTableViewCell * PenguinCell = [PenguinChaseMyinfoTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    [PenguinCell PenguinChaseMyinfoTableViewCellConfiguarWithIndexPath:indexPath];
    PenguinCell.penguinChaseuserNamelb.text = [PenguinChaseLoginTool PenguinChasegetName];
    return PenguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [LCProgressHUD showInfoMsg:@"暂不支持修改头像！"];
    }else{
        PenguinChaseMyInfoEditViewController * PenguinVCs  = [[PenguinChaseMyInfoEditViewController alloc]init];
        MJWeakSelf;
        PenguinVCs.seltecdInfoBlock = ^{
            [weakSelf.PenguinChaseTableView reloadData];
        };
        PenguinVCs.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:PenguinVCs animated:YES];
    }
    
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

