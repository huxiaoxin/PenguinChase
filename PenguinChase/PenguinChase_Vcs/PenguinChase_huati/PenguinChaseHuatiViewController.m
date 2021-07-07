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
@interface PenguinChaseHuatiViewController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
@property(nonatomic,strong) PenguinChaseHuatiSearchView * PenguinChase_SearchView;
@property(nonatomic,strong) UITableView * PenguinSearchLeftTableView;
@property(nonatomic,strong) UITableView * PenguinSearchRightTableiew;
@property(nonatomic,strong) UIView      * PenguinVerticline;
@property(nonatomic,strong) NSMutableArray * PenguinLeftDataArr;
@end

@implementation PenguinChaseHuatiViewController
- (NSMutableArray *)PenguinLeftDataArr{
    if (!_PenguinLeftDataArr) {
        _PenguinLeftDataArr = [NSMutableArray array];
    }
    return _PenguinLeftDataArr;
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
            
            PYSearchViewController * pysearchVc = [PYSearchViewController searchViewControllerWithHotSearches:@[@"312312",@"3123",@"3123",@"1321"] searchBarPlaceholder:@"搜你所搜，看你搜看"];
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
    if ([searchText isEqualToString:@"速度与激情9"]) {
        searchID  = 0;
    }else if ([searchText isEqualToString:@"人之怒"]){
        searchID  = 17;
    }else if ([searchText isEqualToString:@"007:无暇赴死"]){
        searchID  = 22;
    }else if ([searchText isEqualToString:@"黑寡妇"]){
        searchID  = 20;
    }else {
        searchID  = 21;
    }
    MJWeakSelf;
    [searchViewController dismissViewControllerAnimated:NO completion:^{
        PenguinChaseSearchingViewController * pandaSearchVc = [[PenguinChaseSearchingViewController alloc]init];
        pandaSearchVc.searchContent = searchText;
        pandaSearchVc.searchID = searchID;
        pandaSearchVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:pandaSearchVc animated:YES];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.PenguinSearchLeftTableView) {
        return self.PenguinLeftDataArr.count;
    }
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.PenguinSearchLeftTableView) {
        PenguinHuatileftTableViewCell * penguinSearchCell = [PenguinHuatileftTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        penguinSearchCell.pengModel = self.PenguinLeftDataArr[indexPath.row];
        return penguinSearchCell;
    }else{
        PenguinHuatiRigthTableViewCell * penguinRightCell = [PenguinHuatiRigthTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
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
