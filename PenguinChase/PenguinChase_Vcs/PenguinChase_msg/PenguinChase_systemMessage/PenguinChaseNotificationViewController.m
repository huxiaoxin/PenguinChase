
#import "PenguinChaseNotificationViewController.h"
#import "PenguinChaseVideoNotiCationTableViewCell.h"
#import "PenguinChaseNotifiCationDetailViewController.h"
@interface PenguinChaseNotificationViewController ()
@property(nonatomic,assign) BOOL  isLoads;
@end

@implementation PenguinChaseNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLoads =  NO;
    self.gk_navTitle = @"我的消息";
    self.view.backgroundColor = LGDLightGaryColor;
    [self.PenguinChaseTableView setFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT-GK_SAFEAREA_BTM)];
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseNotiHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)PenguinChaseNotiHeaderClicks{
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.isLoads = YES;
        [self.PenguinChaseTableView.mj_header endRefreshing];
        [self.PenguinChaseTableView reloadData];
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isLoads ? 1 : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoNotiCationTableViewCell * PenguinChaseCell = [PenguinChaseVideoNotiCationTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return PenguinChaseCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(100);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseNotifiCationDetailViewController * PenguinChaseDetailVc = [[PenguinChaseNotifiCationDetailViewController alloc]init];
    PenguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:PenguinChaseDetailVc animated:YES];
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
