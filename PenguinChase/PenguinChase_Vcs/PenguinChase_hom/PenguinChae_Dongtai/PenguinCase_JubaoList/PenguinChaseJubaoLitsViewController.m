
#import "PenguinChaseJubaoLitsViewController.h"
#import "PenguinChaseVideowarningTabeCell.h"
#import "PenguinChaseJubaoVideoWarningModel.h"
@interface PenguinChaseJubaoLitsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray * PenguinDataList;
@property(nonatomic,assign) BOOL  PenguinStatus;
@end

@implementation PenguinChaseJubaoLitsViewController
-(NSMutableArray *)PenguinDataList{
    if (!_PenguinDataList) {
        _PenguinDataList= [[NSMutableArray alloc]init];
        PenguinChaseJubaoVideoWarningModel * Penguinitem = [[PenguinChaseJubaoVideoWarningModel alloc]init];
        Penguinitem.PenguinChaseVideoStatus  = NO;
        Penguinitem.PenguinChaseVideoText = @"内容太水,太垃圾";
        [_PenguinDataList addObject:Penguinitem];
        
        PenguinChaseJubaoVideoWarningModel * Penguinitem2 = [[PenguinChaseJubaoVideoWarningModel alloc]init];
        Penguinitem2.PenguinChaseVideoStatus  = NO;
        Penguinitem2.PenguinChaseVideoText = @"低俗、传播色情";
        [_PenguinDataList addObject:Penguinitem2];
        
        
        PenguinChaseJubaoVideoWarningModel * Penguinitem3 = [[PenguinChaseJubaoVideoWarningModel alloc]init];
        Penguinitem3.PenguinChaseVideoStatus  = NO;
        Penguinitem3.PenguinChaseVideoText = @"未经授权侵犯品牌";
        [_PenguinDataList addObject:Penguinitem3];
        
        
        PenguinChaseJubaoVideoWarningModel * Penguinitem4 = [[PenguinChaseJubaoVideoWarningModel alloc]init];
        Penguinitem4.PenguinChaseVideoStatus  = NO;
        Penguinitem4.PenguinChaseVideoText = @"违禁品传播";
        [_PenguinDataList addObject:Penguinitem4];
        
        PenguinChaseJubaoVideoWarningModel * Penguinitem5 = [[PenguinChaseJubaoVideoWarningModel alloc]init];
        Penguinitem5.PenguinChaseVideoStatus  = NO;
        Penguinitem5.PenguinChaseVideoText = @"其他";
        [_PenguinDataList addObject:Penguinitem5];
        
        
        
    }
    return _PenguinDataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"举报";
    self.PenguinStatus  =NO;
    self.PenguinChaseTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT-GK_SAFEAREA_BTM);
    self.view.backgroundColor = [UIColor whiteColor];
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseJubaoHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    self.view.backgroundColor = LGDLightGaryColor;
    
    UIView * PenguinChaseHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, K(35))];
    PenguinChaseHeaderView.backgroundColor = LGDLightGaryColor;
    
    UILabel * PenguinChaseHeaderinfolb = [[UILabel alloc]initWithFrame:CGRectMake(K(15), K(0), K(200), K(35))];
    PenguinChaseHeaderinfolb.font = [UIFont systemFontOfSize:12];
    PenguinChaseHeaderinfolb.textColor = [UIColor grayColor];
    PenguinChaseHeaderinfolb.text = @"可以选择多项";
    [PenguinChaseHeaderView addSubview:PenguinChaseHeaderinfolb];
    self.PenguinChaseTableView.tableHeaderView = PenguinChaseHeaderView;
    
    
    UIView * PenguinChaseHeaderCommitView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K(80), K(40))];
    
    UIButton * PenguinChaseHeaderCommitBtn  =[[UIButton alloc]initWithFrame:CGRectMake(K(20), K(10), K(40), K(20))];
    [PenguinChaseHeaderCommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [PenguinChaseHeaderCommitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    PenguinChaseHeaderCommitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [PenguinChaseHeaderCommitBtn addTarget:self action:@selector(PenguinChaseHeaderCommitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PenguinChaseHeaderCommitView addSubview:PenguinChaseHeaderCommitBtn];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinChaseHeaderCommitView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PenguinStatus ? self.PenguinDataList.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PenguinChaseIdentifers =  @"PenguinChaseVideowarningTabeCell";
    PenguinChaseVideowarningTabeCell * PenguinChaseCell = [tableView dequeueReusableCellWithIdentifier:PenguinChaseIdentifers];
    if (PenguinChaseCell == nil) {
        PenguinChaseCell = [[PenguinChaseVideowarningTabeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PenguinChaseIdentifers];
    }
    PenguinChaseCell.penguinModel = self.PenguinDataList[indexPath.row];
    return PenguinChaseCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return K(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseJubaoVideoWarningModel * PenguinChasModel = self.PenguinDataList[indexPath.row];
    PenguinChasModel.PenguinChaseVideoStatus = !PenguinChasModel.PenguinChaseVideoStatus;
    [self.PenguinChaseTableView reloadData];
}
-(void)PenguinChaseJubaoHeaderClicks{
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.PenguinStatus = YES;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
    });
}
-(void)PenguinChaseHeaderCommitBtnClick{
    int CarVideoiHeadcIndex = 0;
    for (PenguinChaseJubaoVideoWarningModel * PenguinChasModel in self.PenguinDataList) {
        if (PenguinChasModel.PenguinChaseVideoStatus) {
            CarVideoiHeadcIndex+=1;
        }
    }
    if (CarVideoiHeadcIndex == 0) {
        [LCProgressHUD showInfoMsg:@"请选择举报类型"];
        return;
    }
    //    if ([ORAccountComponent checkLogin:YES]) {
    
    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showSuccess:@"感谢支持~,举报结果我们核实后会24h内通知到您"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    //    }
    
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


