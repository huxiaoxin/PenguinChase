//
//  PenguinChaseMyFallowViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinChaseMyFallowViewController.h"
#import "PenguinChaseJubaoLitsViewController.h"
#import "PenguinChaseComentListViewController.h"
#import "PenguinChaseDongtaiTableViewCell.h"
@interface PenguinChaseMyFallowViewController ()<PenguinChaseDongtaiTableViewCellDelegate>

@end

@implementation PenguinChaseMyFallowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的点赞";
    UIView * PenguinHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(10))];
    PenguinHeader.backgroundColor =[UIColor whiteColor];
    self.PenguinChaseTableView.tableHeaderView = PenguinHeader;
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiTableViewCell * penguinCell = [PenguinChaseDongtaiTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.delegate = self;
    penguinCell.tag = indexPath.row;
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  RealWidth(350);
}
#pragma mark--PenguinChaseDongtaiTableViewCellDelegate
-(void)PenguinChaseDongtaiTableViewCellWithBtnActionIndex:(NSInteger)btnIndex CellIndex:(NSInteger)cellIndex{
    if (btnIndex == 0) {
        
        UIAlertController * penguinAlterVc = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        MJWeakSelf;
        UIAlertAction *penguinLaheiAction  = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[GKNavigationBarConfigure sharedInstance] updateConfigure:^(GKNavigationBarConfigure *configure) {
                configure.backStyle  =GKNavigationBarBackStyleBlack;
            }];
            PenguinChaseJubaoLitsViewController * penguinJubaoVc = [[PenguinChaseJubaoLitsViewController alloc]init];
            penguinJubaoVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:penguinJubaoVc animated:YES];
        }];
        
        
        UIAlertAction *penguinJubaoAction  = [UIAlertAction actionWithTitle:@"拉黑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *penguinCancleAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [penguinAlterVc addAction:penguinLaheiAction];
        [penguinAlterVc addAction:penguinJubaoAction];
        [penguinAlterVc addAction:penguinCancleAction];

        [self presentViewController:penguinAlterVc animated:YES completion:nil];
        
    }else if (btnIndex == 1){

        PenguinChaseComentListViewController * PenguinListVc  =[[PenguinChaseComentListViewController alloc]init];
        PenguinListVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:PenguinListVc animated:YES];
    }else{
        
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
