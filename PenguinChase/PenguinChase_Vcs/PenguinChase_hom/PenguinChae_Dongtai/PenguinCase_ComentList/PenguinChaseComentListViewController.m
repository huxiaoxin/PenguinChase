//
//  PenguinChaseComentListViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseComentListViewController.h"
#import "LMJHorizontalScrollText.h"
#import "PenguinChaseComentListTableViewCell.h"
#import <LYEmptyView-umbrella.h>
#import "PenguinChaseJubaoLitsViewController.h"
#import <XHInputView-umbrella.h>
@interface PenguinChaseComentListViewController ()<PenguinChaseComentListTableViewCellDelegate>
@property(nonatomic,strong) UIButton  * PenguinSednBtn;
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinChaseComentListViewController
- (UIButton *)PenguinSednBtn{
    if (!_PenguinSednBtn) {
        _PenguinSednBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [_PenguinSednBtn setFrame:CGRectMake(GK_SCREEN_WIDTH-RealWidth(50), GK_SCREEN_HEIGHT-RealWidth(50)-GK_SAFEAREA_BTM, RealWidth(40), RealWidth(40))];
        [_PenguinSednBtn setBackgroundImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        [_PenguinSednBtn addTarget:self action:@selector(PenguinSednBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinSednBtn;
}
-(void)PenguinSednBtnClick{
    
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MJWeakSelf;
        [XHInputView showWithStyle:InputViewStyleLarge configurationBlock:^(XHInputView *inputView) {
            inputView.sendButtonBackgroundColor = LGDMianColor;
            inputView.sendButtonCornerRadius = RealWidth(5);
        } sendBlock:^BOOL(NSString *text) {
            if (text.length > 0) {
                [weakSelf PenguinChaseSendComentWithtext:text];
                return YES;
            }else{
                return NO;
            }
        }];
        

    });
    
}
-(void)PenguinChaseSendComentWithtext:(NSString *)text{
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        PenguinChaseComentModel * pengMoel = [[PenguinChaseComentModel alloc]init];
        pengMoel.headerImgurl = @"https://img0.baidu.com/it/u=2592042537,1864064944&fm=26&fmt=auto&gp=0.jpg";
        pengMoel.userName  =[PenguinChaseLoginTool PenguinChasegetName];
        pengMoel.time = @"刚刚";
        pengMoel.content = @"";
        pengMoel.zoneID = self.pengModel.userID;
        pengMoel.comentID = 5554;
        pengMoel.CellHeight =0;
        pengMoel.StarNum =4;
        [self.penguinDataArr addObject:pengMoel];
        [WHC_ModelSqlite insert:pengMoel];
    });

}

-(void)PenguinHeaderClicks{
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseComentModel class] where:[NSString stringWithFormat:@"zoneID = '%ld'",self.pengModel.userID]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (dataArr.count > 0) {
            if (self.penguinDataArr.count > 0) {
                [self.penguinDataArr removeAllObjects];
            }
            self.penguinDataArr = dataArr.mutableCopy;
            [self.PenguinChaseTableView reloadData];
            [self.PenguinChaseTableView.mj_header endRefreshing];
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.PenguinChaseTableView reloadData];
            });
        }else{
            LYEmptyView * emtyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"tubiaozanwushuju"] titleStr:@"暂无数据~" detailStr:nil];
            self.PenguinChaseTableView.ly_emptyView = emtyView;
            [self.PenguinChaseTableView.mj_header endRefreshing];
            [LCProgressHUD showInfoMsg:@"暂无数据"];
        }
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, NaviH)];
    self.gk_navTitleView = navView;
    LMJHorizontalScrollText * ScrollText = [[LMJHorizontalScrollText alloc]initWithFrame:CGRectMake(K(0), K(0), CGRectGetWidth(navView.frame), K(40))];
    ScrollText.textColor = [UIColor blackColor];
    ScrollText.text = self.pengModel.content;
    ScrollText.textFont =KSysFont(18);
    ScrollText.speed              = 0.03;
    ScrollText.moveDirection      = LMJTextScrollMoveLeft;
    ScrollText.moveMode           = LMJTextScrollContinuous;
    [navView addSubview:ScrollText];
    [ScrollText move];
    [self.view addSubview:self.PenguinSednBtn];
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseComentListTableViewCell * penguinChaseCell = [PenguinChaseComentListTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinChaseCell.penguinModel = self.penguinDataArr[indexPath.row];
    penguinChaseCell.tag = indexPath.row;
    penguinChaseCell.delegate = self;
    return penguinChaseCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseComentModel * pengModel = self.penguinDataArr[indexPath.row];
    return pengModel.CellHeight;
}
#pragma mark--PenguinChaseComentListTableViewCellDelegate
-(void)PenguinChaseComentListTableViewCellWithbtnClikcIndex:(NSInteger)btnIndex cellIndex:(NSInteger)CellIndex{
    PenguinChaseComentModel * pengModel = self.penguinDataArr[CellIndex];
    if (btnIndex == 0) {
        if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
            [self PenguinChase_showLoginVc];
            return;
        }
        UIAlertController * pengAlterVc =[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您要屏蔽《%@》用户的言论吗？",pengModel.userName] message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * sureAction  =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [LCProgressHUD showLoading:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD showSuccess:@"屏蔽成功"];
                [WHC_ModelSqlite delete:[PenguinChaseComentModel class] where:[NSString stringWithFormat:@"comentID ='%ld'",pengModel.comentID]];
                [self.penguinDataArr removeObject:pengModel];
                [self.PenguinChaseTableView reloadData];
            });
            
            
        }];
        
        UIAlertAction * thinkingAction  =[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [pengAlterVc addAction:sureAction];
        [pengAlterVc addAction:thinkingAction];
        [self presentViewController:pengAlterVc animated:YES completion:nil];
        
        
    }else{
        PenguinChaseJubaoLitsViewController  * penguinVc = [[PenguinChaseJubaoLitsViewController alloc]init];
        penguinVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinVc animated:YES];
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
