//
//  PenguinChaseHuatiViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseHuatiViewController.h"
#import "PenguinChaseHuatiSearchView.h"
#import "PenguinHuatileftTableViewCell.h"
#import "PenguinHuatiRigthTableViewCell.h"
#import "PenguinChaseSearchingViewController.h"
#import <PYSearch-umbrella.h>
#import "PenguinHuatiLeftMoel.h"
#import <LYEmptyView-umbrella.h>
#import "PenguinChaseVideoDetailViewController.h"
@interface PenguinChaseHuatiViewController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
@property(nonatomic,strong) PenguinChaseHuatiSearchView * PenguinChase_SearchView;
@property(nonatomic,strong) UITableView * PenguinSearchLeftTableView;
@property(nonatomic,strong) UITableView * PenguinSearchRightTableiew;
@property(nonatomic,strong) UIView      * PenguinVerticline;
@property(nonatomic,strong) NSMutableArray * PenguinLeftDataArr;
@property(nonatomic,strong) NSMutableArray * PenguinRightDataArr;

@end

@implementation PenguinChaseHuatiViewController
- (NSMutableArray *)PenguinLeftDataArr{
    if (!_PenguinLeftDataArr) {
        _PenguinLeftDataArr = [NSMutableArray array];
    }
    return _PenguinLeftDataArr;
}
- (NSMutableArray *)PenguinRightDataArr{
    if (!_PenguinRightDataArr) {
        _PenguinRightDataArr =[NSMutableArray array];
    }
    return _PenguinRightDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"全部分类";
    self.gk_navLineHidden = YES;
    [self.view addSubview:self.PenguinChase_SearchView];
    [self.view addSubview:self.PenguinSearchLeftTableView];
    [self.view addSubview:self.PenguinVerticline];
    [self.view addSubview:self.PenguinSearchRightTableiew];

    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        NSArray * leftDataArr = [WHC_ModelSqlite query:[PenguinHuatiLeftMoel class]];
        if (self.PenguinLeftDataArr.count > 0) {
            [self.PenguinLeftDataArr removeAllObjects];
        }
        self.PenguinLeftDataArr = leftDataArr.mutableCopy;
        [self.PenguinSearchLeftTableView reloadData];
        NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
        self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(5, 10)].mutableCopy;
        [self.PenguinSearchRightTableiew reloadData];
    });
    
    // Do any additional setup after loading the view.
}
-(void)PenguinSearcleftHeaderCloikcs{

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray * leftDataArr = [WHC_ModelSqlite query:[PenguinHuatiLeftMoel class]];
        if (self.PenguinLeftDataArr.count > 0) {
            [self.PenguinLeftDataArr removeAllObjects];
        }
        self.PenguinLeftDataArr = leftDataArr.mutableCopy;
        [self.PenguinSearchLeftTableView reloadData];
        [self.PenguinSearchLeftTableView.mj_header endRefreshing];
    });
}
- (UITableView *)PenguinSearchLeftTableView{
    if (!_PenguinSearchLeftTableView) {
        _PenguinSearchLeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_PenguinChase_SearchView.frame)+RealWidth(10), RealWidth(80), GK_SCREEN_HEIGHT-CGRectGetMaxY(_PenguinChase_SearchView.frame)-GK_TABBAR_HEIGHT-RealWidth(10)) style:UITableViewStylePlain];
        _PenguinSearchLeftTableView.showsVerticalScrollIndicator = NO;
        _PenguinSearchLeftTableView.showsHorizontalScrollIndicator = NO;
        _PenguinSearchLeftTableView.backgroundColor = [UIColor whiteColor];
        _PenguinSearchLeftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchLeftTableView.delegate = self;
        _PenguinSearchLeftTableView.dataSource = self;
        _PenguinSearchLeftTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinSearcleftHeaderCloikcs)];
    }
    return _PenguinSearchLeftTableView;
}
- (UITableView *)PenguinSearchRightTableiew{
    if (!_PenguinSearchRightTableiew) {
        _PenguinSearchRightTableiew = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinVerticline.frame), CGRectGetMaxY(_PenguinChase_SearchView.frame)+RealWidth(10), GK_SCREEN_WIDTH-CGRectGetMaxX(_PenguinVerticline.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_PenguinChase_SearchView.frame)-GK_TABBAR_HEIGHT-RealWidth(10)) style:UITableViewStylePlain];
        _PenguinSearchRightTableiew.showsVerticalScrollIndicator = NO;
        _PenguinSearchRightTableiew.showsHorizontalScrollIndicator = NO;
        _PenguinSearchRightTableiew.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchRightTableiew.backgroundColor = [UIColor clearColor];
        _PenguinSearchRightTableiew.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchRightTableiew.delegate = self;
        _PenguinSearchRightTableiew.dataSource = self;
    }
    return _PenguinSearchRightTableiew;
}
- (UIView *)PenguinVerticline{
    if (!_PenguinVerticline) {
        _PenguinVerticline = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinSearchLeftTableView.frame), CGRectGetMinY(_PenguinSearchLeftTableView.frame), 0.9, CGRectGetHeight(_PenguinSearchLeftTableView.frame))];
        _PenguinVerticline.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinVerticline;
}
- (PenguinChaseHuatiSearchView *)PenguinChase_SearchView{
    if (!_PenguinChase_SearchView) {
        MJWeakSelf;
        _PenguinChase_SearchView = [[PenguinChaseHuatiSearchView alloc]initWithFrame:CGRectMake(RealWidth(15), GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH-RealWidth(30), RealWidth(30)) SearchTapAction:^{
            
            PYSearchViewController * pysearchVc = [PYSearchViewController searchViewControllerWithHotSearches:@[@"明日之战",@"鬼灭之刃",@"机动战士高达",@"普吉岛的最后黄昏"] searchBarPlaceholder:@"搜你所搜，看你搜看"];
            pysearchVc.hotSearchStyle =PYHotSearchStyleColorfulTag;
            pysearchVc.delegate = self;
            UITableView * baseSearchTableView  = [pysearchVc valueForKey:@"baseSearchTableView"];
            baseSearchTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT - GK_STATUSBAR_NAVBAR_HEIGHT);
            
            UINavigationController * PysearchNav =  [UINavigationController rootVC:pysearchVc translationScale:YES];
            [weakSelf presentViewController:PysearchNav animated:YES completion:nil];
            
        }];
        
    }
    return _PenguinChase_SearchView;
}
- (void)searchViewController:(PYSearchViewController *)searchViewController
      didSearchWithSearchBar:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText{
    
    NSInteger searchID;
    if ([searchText isEqualToString:@"明日之战"]) {
        searchID  = 0;
    }else if ([searchText isEqualToString:@"鬼灭之刃"]){
        searchID  = 12;
    }else if ([searchText isEqualToString:@"机动战士高达"]){
        searchID  = 13;
    }else if ([searchText isEqualToString:@"普吉岛的最后黄昏"]){
        searchID  = 14;
    }else {
        searchID  = 21;
    }
    MJWeakSelf;
    [searchViewController dismissViewControllerAnimated:NO completion:^{
        PenguinChaseSearchingViewController * PenguinSeachVc = [[PenguinChaseSearchingViewController alloc]init];
        PenguinSeachVc.searchContent = searchText;
        PenguinSeachVc.searchID = searchID;
        PenguinSeachVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:PenguinSeachVc animated:YES];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.PenguinSearchLeftTableView) {
        return self.PenguinLeftDataArr.count;
    }else{
        return self.PenguinRightDataArr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.PenguinSearchLeftTableView) {
        PenguinHuatileftTableViewCell * penguinSearchCell = [PenguinHuatileftTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        penguinSearchCell.pengModel = self.PenguinLeftDataArr[indexPath.row];
        return penguinSearchCell;
    }else{
        PenguinHuatiRigthTableViewCell * penguinRightCell = [PenguinHuatiRigthTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        penguinRightCell.pengModel = self.PenguinRightDataArr[indexPath.row];
        return penguinRightCell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView  == self.PenguinSearchLeftTableView) {
        for (PenguinHuatiLeftMoel * model in self.PenguinLeftDataArr) {
            model.isSeltecd = NO;
        }
        PenguinHuatiLeftMoel * pengModel = self.PenguinLeftDataArr[indexPath.row];
        pengModel.isSeltecd = YES;
        [self.PenguinSearchLeftTableView reloadData];
        
        
        [LCProgressHUD showLoading:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [LCProgressHUD hide];
            NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
            if (self.PenguinRightDataArr.count > 0) {
                [self.PenguinRightDataArr removeAllObjects];
            }
            if (pengModel.typeID == 0) {
                NSMutableArray * tempArr =[NSMutableArray array];
                for (PenguinChaseVideoModel  * model in dataArr) {
                    if (model.penguinChase_isColltecd) {
                        [tempArr addObject:model];
                    }
                }
                if ([PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
                    
                    self.PenguinRightDataArr = tempArr.mutableCopy;

                    if (tempArr.count == 0) {
                        LYEmptyView * emtView = [LYEmptyView emptyViewWithImage:nil titleStr:@"暂无数据!" detailStr:nil];
                        self.PenguinSearchRightTableiew.ly_emptyView = emtView;
                    }
                    
                }else{
                    LYEmptyView * emtyView = [LYEmptyView emptyViewWithImage:nil titleStr:@"未登录" detailStr:nil];
                    self.PenguinSearchRightTableiew.ly_emptyView = emtyView;
                }
            }else if (pengModel.typeID == 1){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(5, 10)].mutableCopy;
            }else if (pengModel.typeID == 2){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(10, 10)].mutableCopy;
            }else if (pengModel.typeID == 3){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(5, 4)].mutableCopy;

            }else if (pengModel.typeID == 4){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(6, 8)].mutableCopy;

            }else if (pengModel.typeID == 5){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(5, 6)].mutableCopy;

            }else if (pengModel.typeID == 6){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(3, 7)].mutableCopy;

            }else if (pengModel.typeID == 7){
                self.PenguinRightDataArr = [dataArr subarrayWithRange:NSMakeRange(4, 9)].mutableCopy;

            }
            [self.PenguinSearchRightTableiew scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            [self.PenguinSearchRightTableiew reloadData];
        });

    }else{
        PenguinChaseVideoDetailViewController *  penguinDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
        penguinDetailVc.pengModel = self.PenguinRightDataArr[indexPath.row];
        penguinDetailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinDetailVc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.PenguinSearchLeftTableView) {
        return RealWidth(40);
    }else{
        return RealWidth(145);
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
