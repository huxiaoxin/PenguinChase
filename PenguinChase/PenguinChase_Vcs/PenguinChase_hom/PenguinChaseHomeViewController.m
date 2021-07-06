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
@interface PenguinChaseHomeViewController ()<PenguinChaseHomHeaderViewDelegate,PYSearchViewControllerDelegate>
@property(nonatomic,strong) PenguinChaseHomHeaderView  * PenguinChaseHeader;
@property(nonatomic,strong) PenguinChaseHomeFooterView * PenguinChaseFooter;
@end

@implementation PenguinChaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navLineHidden = YES;

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
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PenguinChaseHomeTableViewCell * penguinHomeCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return penguinHomeCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(120);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * penguinChaseDetailVc  = [[PenguinChaseVideoDetailViewController alloc]init];
    penguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinChaseDetailVc animated:YES];
}
#pragma mark--消息
-(void)PenguinMessageBtnClick{
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
        PenguinChaseKefuViewController * penguinKefuVc = [[PenguinChaseKefuViewController alloc]init];
        penguinKefuVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinKefuVc animated:YES];
    }
}
#pragma mark--动态
-(void)PenguinChaseHomHeaderViewWithClanderActions{

    PenguinChaseDongtaiViewController * penguinDongtaVc = [[PenguinChaseDongtaiViewController alloc]init];
    penguinDongtaVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinDongtaVc animated:YES];
    
}
#pragma mark--搜索
-(void)PenguinChaseHomHeaderViewSearchAction{
    PYSearchViewController * pysearchVc = [PYSearchViewController searchViewControllerWithHotSearches:@[@"312312",@"3123",@"3123",@"1321"] searchBarPlaceholder:@"搜你所搜，看你搜看"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
