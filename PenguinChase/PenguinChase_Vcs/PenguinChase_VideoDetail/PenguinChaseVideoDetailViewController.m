//
//  PenguinChaseVideoDetailViewController.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseVideoDetailViewController.h"
#import "PenguinChaseVideoDetailHeader.h"
#import "PenginChaseVideoDetailTableViewCell.h"
#import "PenguinChaseVideoComentModel.h"
#import "PenguinChaseJubaoLitsViewController.h"
#import <XHInputView-umbrella.h>
@interface PenguinChaseVideoDetailViewController ()<PenguinChaseVideoDetailHeaderDelegate,PenginChaseVideoDetailTableViewCellDelegate>
@property(nonatomic,strong) PenguinChaseVideoDetailHeader * penguinChaseHeader;
@property(nonatomic,strong) UIButton     * PenguinSendComentBtn;
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinChaseVideoDetailViewController
- (PenguinChaseVideoDetailHeader *)penguinChaseHeader{
    if (!_penguinChaseHeader) {
        _penguinChaseHeader = [[PenguinChaseVideoDetailHeader alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(250))];
        _penguinChaseHeader.backgroundColor = [UIColor clearColor];
        _penguinChaseHeader.delegate = self;
_penguinChaseHeader.pengModel = self.pengModel;
    }
    return _penguinChaseHeader;
}
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray array];
    }
    return _penguinDataArr;
}
-(void)PenguinChaseVideoDetailHeaderWithWantAction:(PenguinChaseVideoModel *)PengModel{
    [self PenguinChase_showLoginVc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navBarAlpha =  0;
    [self.view addSubview:self.PenguinSendComentBtn];
    [_PenguinSendComentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(GK_SAFEAREA_BTM+RealWidth(40));
    }];
    self.PenguinChaseTableView.frame = CGRectMake(0, GK_STATUSBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-RealWidth(40)-GK_STATUSBAR_NAVBAR_HEIGHT);
    self.PenguinChaseTableView.tableHeaderView = self.penguinChaseHeader;
    
    MJWeakSelf;
    self.penguinChaseHeader.headerBlock = ^(CGFloat headerHeight) {
        weakSelf.penguinChaseHeader.height = headerHeight;
        weakSelf.PenguinChaseTableView.tableHeaderView = weakSelf.penguinChaseHeader;
    };
    
    
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoComentModel class] where:[NSString stringWithFormat:@"MoviewID = '%ld'",self.pengModel.penguinChase_MoviewID]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.penguinDataArr.count > 0) {
            [self.penguinDataArr removeAllObjects];
        }
        self.penguinDataArr = dataArr.mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.PenguinChaseTableView reloadData];
        });
    });
    

    // Do any additional setup after loading the view.
}
- (UIButton *)PenguinSendComentBtn{
    if (!_PenguinSendComentBtn) {
        _PenguinSendComentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_PenguinSendComentBtn setBackgroundColor:LGDMianColor];
        _PenguinSendComentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_PenguinSendComentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _PenguinSendComentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_PenguinSendComentBtn addTarget:self action:@selector(PenguinSendComentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_PenguinSendComentBtn setTitle:@"发起评论" forState:UIControlStateNormal];
    }
    return _PenguinSendComentBtn;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenginChaseVideoDetailTableViewCell * penguinCell = [PenginChaseVideoDetailTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.pengModel = self.penguinDataArr[indexPath.row];
    penguinCell.delegate = self;
    penguinCell.tag = indexPath.row;
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoComentModel * pengModel = self.penguinDataArr[indexPath.row];
    return pengModel.CellHeight;
}
#pragma mrk--PenginChaseVideoDetailTableViewCellDelegate
-(void)PenginChaseVideoDetailTableViewCellPenguinWithBtnAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    PenguinChaseVideoComentModel * pengModel = self.penguinDataArr[cellIndex];

    if (btnIndex == 0) {
        [LCProgressHUD showLoading:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD showSuccess:@"拉黑成功！"];
            [WHC_ModelSqlite delete:[PenguinChaseVideoComentModel class] where:[NSString stringWithFormat:@"MoviewID = '%ld'",self.pengModel.penguinChase_MoviewID]];
            [self.penguinDataArr removeObject:pengModel];
            [self.PenguinChaseTableView reloadData];
        });
        
    }else{
        PenguinChaseJubaoLitsViewController * penguinVc = [[PenguinChaseJubaoLitsViewController alloc]init];
        penguinVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinVc animated:YES];
    }
}
-(void)PenguinSendComentBtnClick{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    MJWeakSelf;
    [XHInputView showWithStyle:InputViewStyleLarge configurationBlock:^(XHInputView *inputView) {
        inputView.sendButtonBackgroundColor = LGDMianColor;
        inputView.sendButtonCornerRadius = RealWidth(5);
    } sendBlock:^BOOL(NSString *text) {
        if (text.length > 0) {
            [weakSelf PenguinSendComentextwith:text];
            return YES;
        }else{
        
            return NO;
        }
    }];
    

}
-(void)PenguinSendComentextwith:(NSString *)text{
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        PenguinChaseVideoComentModel * pengModel = [[PenguinChaseVideoComentModel alloc]init];
        pengModel.userName = [PenguinChaseLoginTool PenguinChasegetName];
        pengModel.userHeadeurl = @"https://img0.baidu.com/it/u=2592042537,1864064944&fm=26&fmt=auto&gp=0.jpg";
        pengModel.soureNum = 3;
        pengModel.content = text;
        pengModel.MoviewID = self.pengModel.penguinChase_MoviewID;
        pengModel.ComentID = 666;
        pengModel.CellHeight = 0;
        [WHC_ModelSqlite insert:pengModel];
        [self.penguinDataArr addObject:pengModel];
        
        [self.PenguinChaseTableView reloadData];

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
