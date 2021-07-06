//
//  PenguinChaseComentListViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseComentListViewController.h"
#import "LMJHorizontalScrollText.h"
#import "PenguinChaseComentListTableViewCell.h"
@interface PenguinChaseComentListViewController ()
@property(nonatomic,strong) UIButton  * PenguinSednBtn;

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
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, NaviH)];
    self.gk_navTitleView = navView;
    LMJHorizontalScrollText * ScrollText = [[LMJHorizontalScrollText alloc]initWithFrame:CGRectMake(K(0), K(0), CGRectGetWidth(navView.frame), K(40))];
    ScrollText.textColor = [UIColor blackColor];
    ScrollText.text = @"123213123123123123123123123123";
    ScrollText.textFont =KSysFont(18);
    ScrollText.speed              = 0.03;
    ScrollText.moveDirection      = LMJTextScrollMoveLeft;
    ScrollText.moveMode           = LMJTextScrollContinuous;
    [navView addSubview:ScrollText];
    [ScrollText move];
    [self.view addSubview:self.PenguinSednBtn];
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseComentListTableViewCell * penguinChaseCell = [PenguinChaseComentListTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return penguinChaseCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(150);
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
