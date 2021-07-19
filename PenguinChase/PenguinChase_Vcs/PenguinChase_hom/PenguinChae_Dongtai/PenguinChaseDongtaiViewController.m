//
//  PenguinChaseDongtaiViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseDongtaiViewController.h"
#import "PenguinCase_GoodVideoHeaderView.h"
#import "PenguinChaseDongtaiTableViewCell.h"
#import "PenguinChaseComentListViewController.h"
#import "PenguinChaseJubaoLitsViewController.h"
#import "PenguinChaseDongtaiModel.h"
#import "PenguinChaseMessageDetailViewController.h"
#import "PenguinChaseFabuViewController.h"
@interface PenguinChaseDongtaiViewController ()<PenguinChaseDongtaiTableViewCellDelegate>
@property(nonatomic,strong) PenguinCase_GoodVideoHeaderView * PenguinHeader;
@property(nonatomic,strong) NSMutableArray * PenguinDongtaiDataArr;

@end

@implementation PenguinChaseDongtaiViewController
- (NSMutableArray *)PenguinDongtaiDataArr{
    if (!_PenguinDongtaiDataArr) {
        _PenguinDongtaiDataArr = [NSMutableArray array];
    }
    return _PenguinDongtaiDataArr;
}
-(void)PenguinLoginSuccedNotiFication{
    [self PenguinChaseTableViewHeaderClicks];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navBarAlpha = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PenguinLoginSuccedNotiFication) name:@"PenguinLoginSuccedNotiFication" object:nil];

    self.PenguinChaseTableView.frame = CGRectMake(0, GK_IS_iPhoneX ? GK_STATUSBAR_HEIGHT : 0, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_SAFEAREA_BTM- (GK_IS_iPhoneX ? GK_STATUSBAR_HEIGHT: 0));
    self.PenguinChaseTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseTableViewHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    self.PenguinChaseTableView.tableHeaderView = self.PenguinHeader;
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(GK_SCREEN_WIDTH-40, GK_STATUSBAR_HEIGHT+10, 40, 40)];
    rightView.userInteractionEnabled  = YES;
    UIButton * sendrightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    [sendrightbtn setImage:[UIImage imageNamed:@"fabu_dongtai"] forState:UIControlStateNormal];
    [sendrightbtn addTarget:self action:@selector(sendrightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:sendrightbtn];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    // Do any additional setup after loading the view.
}
-(void)sendrightbtnClick{
    PenguinChaseFabuViewController  * PenguinVCs = [[PenguinChaseFabuViewController alloc]init];
    
    UINavigationController * nav = [UINavigationController rootVC:PenguinVCs translationScale:YES];
    
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)PenguinChaseTableViewHeaderClicks{
    
    NSArray * TempArr = [WHC_ModelSqlite query:[PenguinChaseDongtaiModel class]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.PenguinDongtaiDataArr.count > 0) {
            [self.PenguinDongtaiDataArr removeAllObjects];
        }
        self.PenguinDongtaiDataArr = TempArr.mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.PenguinChaseTableView reloadData];
        });
    });
}

- (PenguinCase_GoodVideoHeaderView *)PenguinHeader{
    if (!_PenguinHeader) {
        _PenguinHeader = [[PenguinCase_GoodVideoHeaderView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(170+30))];
    }
    return _PenguinHeader;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PenguinDongtaiDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiTableViewCell * penguinCell = [PenguinChaseDongtaiTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.delegate = self;
    penguinCell.tag = indexPath.row;
    penguinCell.pengModel = self.PenguinDongtaiDataArr[indexPath.row];
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiModel * dongtaiModel = self.PenguinDongtaiDataArr[indexPath.row];
    return  dongtaiModel.CellHeight;
}
#pragma mark--PenguinChaseDongtaiTableViewCellDelegate
-(void)PenguinChaseDongtaiTableViewCellWithBtnActionIndex:(NSInteger)btnIndex CellIndex:(NSInteger)cellIndex{
    PenguinChaseDongtaiModel * pengModel = self.PenguinDongtaiDataArr[cellIndex];
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
            if ([FilmFactoryAccountComponent checkLogin:YES]) {
            
            [LCProgressHUD showLoading:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD showSuccess:@"拉黑成功"];
            [WHC_ModelSqlite  delete:[PenguinChaseDongtaiModel class] where:[NSString stringWithFormat:@"userID = '%ld'",pengModel.userID]];
                [self.PenguinDongtaiDataArr removeObject:pengModel];
                [self.PenguinChaseTableView reloadData];
            });
            }
        }];
        UIAlertAction *penguinCancleAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [penguinAlterVc addAction:penguinLaheiAction];
        [penguinAlterVc addAction:penguinJubaoAction];
        [penguinAlterVc addAction:penguinCancleAction];

        [self presentViewController:penguinAlterVc animated:YES completion:nil];
        
    }else if (btnIndex == 1){

        PenguinChaseComentListViewController * PenguinListVc  =[[PenguinChaseComentListViewController alloc]init];
        PenguinListVc.pengModel = self.PenguinDongtaiDataArr[cellIndex];
        PenguinListVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:PenguinListVc animated:YES];
    }else{
        if ([FilmFactoryAccountComponent checkLogin:YES]) {
        pengModel.isLike  = !pengModel.isLike;
        [LCProgressHUD showLoading:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD hide];
            [self.PenguinChaseTableView reloadData];
            [WHC_ModelSqlite update:[PenguinChaseDongtaiModel class] value:[NSString stringWithFormat:@"isLike = '%@'",@(pengModel.isLike)] where:[NSString stringWithFormat:@"userID = '%ld'",pengModel.userID]];
        });}
    }
}
-(void)PenguinChaseDongtaiTableViewCellWithChatCellIndex:(NSInteger)CellIndex{
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
    PenguinChaseDongtaiModel * dongtModel = self.PenguinDongtaiDataArr[CellIndex];
    PenguinChatMessageListModel *listModle = [[PenguinChatMessageListModel alloc]init];
    listModle.userID = dongtModel.userID;
    listModle.headerimgurl = dongtModel.headerImgurl;
    listModle.username = dongtModel.userName;
    PenguinChaseMessageDetailViewController * penguinChatVc = [[PenguinChaseMessageDetailViewController alloc]init];
    penguinChatVc.penguinChaseModel = listModle;
        [self.navigationController pushViewController:penguinChatVc animated:YES];}
    
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
