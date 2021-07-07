
#import "carpVideoMessageDetailViewController.h"
#import "PenguinChaseKefuTableViewCell.h"
#import "PenguinChaseChatDetailToolsView.h"
#import "PenguinChaseMessageDetailModel.h"
@interface carpVideoMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * carpMessageTableView;
@property(nonatomic,strong) NSMutableArray * carpMessageDataSoure;
@property(nonatomic,strong) PenguinChaseChatDetailToolsView  * carpMessageToolsView;
@end

@implementation carpVideoMessageDetailViewController
-(NSMutableArray *)carpMessageDataSoure{
    if (!_carpMessageDataSoure) {
        _carpMessageDataSoure = [NSMutableArray array];
    }
    return _carpMessageDataSoure;
}
-(PenguinChaseChatDetailToolsView *)carpMessageToolsView{
    if (!_carpMessageToolsView) {
        MJWeakSelf;
        _carpMessageToolsView = [[PenguinChaseChatDetailToolsView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-RealWidth(65), SCREEN_Width, RealWidth(60)) witheTextViewBlokc:^(UITextView * _Nonnull textView) {
            
            [LCProgressHUD showLoading:@""];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD hide];
                PenguinChaseMessageDetailModel  * models = [[PenguinChaseMessageDetailModel alloc]init];
                models.msgname = textView.text;
                models.userID = self.carpessModel.userID;
                models.msgisMe = YES;
                models.imgUrl = @"https://img2.woyaogexing.com/2021/06/19/4e16cecbec4145c4b10e52bb0b50fd17!400x400.jpeg";
                models.CellHeight = 0 ;
                [weakSelf.carpMessageDataSoure addObject:models];
                [WHC_ModelSqlite insert:models];
                NSArray * arr =   [WHC_ModelSqlite query:[PenguinChatMessageListModel class] where:[NSString stringWithFormat:@"ChatID ='%ld'",(long)self.carpessModel.userID]];
                if (arr.count == 0) {
                    PenguinChatMessageListModel * listModl  = [[PenguinChatMessageListModel alloc]init];
                    listModl.userID = self.carpessModel.userID;
                    listModl.headerimgurl = self.carpessModel.headerimgurl;
                    listModl.username = self.carpessModel.username;
                    listModl.time = [self getCurrentTimes];
                    listModl.Content = textView.text;
                    [WHC_ModelSqlite insert:listModl];
                }else{
                    [WHC_ModelSqlite update:[PenguinChatMessageListModel class] value:[NSString stringWithFormat:@"content = '%@'",textView.text] where:[NSString stringWithFormat:@"ChatID ='%ld'",(long)self.carpessModel.userID]];
                }
                [weakSelf.carpMessageTableView reloadData];
                [weakSelf.carpMessageTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.carpMessageDataSoure.count-1 inSection:0]
                                                           animated:YES
                                                     scrollPosition:UITableViewScrollPositionMiddle];
                textView.text = nil;
            });
            
        }];
    }
    return _carpMessageToolsView;
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
    self.gk_navTitle  = self.carpessModel.username;
    [self.view addSubview:self.carpMessageTableView];
    [self.view addSubview:self.carpMessageToolsView];
    // Do any additional setup after loading the view.
}
-(UITableView *)carpMessageTableView{
    if (!_carpMessageTableView) {
        _carpMessageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, SCREEN_Width, SCREEN_Height-RealWidth(65)) style:UITableViewStylePlain];
        _carpMessageTableView.backgroundColor = [UIColor clearColor];
        _carpMessageTableView.delegate = self;
        _carpMessageTableView.dataSource = self;
        _carpMessageTableView.showsVerticalScrollIndicator = NO;
        _carpMessageTableView.showsHorizontalScrollIndicator = NO;
        _carpMessageTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _carpMessageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(carpMessageTableViewClicks)];
        [_carpMessageTableView.mj_header beginRefreshing];
    }
    return _carpMessageTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carpMessageDataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * carpMessgaIdentiets = @"PenguinChaseKefuTableViewCell";
    PenguinChaseKefuTableViewCell * carpMessgaCell = [tableView dequeueReusableCellWithIdentifier:carpMessgaIdentiets];
    if (carpMessgaCell == nil) {
        carpMessgaCell = [[PenguinChaseKefuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carpMessgaIdentiets];
    }
    carpMessgaCell.penguinDetailModel = self.carpMessageDataSoure[indexPath.row];
    return carpMessgaCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseMessageDetailModel * listModel  =self.carpMessageDataSoure[indexPath.row];
    return listModel.CellHeight;
}
-(void)carpMessageTableViewClicks{
    MJWeakSelf;
    NSArray  * dataArr = [WHC_ModelSqlite query:[PenguinChaseMessageDetailModel class] where:[NSString stringWithFormat:@"userID = '%@'",[NSString stringWithFormat:@"%ld",self.carpessModel.userID]]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.carpMessageDataSoure.count > 0) {
            [weakSelf.carpMessageDataSoure removeAllObjects];
        }
        weakSelf.carpMessageDataSoure  = dataArr.mutableCopy;
        [weakSelf.carpMessageTableView reloadData];
        [weakSelf.carpMessageTableView.mj_header endRefreshing];
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


