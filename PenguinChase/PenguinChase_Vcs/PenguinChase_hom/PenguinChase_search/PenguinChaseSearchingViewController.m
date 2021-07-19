//
//  PenguinChaseSearchingViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinChaseSearchingViewController.h"
#import "PenguinChaseHomeTableViewCell.h"
#import "PenguinChaseVideoDetailViewController.h"
@interface PenguinChaseSearchingViewController ()<PenguinChaseHomeTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinChaseSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"搜索结果";
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%ld'",self.searchID]];
        self.penguinDataArr =dataArr.mutableCopy;
        [self.PenguinChaseTableView reloadData];
    });
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray array];
    }
    return _penguinDataArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseHomeTableViewCell * PenguinCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    PenguinCell.penguinModel =self.penguinDataArr[indexPath.row];
    PenguinCell.tag = indexPath.row;
    PenguinCell.delegate = self;
    return PenguinCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * pengDetailVc =[[PenguinChaseVideoDetailViewController alloc]init];
    pengDetailVc.pengModel = self.penguinDataArr[indexPath.row];
    pengDetailVc.hidesBottomBarWhenPushed = YES;
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
