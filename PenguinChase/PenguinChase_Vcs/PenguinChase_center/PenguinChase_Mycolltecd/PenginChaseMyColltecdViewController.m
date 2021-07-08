//
//  PengUinChaseWatchedViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenginChaseMyColltecdViewController.h"
#import "PenguinChaseHomeTableViewCell.h"
#import "PenguinChaseVideoDetailViewController.h"
@interface PenginChaseMyColltecdViewController ()<PenguinChaseHomeTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * pengDataArr;
@end

@implementation PenginChaseMyColltecdViewController
- (NSMutableArray *)pengDataArr{
    if (!_pengDataArr) {
        _pengDataArr = [NSMutableArray array];
    }
    return _pengDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的收藏";
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)PenguinChaseHeaderClicks{
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class] where:[NSString stringWithFormat:@"isViews = '%@'",@(YES)]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.pengDataArr.count > 0) {
            [self.pengDataArr removeAllObjects];
        }
        self.pengDataArr = dataArr.mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pengDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseHomeTableViewCell * PenguinCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    PenguinCell.penguinModel = self.pengDataArr[indexPath.row];
    PenguinCell.delegate = self;
    PenguinCell.tag = indexPath.row;
    return PenguinCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * pengDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
    pengDetailVc.hidesBottomBarWhenPushed = YES;
    pengDetailVc.pengModel = self.pengDataArr[indexPath.row];
    [self.navigationController pushViewController:pengDetailVc animated:YES];
}
-(void)PenguinChaseHomeTableViewCellWithWantbtnAction:(NSInteger)btnIndex{
    PenguinChaseVideoModel * pengModel = self.pengDataArr[btnIndex];
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        pengModel.penguinChase_isColltecd  =!pengModel.penguinChase_isColltecd;
        [self.PenguinChaseTableView reloadData];
        [WHC_ModelSqlite update:[PenguinChaseVideoModel class] value:[NSString stringWithFormat:@"penguinChase_isColltecd ='%@'",@(pengModel.penguinChase_isColltecd)] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%ld'",pengModel.penguinChase_MoviewID]];
    });
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(120);
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

