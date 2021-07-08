
#import "PenguinChaseKefuViewController.h"
#import "PenguinChaseKefuTableViewCell.h"
#import "PenguinChaseKefuModel.h"
#import <XHInputView-umbrella.h>
@interface PenguinChaseKefuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView    * PenguinChaseKeufTableView;
@property(nonatomic,strong) NSMutableArray * PenguinChasekefuDataArr;
@property(nonatomic,assign) BOOL PenguinChasekefuSendStatus;
@property(nonatomic,assign) BOOL PenguinChaseiskefu;
@property(nonatomic,strong) UIButton  * PenguinSednBtn;
@end

@implementation PenguinChaseKefuViewController
- (NSMutableArray *)PenguinChasekefuDataArr{
    if (!_PenguinChasekefuDataArr) {
    _PenguinChasekefuDataArr = [NSMutableArray array];
        PenguinChaseKefuModel * PenguinChaseitem =  [[PenguinChaseKefuModel alloc]init];
        PenguinChaseitem.msgname = @"您好～我是今天值班的客服，小周，请问有什么可以帮您？";
        PenguinChaseitem.userID = 9999;
        PenguinChaseitem.imgUrl = @"";
        PenguinChaseitem.msgisMe = NO;
        PenguinChaseitem.CellHeight = 0;
        [_PenguinChasekefuDataArr addObject:PenguinChaseitem];
    }
    return _PenguinChasekefuDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"在线客服";
    self.PenguinChasekefuSendStatus = NO;
    self.PenguinChaseiskefu = NO;
    
    [self.view addSubview:self.PenguinChaseKeufTableView];
    [self.view addSubview:self.PenguinSednBtn];
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.34 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
        self.PenguinChaseiskefu = YES;
        [self.PenguinChaseKeufTableView reloadData];
    });
}
-(void)PenguinSednBtnClick{
    
    MJWeakSelf;
    [XHInputView showWithStyle:InputViewStyleDefault configurationBlock:^(XHInputView *inputView) {
        
    } sendBlock:^BOOL(NSString *text) {
        if (text.length > 0) {
            [weakSelf PenguinChaseSendText:text];
            return YES;
        }else{
            return NO;
        }
    }];
}
- (UIButton *)PenguinSednBtn{
    if (!_PenguinSednBtn) {
        _PenguinSednBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [_PenguinSednBtn setFrame:CGRectMake(GK_SCREEN_WIDTH-RealWidth(50), GK_SCREEN_HEIGHT-RealWidth(50)-GK_SAFEAREA_BTM, RealWidth(40), RealWidth(40))];
        [_PenguinSednBtn setBackgroundImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        [_PenguinSednBtn addTarget:self action:@selector(PenguinSednBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinSednBtn;
}
-(void)PenguinChaseSendText:(NSString *)text{
                [LCProgressHUD showLoading:@""];
    MJWeakSelf;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [LCProgressHUD hide];
                    PenguinChaseKefuModel  * models = [[PenguinChaseKefuModel alloc]init];
                    models.msgname = text;
                    models.userID = 9999;
                    models.msgisMe = YES;
                    models.imgUrl = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F17%2F20150517101126_SFy2U.jpeg&refer=http%3A%2F%2Fimg3.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619531738&t=5a22670d588cfd9b0d5f6719b04e22bf";
                    models.CellHeight = 0 ;
                    [weakSelf.PenguinChasekefuDataArr addObject:models];
                    [weakSelf.PenguinChaseKeufTableView reloadData];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        PenguinChaseKefuModel  * models = [[PenguinChaseKefuModel alloc]init];
                        models.msgname = self.PenguinChasekefuSendStatus == NO ? @"抱歉，小周无法理解你说的问题哦～，你可以说今天是周几😄" : @"很抱歉，无法理解你说的问题，如果有疑问，可以拨打我们的人工客服电话400-600-5872";
                        models.userID = 9999;
                        models.msgisMe = NO;
                        models.imgUrl = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F17%2F20150517101126_SFy2U.jpeg&refer=http%3A%2F%2Fimg3.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619531738&t=5a22670d588cfd9b0d5f6719b04e22bf";
                        models.CellHeight = 0 ;
                        [weakSelf.PenguinChasekefuDataArr addObject:models];
                        [weakSelf.PenguinChaseKeufTableView reloadData];
                        self.PenguinChasekefuSendStatus = YES;
                    });
                });

}

- (UITableView *)PenguinChaseKeufTableView{
    if (!_PenguinChaseKeufTableView) {
        _PenguinChaseKeufTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-RealWidth(0)-GK_STATUSBAR_NAVBAR_HEIGHT) style:UITableViewStylePlain];
        _PenguinChaseKeufTableView.delegate = self;
        _PenguinChaseKeufTableView.dataSource = self;
        _PenguinChaseKeufTableView.showsVerticalScrollIndicator = NO;
        _PenguinChaseKeufTableView.showsHorizontalScrollIndicator = NO;
        _PenguinChaseKeufTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _PenguinChaseKeufTableView.backgroundColor = [UIColor clearColor];
    }
    return _PenguinChaseKeufTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PenguinChaseiskefu ? self.PenguinChasekefuDataArr.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PenguinChaseIdentifer = @"PenguinChaseKefuTableViewCell";
    PenguinChaseKefuTableViewCell * PenguinCell = [tableView dequeueReusableCellWithIdentifier:PenguinChaseIdentifer];
    if (PenguinCell == nil) {
        PenguinCell = [[PenguinChaseKefuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PenguinChaseIdentifer];
    }
    PenguinCell.penguinModel  = self.PenguinChasekefuDataArr[indexPath.row];
    return PenguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseKefuModel * PenguinChaseitem = self.PenguinChasekefuDataArr[indexPath.row];
    return PenguinChaseitem.CellHeight;
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


