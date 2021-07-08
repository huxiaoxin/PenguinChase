//
//  PenguinChase_MySendViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinChase_MySendViewController.h"
#import <LYEmptyView-umbrella.h>
#import "PenguinChaseFabuViewController.h"
@interface PenguinChase_MySendViewController ()

@end

@implementation PenguinChase_MySendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的发布";
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChase_MySendViewHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)PenguinChase_MySendViewHeaderClicks{
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showInfoMsg:@"暂无数据"];
        LYEmptyView * emtyView = [LYEmptyView emptyActionViewWithImageStr:@"tubiaozanwushuju" titleStr:@"暂无动态～" detailStr:@"" btnTitleStr:@"去发布" target:self action:@selector(PenguinChase_sendDongtai)];
        emtyView.actionBtnTitleColor = [UIColor whiteColor];
        emtyView.actionBtnBackGroundColor = LGDMianColor;
        emtyView.actionBtnCornerRadius = RealWidth(5);
        weakSelf.PenguinChaseTableView.ly_emptyView = emtyView;
        [weakSelf.PenguinChaseTableView.mj_header endRefreshing];
    });
}
-(void)PenguinChase_sendDongtai{
    PenguinChaseFabuViewController  * PenguinVCs = [[PenguinChaseFabuViewController alloc]init];
    
    UINavigationController * nav = [UINavigationController rootVC:PenguinVCs translationScale:YES];
    
    [self presentViewController:nav animated:YES completion:nil];
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
