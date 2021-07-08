//
//  PenguinChaseCenterViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseCenterViewController.h"
#import "PenguinCenterListTableViewCell.h"
#import "PenguinCenterHeaderView.h"
#import "PenguinChaseSugestionViewController.h"
#import "PenguinaboutUsViewController.h"
#import "PenguinChaseMyFallowViewController.h"
#import "PengUinChaseWatchedViewController.h"
#import "PenguinChase_MySendViewController.h"
#import "PenginChaseMyColltecdViewController.h"
#import "PenguinChase_MyInfoViewController.h"
#import "PenguinChaseDongtaiModel.h"
@interface PenguinChaseCenterViewController ()<PenguinCenterHeaderViewDelegate>
@property(nonatomic,strong) NSMutableArray * penguinDataArr;
@property(nonatomic,strong) PenguinCenterHeaderView * penguinHeader;
@end

@implementation PenguinChaseCenterViewController
- (NSMutableArray *)penguinDataArr{
    if (!_penguinDataArr) {
        _penguinDataArr = [NSMutableArray arrayWithArray:@[@"意见反馈",@"关于我们",@"清除缓存",@"APP打分"]];
    }
    return _penguinDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navBarAlpha = 0;
    self.PenguinChaseTableView.frame = CGRectMake(0, 0, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_TABBAR_HEIGHT);
    self.PenguinChaseTableView.tableHeaderView = self.penguinHeader;
    // Do any additional setup after loading the view.
}
- (PenguinCenterHeaderView *)penguinHeader{
    if (!_penguinHeader) {
        _penguinHeader = [[PenguinCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(230))];
        _penguinHeader.delegate = self;
    }
    return _penguinHeader;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.penguinDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinCenterListTableViewCell  * penguinCell = [PenguinCenterListTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.penguinText = self.penguinDataArr[indexPath.row];
    UILabel * PenguinRightlb = [penguinCell valueForKey:@"PenguinRightlb"];
    if (indexPath.row == 2) {
        PenguinRightlb.text = [NSString stringWithFormat:@"%.2fM",[self PenguinCaculaterMemorySize]];
    }else{
        PenguinRightlb.text = @"";
    }
    return penguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  RealWidth(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PenguinChaseSugestionViewController * penguinChaseVc = [[PenguinChaseSugestionViewController alloc]init];
        penguinChaseVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinChaseVc animated:YES];
    }else if (indexPath.row == 1){
        PenguinaboutUsViewController * penguinAboutUsVc = [[PenguinaboutUsViewController alloc]init];
        penguinAboutUsVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinAboutUsVc animated:YES];
    }else if (indexPath.row == 2){
        [self PenguinChaseClearCenterMemorySizes];
    }else{
        [self PenguinChase_showLoginVc];
    }
        
}
- (CGFloat)PenguinCaculaterMemorySize{
    CGFloat PenguinCaculaterMemorySize = 0.0;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for(NSString *path in files) {
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        PenguinCaculaterMemorySize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    CGFloat sizeM = PenguinCaculaterMemorySize /1024.0/1024.0;
    
    return sizeM;
}
- (void)PenguinChaseClearCenterMemorySizes{
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                [LCProgressHUD showSuccess:@"清除成功"];
                [self.PenguinChaseTableView reloadData];
            }else{
                
            }
        }
    }
}
-(void)PenguinCenterHeaderViewWithBtnClickIndex:(NSInteger)btnIndex{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    if (btnIndex == 0) {
        PenguinChaseMyFallowViewController * penguinFalllowVc = [[PenguinChaseMyFallowViewController alloc]init];
        penguinFalllowVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinFalllowVc animated:YES];
    }else if (btnIndex == 1){
        PengUinChaseWatchedViewController * penguinwatchVc = [[PengUinChaseWatchedViewController alloc]init];
        penguinwatchVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinwatchVc animated:YES];
        
    }else if (btnIndex == 2){
        PenguinChase_MySendViewController * penguinSendVc = [[PenguinChase_MySendViewController alloc]init];
        penguinSendVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinSendVc animated:YES];
    }else{
        PenginChaseMyColltecdViewController * penguinMyColltecVc = [[PenginChaseMyColltecdViewController alloc]init];
        penguinMyColltecVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:penguinMyColltecVc animated:YES];
    }
}
-(void)PenguinCenterHeaderViewWithInfoAcion{
    if (![PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self PenguinChase_showLoginVc];
        return;
    }
    PenguinChase_MyInfoViewController * penguinInfiVc = [[PenguinChase_MyInfoViewController alloc]init];
    penguinInfiVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:penguinInfiVc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray * dataArr_Views = [WHC_ModelSqlite query:[PenguinChaseVideoModel class] where:[NSString stringWithFormat:@"isViews = '%@'",@(YES)]];
    NSArray * dataArr_Colltecd = [WHC_ModelSqlite query:[PenguinChaseVideoModel class] where:[NSString stringWithFormat:@"penguinChase_isColltecd = '%@'",@(YES)]];
    NSArray * dataArr_Coemnt = [WHC_ModelSqlite query:[PenguinChaseDongtaiModel class] where:[NSString stringWithFormat:@"isLike = '%@'",@(YES)]];
    if ([PenguinChaseLoginTool PenguinChaseLoginToolCheckuserIslgoin]) {
        [self.penguinHeader.PenguinuserimgView sd_setImageWithURL:[NSURL URLWithString:@"https://img0.baidu.com/it/u=2592042537,1864064944&fm=26&fmt=auto&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"whitelogo"]];
        self.penguinHeader.PenguinNamelb.text = [PenguinChaseLoginTool PenguinChasegetName];
        self.penguinHeader.MyFolwwbtn.PenguinToplb.text =  [NSString stringWithFormat:@"%ld",dataArr_Coemnt.count];
        self.penguinHeader.MyWatchBtn.PenguinToplb.text = [NSString stringWithFormat:@"%ld",dataArr_Views.count];
        self.penguinHeader.MySendbtn.PenguinToplb.text = @"0";
        self.penguinHeader.MyColltecdbtn.PenguinToplb.text = [NSString stringWithFormat:@"%ld",dataArr_Colltecd.count];
    }else{
        self.penguinHeader.PenguinuserimgView.image = [UIImage imageNamed:@"whitelogo"];
        self.penguinHeader.PenguinNamelb.text = @"未登录";
        self.penguinHeader.MyFolwwbtn.PenguinToplb.text =  @"-.-";
        self.penguinHeader.MyWatchBtn.PenguinToplb.text = @"-.-";
        self.penguinHeader.MySendbtn.PenguinToplb.text = @"-.-";
        self.penguinHeader.MyColltecdbtn.PenguinToplb.text = @"-.-";
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
