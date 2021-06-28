//
//  PenguinChaseListViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseListViewController.h"

@interface PenguinChaseListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PenguinChaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.PenguinChaseTableView];
}
- (UITableView *)PenguinChaseTableView{
    if (!_PenguinChaseTableView) {
        _PenguinChaseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_SAFEAREA_BTM) style:UITableViewStylePlain];
        _PenguinChaseTableView.dataSource = self;
        _PenguinChaseTableView.delegate = self;
        _PenguinChaseTableView.backgroundView = nil;
        _PenguinChaseTableView.showsVerticalScrollIndicator=NO;
        _PenguinChaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _PenguinChaseTableView.separatorColor = [UIColor clearColor];
    }
    return _PenguinChaseTableView;
}
- (BOOL)shouldAutorotate {
    // 只支持竖屏
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
#pragma mark- 委托部分

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
