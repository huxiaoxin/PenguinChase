//
//  PenguinChaseBangdanViewController.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseBangdanViewController.h"
#import "PenguinChaseBangdanTableViewCell.h"
#import "PenguinChaseVideoDetailViewController.h"
#import <GKPhotoBrowser-umbrella.h>
@interface PenguinChaseBangdanViewController ()<PenguinChaseBangdanTableViewCellDelegate>
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@end

@implementation PenguinChaseBangdanViewController
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray array];
    }
    return _penguinDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"热门榜单";
    self.PenguinChaseTableView.estimatedRowHeight = RealWidth(150);
    self.PenguinChaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseTableViewHeaderClicks)];
    [self.PenguinChaseTableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}
-(void)PenguinChaseTableViewHeaderClicks{
    
    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.penguinDataArr.count > 0) {
            [self.penguinDataArr removeAllObjects];
        }
        self.penguinDataArr = [dataArr subarrayWithRange:NSMakeRange(dataArr.count-10, 10)].mutableCopy;
        [self.PenguinChaseTableView reloadData];
        [self.PenguinChaseTableView.mj_header endRefreshing];
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseBangdanTableViewCell * penguinCell =  [PenguinChaseBangdanTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.penguinModel = self.penguinDataArr[indexPath.row];
    penguinCell.tag = indexPath.row;
    penguinCell.delegate = self;
    return penguinCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideoDetailViewController * penguinChaseDetailVc  = [[PenguinChaseVideoDetailViewController alloc]init];
    penguinChaseDetailVc.hidesBottomBarWhenPushed = YES;
    penguinChaseDetailVc.pengModel = self.penguinDataArr[indexPath.row];
    [self.navigationController pushViewController:penguinChaseDetailVc animated:YES];
}
#pragma mark--PenguinChaseBangdanTableViewCellDelegate
-(void)PenguinChaseBangdanTableViewCellWithWantchWithIndex:(NSInteger)CellIndex{
    PenguinChaseVideoModel * pengModel = self.penguinDataArr[CellIndex];
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;;
    }
    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pengModel.penguinChase_isColltecd =  !pengModel.penguinChase_isColltecd;
        [LCProgressHUD showSuccess:pengModel.penguinChase_isColltecd ? @"已收藏" : @"取消收藏"];

        [self.PenguinChaseTableView reloadData];
        [WHC_ModelSqlite update:[PenguinChaseVideoModel class] value:[NSString stringWithFormat:@"penguinChase_isColltecd = '%@'",@(pengModel.penguinChase_isColltecd)] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%ld'",pengModel.penguinChase_MoviewID]];
        
    });
}
-(void)PenguinChaseBangdanTableViewCellWithBannerIndex:(NSInteger)bannerIndex CellIndx:(NSInteger)cellIndex{
    PenguinChaseVideoModel * pengModel = self.penguinDataArr[cellIndex];
    
    
    NSMutableArray *photos = [NSMutableArray new];
    [pengModel.penguinChase_MoviewImgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       GKPhoto *photo = [GKPhoto new];
       photo.url = [NSURL URLWithString:obj];
       [photos addObject:photo];
    }];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:bannerIndex];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:self];

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
