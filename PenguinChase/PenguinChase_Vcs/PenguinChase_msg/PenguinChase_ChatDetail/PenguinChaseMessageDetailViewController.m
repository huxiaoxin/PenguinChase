
#import "PenguinChaseMessageDetailViewController.h"
#import "PenguinChaseKefuTableViewCell.h"
#import "PenguinChaseChatDetailToolsView.h"
#import "PenguinChaseMessageDetailModel.h"
@interface PenguinChaseMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * PenguinChaseMessageTableView;
@property(nonatomic,strong) NSMutableArray * PenguinChaseMessageDataSoure;
@property(nonatomic,strong) PenguinChaseChatDetailToolsView  * PenginHaseMessageToolsView;
@end

@implementation PenguinChaseMessageDetailViewController
-(NSMutableArray *)PenguinChaseMessageDataSoure{
    if (!_PenguinChaseMessageDataSoure) {
        _PenguinChaseMessageDataSoure = [NSMutableArray array];
    }
    return _PenguinChaseMessageDataSoure;
}
-(PenguinChaseChatDetailToolsView *)PenginHaseMessageToolsView{
    if (!_PenginHaseMessageToolsView) {
        MJWeakSelf;
        _PenginHaseMessageToolsView = [[PenguinChaseChatDetailToolsView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-RealWidth(65), SCREEN_Width, RealWidth(60)) witheTextViewBlokc:^(UITextView * _Nonnull textView) {
            
            [LCProgressHUD showLoading:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD hide];
                PenguinChaseMessageDetailModel  * models = [[PenguinChaseMessageDetailModel alloc]init];
                models.msgname = textView.text;
                models.userID = self.penguinChaseModel.userID;
                models.msgisMe = YES;
                models.imgUrl = @"https://img2.woyaogexing.com/2021/06/19/4e16cecbec4145c4b10e52bb0b50fd17!400x400.jpeg";
                models.CellHeight = 0 ;
                [weakSelf.PenguinChaseMessageDataSoure addObject:models];
                [WHC_ModelSqlite insert:models];
                NSArray * arr =   [WHC_ModelSqlite query:[PenguinChatMessageListModel class] where:[NSString stringWithFormat:@"ChatID ='%ld'",(long)self.penguinChaseModel.userID]];
                if (arr.count == 0) {
                    PenguinChatMessageListModel * listModl  = [[PenguinChatMessageListModel alloc]init];
                    listModl.userID = self.penguinChaseModel.userID;
                    listModl.headerimgurl = self.penguinChaseModel.headerimgurl;
                    listModl.username = self.penguinChaseModel.username;
                    listModl.time = [self getCurrentTimes];
                    listModl.Content = textView.text;
                    [WHC_ModelSqlite insert:listModl];
                }else{
                    [WHC_ModelSqlite update:[PenguinChatMessageListModel class] value:[NSString stringWithFormat:@"content = '%@'",textView.text] where:[NSString stringWithFormat:@"ChatID ='%ld'",(long)self.penguinChaseModel.userID]];
                }
                [weakSelf.PenguinChaseMessageTableView reloadData];
                [weakSelf.PenguinChaseMessageTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.PenguinChaseMessageDataSoure.count-1 inSection:0]
                                                           animated:YES
                                                     scrollPosition:UITableViewScrollPositionMiddle];
                textView.text = nil;
            });
            
        }];
    }
    return _PenginHaseMessageToolsView;
}
-(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle  = self.penguinChaseModel.username;
    [self.view addSubview:self.PenguinChaseMessageTableView];
    [self.view addSubview:self.PenginHaseMessageToolsView];
    // Do any additional setup after loading the view.
}
-(UITableView *)PenguinChaseMessageTableView{
    if (!_PenguinChaseMessageTableView) {
        _PenguinChaseMessageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, SCREEN_Width, SCREEN_Height-RealWidth(65)) style:UITableViewStylePlain];
        _PenguinChaseMessageTableView.backgroundColor = [UIColor clearColor];
        _PenguinChaseMessageTableView.delegate = self;
        _PenguinChaseMessageTableView.dataSource = self;
        _PenguinChaseMessageTableView.showsVerticalScrollIndicator = NO;
        _PenguinChaseMessageTableView.showsHorizontalScrollIndicator = NO;
        _PenguinChaseMessageTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _PenguinChaseMessageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PenguinChaseMessageTableViewClicks)];
        [_PenguinChaseMessageTableView.mj_header beginRefreshing];
    }
    return _PenguinChaseMessageTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PenguinChaseMessageDataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PenginhaseMessgaIdentiets = @"PenguinChaseKefuTableViewCell";
    PenguinChaseKefuTableViewCell * PenginChaseMessgaCell = [tableView dequeueReusableCellWithIdentifier:PenginhaseMessgaIdentiets];
    if (PenginChaseMessgaCell == nil) {
        PenginChaseMessgaCell = [[PenguinChaseKefuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PenginhaseMessgaIdentiets];
    }
    PenginChaseMessgaCell.penguinDetailModel = self.PenguinChaseMessageDataSoure[indexPath.row];
    return PenginChaseMessgaCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseMessageDetailModel * listModel  =self.PenguinChaseMessageDataSoure[indexPath.row];
    return listModel.CellHeight;
}
-(void)PenguinChaseMessageTableViewClicks{
    MJWeakSelf;
    NSArray  * dataArr = [WHC_ModelSqlite query:[PenguinChaseMessageDetailModel class] where:[NSString stringWithFormat:@"userID = '%@'",[NSString stringWithFormat:@"%ld",self.penguinChaseModel.userID]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.PenguinChaseMessageDataSoure.count > 0) {
            [weakSelf.PenguinChaseMessageDataSoure removeAllObjects];
        }
        weakSelf.PenguinChaseMessageDataSoure  = dataArr.mutableCopy;
        [weakSelf.PenguinChaseMessageTableView reloadData];
        [weakSelf.PenguinChaseMessageTableView.mj_header endRefreshing];
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


