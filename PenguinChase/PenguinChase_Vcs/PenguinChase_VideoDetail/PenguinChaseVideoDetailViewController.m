//
//  PenguinChaseVideoDetailViewController.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseVideoDetailViewController.h"
#import "PenguinChaseVideoDetailHeader.h"
#import "PenginChaseVideoDetailTableViewCell.h"
@interface PenguinChaseVideoDetailViewController ()
@property(nonatomic,strong) PenguinChaseVideoDetailHeader * penguinChaseHeader;
@property(nonatomic,strong) UIButton     * PenguinSendComentBtn;
@end

@implementation PenguinChaseVideoDetailViewController
- (PenguinChaseVideoDetailHeader *)penguinChaseHeader{
    if (!_penguinChaseHeader) {
        _penguinChaseHeader = [[PenguinChaseVideoDetailHeader alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(250))];
        _penguinChaseHeader.backgroundColor = [UIColor clearColor];
    }
    return _penguinChaseHeader;
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
    self.PenguinChaseTableView.frame = CGRectMake(0, GK_STATUSBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_SAFEAREA_BTM-RealWidth(40));
    self.PenguinChaseTableView.tableHeaderView = self.penguinChaseHeader;
    
    MJWeakSelf;
    self.penguinChaseHeader.headerBlock = ^(CGFloat headerHeight) {
        weakSelf.penguinChaseHeader.height = headerHeight;
        weakSelf.PenguinChaseTableView.tableHeaderView = weakSelf.penguinChaseHeader;
    };
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
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenginChaseVideoDetailTableViewCell * penguinCell = [PenginChaseVideoDetailTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(100);
}
-(void)PenguinSendComentBtnClick{
    NSLog(@"%s",__func__);
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
