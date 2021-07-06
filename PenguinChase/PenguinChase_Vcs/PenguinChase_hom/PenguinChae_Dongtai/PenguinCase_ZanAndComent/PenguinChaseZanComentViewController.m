//
//  PenguinChaseZanComentViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseZanComentViewController.h"
#import <LYEmptyView-umbrella.h>
@interface PenguinChaseZanComentViewController ()

@end

@implementation PenguinChaseZanComentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.index == 0) {
        self.gk_navTitle = @"我的点赞";
    }else{
        self.gk_navTitle = @"我的评论";
    }
    
    
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)PenguinChaseHeaderClicks{
    
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showInfoMsg:@"暂无数据，建议多多互动哦～"];
        LYEmptyView * penguinly =[LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"tubiaozanwushuju"] titleStr:@"暂无数据" detailStr:nil];
        weakSelf.PenguinChaseTableView.ly_emptyView = penguinly;
        [weakSelf.PenguinChaseTableView.mj_header endRefreshing];
    });
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
