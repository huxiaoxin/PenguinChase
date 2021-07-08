//
//  PenguinChaseHomeViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseHomeViewController.h"
#import "PenguinChaseHomHeaderView.h"
#import "PenguinChaseHomeTableViewCell.h"
#import "PenguinChaseHomeFooterView.h"
#import "PenguinChaseHomeNewsViewController.h"
#import "PenguinChaseDongtaiViewController.h"
#import "PenguinChaseVideoDetailViewController.h"
#import "PenguinChaseKefuViewController.h"
#import "PenguinChaseBangdanViewController.h"
#import "PenguinGoodVideoViewController.h"
#import "PenguinChaseKefuViewController.h"
#import "PenguinChaseNotificationViewController.h"
#import "PenguinChaseSearchingViewController.h"
#import <PYSearch-umbrella.h>
@interface PenguinChaseHomeViewController ()<PenguinChaseHomHeaderViewDelegate,PYSearchViewControllerDelegate,PenguinChaseHomeFooterViewDelegate,PenguinChaseHomeTableViewCellDelegate>
@property(nonatomic,strong) PenguinChaseHomHeaderView  * PenguinChaseHeader;
@property(nonatomic,strong) PenguinChaseHomeFooterView * PenguinChaseFooter;
@property(nonatomic,strong) NSMutableArray * PenguinDataArr;
@end

@implementation PenguinChaseHomeViewController

