//
//  PenguinGoodVideoViewController.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinGoodVideoViewController.h"
#import "PenguinChaseHomeTableViewCell.h"
#import "PenguinChaseVideoDetailViewController.h"
@interface PenguinGoodVideoViewController ()<PenguinChaseHomeTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinGoodVideoViewController
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray array];
    }
    return _penguinDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"甄选好片";
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(penguinGoodHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)penguinGoodHeaderClicks{
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.penguinDataArr.count > 0) {
            [self.penguinDataArr removeAllObjects];
        }
        self.penguinDataArr = [dataArr subarrayWithRange:NSMakeRange(dataArr.count - 15, 10)].mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];   
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseHomeTableViewCell * PenguinCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    PenguinCell.penguinModel = self.penguinDataArr[indexPath.row];
    PenguinCell.tag = indexPath.row;
    PenguinCell.delegate = self;
    return PenguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(120);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * pengDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
    pengDetailVc.hidesBottomBarWhenPushed = YES;
    pengDetailVc.pengModel = self.penguinDataArr[indexPath.row];
    [self.navigationController pushViewController:pengDetailVc animated:YES];
}
#pragma mark--PenguinChaseHomeTableViewCellDelegate
-(void)PenguinChaseHomeTableViewCellWithWantbtnAction:(NSInteger)btnIndex{
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
    
    PenguinChaseVideoModel * pengModel = self.penguinDataArr[btnIndex];
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        pengModel.penguinChase_isColltecd  =!pengModel.penguinChase_isColltecd;
        [self.PenguinChaseTableView reloadData];
        [WHC_ModelSqlite update:[PenguinChaseVideoModel class] value:[NSString stringWithFormat:@"penguinChase_isColltecd ='%@'",@(pengModel.penguinChase_isColltecd)] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%ld'",pengModel.penguinChase_MoviewID]];
    });}
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
