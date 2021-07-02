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
@interface PenguinChaseHomeViewController ()<PenguinChaseHomHeaderViewDelegate>
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
#pragma mark--消息
-(void)PenguinMessageBtnClick{
    NSLog(@"%s",__func__);
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
        
    }else if (btnInex == 1){
        
    }else if (btnInex == 2){
        PenguinChaseHomeNewsViewController * penguinNewsVc = [[PenguinChaseHomeNewsViewController alloc]init];
        penguinNewsVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinNewsVc animated:YES];
    }else if (btnInex == 3){
        
    }
}
#pragma mark--动态
-(void)PenguinChaseHomHeaderViewWithClanderActions{
    PenguinChaseDongtaiViewController * penguinDongtaVc = [[PenguinChaseDongtaiViewController alloc]init];
    penguinDongtaVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinDongtaVc animated:YES];
    
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