- (NSMutableArray *)PenguinDataArr{
    if (!_PenguinDataArr) {
        _PenguinDataArr = [NSMutableArray array];
    }
    return _PenguinDataArr;
}
-(void)PenguinLoginSuccedNotiFication{
    [LCProgressHUD showLoading:@""];
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        if (dataArr.count > 0) {
            self.PenguinDataArr = [dataArr subarrayWithRange:NSMakeRange(3, 4)].mutableCopy;
            [self.PenguinChaseTableView reloadData];
            [self.PenguinChaseTableView.mj_header endRefreshing];
            self.PenguinChaseFooter.PenguinFooterDataArr = [dataArr subarrayWithRange:NSMakeRange(8, 4)].mutableCopy;
            self.PenguinChaseHeader.BannerImgArr = [dataArr subarrayWithRange:NSMakeRange(12, 2)];
        }
        
        
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navLineHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PenguinLoginSuccedNotiFication) name:@"PenguinLoginSuccedNotiFication" object:nil];
    [self.PenguinChaseTableView setFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT-GK_TABBAR_HEIGHT)];
    self.PenguinChaseTableView.tableHeaderView = self.PenguinChaseHeader;
    self.PenguinChaseTableView.tableFooterView = self.PenguinChaseFooter;
    MJWeakSelf;
    self.PenguinChaseHeader.headerBlock = ^(CGFloat headerHeight) {
        weakSelf.PenguinChaseHeader.height = headerHeight;
        weakSelf.PenguinChaseTableView.tableHeaderView = weakSelf.PenguinChaseHeader;
    };
    self.PenguinChaseFooter.FooterBlock = ^(CGFloat FooterHeight) {
        weakSelf.PenguinChaseFooter.height = FooterHeight;
        weakSelf.PenguinChaseTableView.tableFooterView = weakSelf.PenguinChaseFooter;
    };
    
    UIView * PenguinRightMessageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RealWidth(50), RealWidth(50))];    
    UIButton * PenguinMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PenguinMessageBtn setFrame:CGRectMake(RealWidth(10), RealWidth(15), RealWidth(20), RealWidth(20))];
    [PenguinMessageBtn setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
    [PenguinMessageBtn addTarget:self action:@selector(PenguinMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PenguinRightMessageView addSubview:PenguinMessageBtn];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinRightMessageView];
    
    
    
    
    UIView * PenguinLeftLogoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RealWidth(150), RealWidth(50))];
    UIImageView * PenguinLogoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(RealWidth(15), RealWidth(10), RealWidth(25), RealWidth(25))];
    PenguinLogoImgView.image = [UIImage imageNamed:@"whitelogo"];
    [PenguinLeftLogoView addSubview:PenguinLogoImgView];
    
    UILabel * PenguinLeftLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(PenguinLogoImgView.frame)+RealWidth(5), RealWidth(20), RealWidth(200), RealWidth(15))];
    PenguinLeftLb.textColor = LGDBLackColor;
    PenguinLeftLb.font = [UIFont boldSystemFontOfSize:18];
    PenguinLeftLb.text = @"企鹅追剧";
    [PenguinLeftLogoView addSubview:PenguinLeftLb];
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinLeftLogoView];
    
    [LCProgressHUD showLoading:@""];
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        if (dataArr.count > 0) {
            if (dataArr.count > 8) {
                self.PenguinDataArr = [dataArr subarrayWithRange:NSMakeRange(3, 4)].mutableCopy;
            }
            [self.PenguinChaseTableView reloadData];
            [self.PenguinChaseTableView.mj_header endRefreshing];
            if (dataArr.count > 15) {
                self.PenguinChaseFooter.PenguinFooterDataArr = [dataArr subarrayWithRange:NSMakeRange(8, 4)].mutableCopy;
                self.PenguinChaseHeader.BannerImgArr = [dataArr subarrayWithRange:NSMakeRange(12, 2)];
            }
            
        }
        
        
    });
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PenguinChaseHomeTableViewCell * penguinHomeCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinHomeCell.penguinModel = self.PenguinDataArr[indexPath.row];
    penguinHomeCell.tag = indexPath.row;
    penguinHomeCell.delegate = self;
    return penguinHomeCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PenguinDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(120);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * penguinChaseDetailVc  = [[PenguinChaseVideoDetailViewController alloc]init];
    penguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    penguinChaseDetailVc.pengModel = self.PenguinDataArr[indexPath.row];
    [self.navigationController pushViewController:penguinChaseDetailVc animated:YES];
}
#pragma mark--消息
-(void)PenguinMessageBtnClick{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;;
    }
    PenguinChaseNotificationViewController * penguinMsgVc = [[PenguinChaseNotificationViewController alloc]init];
    penguinMsgVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinMsgVc animated:YES];
}
-(PenguinChaseHomHeaderView *)PenguinChaseHeader{
    if (!_PenguinChaseHeader) {
        _PenguinChaseHeader = [[PenguinChaseHomHeaderView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(150))];
        _PenguinChaseHeader.delegate = self;
        
    }
    return _PenguinChaseHeader;
}
- (PenguinChaseHomeFooterView *)PenguinChaseFooter{
    if (!_PenguinChaseFooter) {
        _PenguinChaseFooter = [[PenguinChaseHomeFooterView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(10))];
        _PenguinChaseFooter.delegate = self;
    }
    return _PenguinChaseFooter;
}
#pragma mark--PenguinChaseHomHeaderViewDelegate
-(void)PenguinChaseHomHeaderViewBtnsAction:(NSInteger)btnInex{
    
    if (btnInex == 0) {
        PenguinChaseBangdanViewController * penguinChaseBangdanVc = [[PenguinChaseBangdanViewController alloc]init];
        penguinChaseBangdanVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinChaseBangdanVc animated:YES];
    }else if (btnInex == 1){
        
        PenguinGoodVideoViewController * penguinGoodVc =[[PenguinGoodVideoViewController alloc]init];
        penguinGoodVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinGoodVc animated:YES];
    }else if (btnInex == 2){
        PenguinChaseHomeNewsViewController * penguinNewsVc = [[PenguinChaseHomeNewsViewController alloc]init];
        penguinNewsVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinNewsVc animated:YES];
    }else if (btnInex == 3){
        if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
            [self PenguinChase_showLoginVc];
            return;;
        }
        PenguinChaseKefuViewController * penguinKefuVc = [[PenguinChaseKefuViewController alloc]init];
        penguinKefuVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinKefuVc animated:YES];
    }
}
-(void)PenguinChaseHomHeaderViewWithSDCBannerIndex:(PenguinChaseVideoModel *)viewModel{
    PenguinChaseVideoDetailViewController * penguinChaseDetailVc  = [[PenguinChaseVideoDetailViewController alloc]init];
    penguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    penguinChaseDetailVc.pengModel = viewModel;
    [self.navigationController pushViewController:penguinChaseDetailVc animated:YES];
}
#pragma mark--动态
-(void)PenguinChaseHomHeaderViewWithClanderActions{
    
    PenguinChaseDongtaiViewController * penguinDongtaVc = [[PenguinChaseDongtaiViewController alloc]init];
    penguinDongtaVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinDongtaVc animated:YES];
    
}
#pragma mark--PenguinChaseHomeTableViewCellDelegate
-(void)PenguinChaseHomeTableViewCellWithWantbtnAction:(NSInteger)btnIndex{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    
    PenguinChaseVideoModel * pengModel = self.PenguinDataArr[btnIndex];
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        pengModel.penguinChase_isColltecd  =!pengModel.penguinChase_isColltecd;
        [self.PenguinChaseTableView reloadData];
        [WHC_ModelSqlite update:[PenguinChaseVideoModel class] value:[NSString stringWithFormat:@"penguinChase_isColltecd ='%@'",@(pengModel.penguinChase_isColltecd)] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%ld'",pengModel.penguinChase_MoviewID]];
    });
}
#pragma mark--搜索
-(void)PenguinChaseHomHeaderViewSearchAction{
    PYSearchViewController * pysearchVc = [PYSearchViewController searchViewControllerWithHotSearches:@[@"明日之战",@"鬼灭之刃",@"机动战士高达",@"普吉岛的最后黄昏"] searchBarPlaceholder:@"搜你所搜，看你搜看"];
    pysearchVc.hotSearchStyle =PYHotSearchStyleColorfulTag;
    pysearchVc.delegate = self;
    UITableView * baseSearchTableView  = [pysearchVc valueForKey:@"baseSearchTableView"];
    baseSearchTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT - GK_STATUSBAR_NAVBAR_HEIGHT);
    
    UINavigationController * PysearchNav =  [UINavigationController rootVC:pysearchVc translationScale:YES];
    [self presentViewController:PysearchNav animated:YES completion:nil];
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
        PenguinChaseSearchingViewController * PengyinSeasSearchVc = [[PenguinChaseSearchingViewController alloc]init];
        PengyinSeasSearchVc.searchContent = searchText;
        PengyinSeasSearchVc.searchID = searchID;
        PengyinSeasSearchVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:PengyinSeasSearchVc animated:YES];
    }];
    
}
-(void)PenguinChaseHomeFooterViewWithColltecDidSeltecd:(PenguinChaseVideoModel *)pengModel{
    
    PenguinChaseVideoDetailViewController * penguinChaseDetailVc  = [[PenguinChaseVideoDetailViewController alloc]init];
    penguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    penguinChaseDetailVc.pengModel = pengModel;
    [self.navigationController pushViewController:penguinChaseDetailVc animated:YES];
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
