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
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinChaseMyFallowViewController
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray array];
    }
    return _penguinDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的点赞";
    UIView * PenguinHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(10))];
    PenguinHeader.backgroundColor =[UIColor whiteColor];
    self.PenguinChaseTableView.tableHeaderView = PenguinHeader;
    self.PenguinChaseTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)PenguinHeaderClicks{
    
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseDongtaiModel class] where:[NSString stringWithFormat:@"isLike = '%@'",@(YES)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.penguinDataArr.count > 0) {
            [self.penguinDataArr removeAllObjects];
        }
        self.penguinDataArr = dataArr.mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiTableViewCell * penguinCell = [PenguinChaseDongtaiTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.delegate = self;
    penguinCell.tag = indexPath.row;
    penguinCell.pengModel = self.penguinDataArr[indexPath.row];
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiModel * pengMode = self.penguinDataArr[indexPath.row];
    return  pengMode.CellHeight;
}
#pragma mark--PenguinChaseDongtaiTableViewCellDelegate
-(void)PenguinChaseDongtaiTableViewCellWithBtnActionIndex:(NSInteger)btnIndex CellIndex:(NSInteger)cellIndex{
    PenguinChaseDongtaiModel * pengModle = self.penguinDataArr[cellIndex];
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
            
            [LCProgressHUD showLoading:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD showSuccess:@"拉黑成功"];
            [WHC_ModelSqlite  delete:[PenguinChaseDongtaiModel class] where:[NSString stringWithFormat:@"userID = '%ld'",pengModle.userID]];
                [self.penguinDataArr removeObject:pengModle];
                [self.PenguinChaseTableView reloadData];
            });

            
            
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
        PenguinListVc.pengModel = self.penguinDataArr[cellIndex];
        [self.navigationController pushViewController:PenguinListVc animated:YES];
    }else{
        pengModle.isLike  = !pengModle.isLike;
        [LCProgressHUD showLoading:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD hide];
            [self.PenguinChaseTableView reloadData];
            [WHC_ModelSqlite update:[PenguinChaseDongtaiModel class] value:[NSString stringWithFormat:@"isLike = '%@'",@(pengModle.isLike)] where:[NSString stringWithFormat:@"userID = '%ld'",pengModle.userID]];
        });
        
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
