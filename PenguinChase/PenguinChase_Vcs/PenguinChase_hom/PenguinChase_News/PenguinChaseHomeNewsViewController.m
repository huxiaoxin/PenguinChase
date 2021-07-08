//
//  PenguinChaseHomeNewsViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/30.
//

#import "PenguinChaseHomeNewsViewController.h"
#import "PenguinChaseNewsTableViewCell.h"
#import "PenguinChaseNewsModel.h"
#import "PenguinChasenewsSizeTool.h"
#import "PenguinChaseNewsDetailViewController.h"
@interface PenguinChaseHomeNewsViewController ()
@property(nonatomic,strong) UIView * PenguinChaseBtnView;
@property(nonatomic,strong) UIButton * Penguinselbtn;
@property(nonatomic,strong) NSMutableArray * penguindataArr;
@end

@implementation PenguinChaseHomeNewsViewController
- (NSMutableArray *)penguindataArr{
    if (!_penguindataArr) {
        _penguindataArr = [NSMutableArray array];
    }
    return _penguindataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"影视资讯";
    self.view.backgroundColor = LGDLightGaryColor;
    _PenguinChaseBtnView.backgroundColor = [UIColor whiteColor];
    
    [self.view insertSubview:self.PenguinChaseBtnView atIndex:0];
    [_PenguinChaseBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(GK_STATUSBAR_NAVBAR_HEIGHT);
        make.height.mas_equalTo(RealWidth(100));
    }];
    [self.PenguinChaseTableView  acs_radiusWithRadius:RealWidth(25) corner:UIRectCornerTopLeft | UIRectCornerTopRight];
    UIView * PenguinHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, RealWidth(10))];
    PenguinHeader.backgroundColor = LGDLightGaryColor;
    
    self.PenguinChaseTableView.tableHeaderView = PenguinHeader;
    self.PenguinChaseTableView.backgroundColor =  LGDLightGaryColor;
    self.PenguinChaseTableView.frame = CGRectMake(0, RealWidth(80)+GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT-GK_SAFEAREA_BTM-RealWidth(60));
    NSArray * btnArr = @[@"全部",@"头条",@"国内",@"国际"];
    NSMutableArray * tempArr = [NSMutableArray array];
    for (int index = 0 ; index < 4; index ++) {
        UIButton * penguinBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        penguinBtn.layer.cornerRadius = RealWidth(15);
        penguinBtn.layer.masksToBounds = YES;
        penguinBtn.titleLabel.font =[UIFont boldSystemFontOfSize:13];
        [penguinBtn setTitle:btnArr[index] forState:UIControlStateNormal];
        [penguinBtn setBackgroundColor:LGDMianColor];
        [penguinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [penguinBtn setTitleColor:LGDLightBLackColor forState:UIControlStateNormal];
        penguinBtn.tag = index;
        [penguinBtn addTarget:self action:@selector(penguinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_PenguinChaseBtnView addSubview:penguinBtn];
        if (index == 0) {
            [self penguinBtnClick:penguinBtn];
        }
        [tempArr addObject:penguinBtn];
    }
    
    [tempArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:RealWidth(10) leadSpacing:RealWidth(10) tailSpacing:RealWidth(10)];
     [tempArr mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(RealWidth(25));
         make.height.mas_equalTo(RealWidth(25));
    }];
}
-(void)penguinBtnClick:(UIButton *)penguinBtn{
    self.Penguinselbtn.selected = NO;
    penguinBtn.selected = YES;
    self.Penguinselbtn = penguinBtn;
    //[NSString stringWithFormat:@"PenguinChase_%ld",penguinBtn.tag]
    NSDictionary * dictionary =   [self getJsonDataJsonname:[NSString stringWithFormat:@"penguinChaseNews_%ld",penguinBtn.tag]];
    
    MJWeakSelf;
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [LCProgressHUD hide];
        NSArray * PenguinChaseNewsArr =[[dictionary objectForKey:@"result"] objectForKey:@"list"];
        NSMutableArray * penguindHoemTempArr= [[NSMutableArray alloc]init];
        for (NSDictionary * pengindsHoemDic in PenguinChaseNewsArr) {
            PenguinChaseNewsModel * pengmodels = [PenguinChaseNewsModel BaseinitWithDic:pengindsHoemDic];
            if (![pengmodels.imgUrl containsString:@"https://interface.sina.cn/wap_api/video_location.d.html"]) {
                if (![pengmodels.imgUrl containsString:@"https://n.sinaimg.cn/default/2fb77759/20151125/320X320.png"]) {
                    CGSize penguinsSize = [PenguinChasenewsSizeTool getImageSizeWithURL:pengmodels.imgUrl];
                    pengmodels.height = penguinsSize.height;
                    pengmodels.width = penguinsSize.width;
                    [penguindHoemTempArr addObject:pengmodels];
                }
                
            }
        }
        weakSelf.penguindataArr = penguindHoemTempArr;
        [weakSelf.PenguinChaseTableView reloadData];
        [weakSelf.PenguinChaseTableView.mj_header endRefreshing];
        
    });
}
- (id)getJsonDataJsonname:(NSString *)jsonname
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        return nil;
    } else {
        return jsonObj;
    }
}
- (UIView *)PenguinChaseBtnView{
    if (!_PenguinChaseBtnView) {
        _PenguinChaseBtnView = [UIView new];
        _PenguinChaseBtnView.backgroundColor = [UIColor whiteColor];
    }
    return _PenguinChaseBtnView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.penguindataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(130);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseNewsTableViewCell * penguinCell  =[PenguinChaseNewsTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    penguinCell.pengModel = self.penguindataArr[indexPath.row];
    return penguinCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseNewsDetailViewController * pengDetailVc = [[PenguinChaseNewsDetailViewController alloc]init];
    pengDetailVc.pengModel = self.penguindataArr[indexPath.row];
    [self.navigationController pushViewController:pengDetailVc animated:YES];
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
