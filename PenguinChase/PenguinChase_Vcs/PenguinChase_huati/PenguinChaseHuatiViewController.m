//
//  PenguinChaseHuatiViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseHuatiViewController.h"
#import "PenguinChaseHuatiSearchView.h"
#import "PenguinHuatileftTableViewCell.h"
#import "PenguinHuatiRigthTableViewCell.h"
@interface PenguinChaseHuatiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) PenguinChaseHuatiSearchView * PenguinChase_SearchView;
@property(nonatomic,strong) UITableView * PenguinSearchLeftTableView;
@property(nonatomic,strong) UITableView * PenguinSearchRightTableiew;
@property(nonatomic,strong) UIView      * PenguinVerticline;
@end

@implementation PenguinChaseHuatiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"全部话题";
    self.gk_navLineHidden = YES;
    [self.view addSubview:self.PenguinChase_SearchView];
    [self.view addSubview:self.PenguinSearchLeftTableView];
    [self.view addSubview:self.PenguinSearchRightTableiew];
    [self.view addSubview:self.PenguinVerticline];
    // Do any additional setup after loading the view.
}
- (UITableView *)PenguinSearchLeftTableView{
    if (!_PenguinSearchLeftTableView) {
        _PenguinSearchLeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_PenguinChase_SearchView.frame)+RealWidth(10), RealWidth(80), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_PenguinChase_SearchView.frame)-GK_TABBAR_HEIGHT-RealWidth(10)) style:UITableViewStylePlain];
        _PenguinSearchLeftTableView.showsVerticalScrollIndicator = NO;
        _PenguinSearchLeftTableView.showsHorizontalScrollIndicator = NO;
        _PenguinSearchLeftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchLeftTableView.backgroundColor = [UIColor clearColor];
        _PenguinSearchLeftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchLeftTableView.delegate = self;
        _PenguinSearchLeftTableView.dataSource = self;
    }
    return _PenguinSearchLeftTableView;
}
- (UITableView *)PenguinSearchRightTableiew{
    if (!_PenguinSearchRightTableiew) {
        _PenguinSearchRightTableiew = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinVerticline.frame), CGRectGetMaxY(_PenguinChase_SearchView.frame)+RealWidth(10), GK_SCREEN_WIDTH-CGRectGetMaxX(_PenguinVerticline.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_PenguinChase_SearchView.frame)-GK_TABBAR_HEIGHT-RealWidth(10)) style:UITableViewStylePlain];
        _PenguinSearchRightTableiew.showsVerticalScrollIndicator = NO;
        _PenguinSearchRightTableiew.showsHorizontalScrollIndicator = NO;
        _PenguinSearchRightTableiew.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchRightTableiew.backgroundColor = [UIColor clearColor];
        _PenguinSearchRightTableiew.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinSearchRightTableiew.delegate = self;
        _PenguinSearchRightTableiew.dataSource = self;
    }
    return _PenguinSearchRightTableiew;
}
- (UIView *)PenguinVerticline{
    if (!_PenguinVerticline) {
        _PenguinVerticline = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PenguinSearchLeftTableView.frame), CGRectGetMinY(_PenguinSearchLeftTableView.frame), 0.9, CGRectGetHeight(_PenguinSearchLeftTableView.frame))];
        _PenguinVerticline.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinVerticline;
}
- (PenguinChaseHuatiSearchView *)PenguinChase_SearchView{
    if (!_PenguinChase_SearchView) {
        _PenguinChase_SearchView = [[PenguinChaseHuatiSearchView alloc]initWithFrame:CGRectMake(RealWidth(15), GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH-RealWidth(30), RealWidth(30)) SearchTapAction:^{
        }];
        
    }
    return _PenguinChase_SearchView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.PenguinSearchLeftTableView) {
        PenguinHuatileftTableViewCell * penguinSearchCell = [PenguinHuatileftTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        return penguinSearchCell;
    }else{
        PenguinHuatiRigthTableViewCell * penguinRightCell = [PenguinHuatiRigthTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        return penguinRightCell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.PenguinSearchLeftTableView) {
        return RealWidth(40);
    }else{
        return RealWidth(120);
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
