
#import "PandaMovieDownloadViewController.h"
#import "FilmFacotryDownLoadTableViewCell.h"
#import "PandaMovieChannelNoDataView.h"

@interface PandaMovieDownloadViewController ()

@property (nonatomic, strong) UIButton *PandaMovieeditButton;
@property (nonatomic, weak) UIButton *PandaMovieselectedBtn;
@property (nonatomic, weak) UIButton *PandaMoviedeleteBtn;
@property (nonatomic, weak) UIImageView *PandaMovieeditView;
@property (nonatomic, strong) NSMutableArray *PandaMoviedataArr;
@property (nonatomic, strong) NSMutableArray *PandaMoviedeleteArr;
@property (nonatomic, assign) NSInteger PandaMoviedeleteNum;

@property (nonatomic, strong) PandaMovieChannelNoDataView *noDataView;

@end

@implementation PandaMovieDownloadViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 没有数据
    [self checkNoDataView];
}

#pragma mark - setupUI

- (void)setupUI
{
    UIButton *PandaMovieeditButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [PandaMovieeditButton setTitle:@"编辑" forState:UIControlStateNormal];
    [PandaMovieeditButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    PandaMovieeditButton.titleLabel.font = zy_mediumSystemFont15;
    [PandaMovieeditButton setTitle:@"取消" forState:UIControlStateSelected];
    [PandaMovieeditButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:PandaMovieeditButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.PandaMovieeditButton = PandaMovieeditButton;
    
    // 编辑区域
    UIImageView *PandaMovieeditView = [UIImageView ly_ViewWithColor:gnh_color_b];
    [self.view addSubview:PandaMovieeditView];
    self.PandaMovieeditView = PandaMovieeditView;
    PandaMovieeditView.userInteractionEnabled = YES;
    [PandaMovieeditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(60 + ORKitMacros.iphoneXSafeHeight));
    }];
    self.PandaMovieeditView.hidden = YES;
    
    // 编辑区域
    UIView *toplineView = [UIView ly_ViewWithColor:gnh_color_line];
    toplineView.layer.shadowColor = RGBA_HexCOLOR(0x000000, 0.05).CGColor;
    toplineView.layer.shadowOffset = CGSizeMake(0, -1);
    toplineView.layer.shadowOpacity = 1;
    toplineView.layer.shadowRadius = 4;
    [PandaMovieeditView addSubview:toplineView];
    [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0f);
        make.left.right.equalTo(PandaMovieeditView);
        make.height.mas_equalTo(@0.5f);
    }];
        
    UIButton *PandaMovieselectedBtn = [UIButton ly_ButtonWithTitle:@"全选" titleColor:gnh_color_a font:zy_mediumSystemFont15 target:self selector:@selector(PandaMovieselectedBtnClick:)];
    [PandaMovieselectedBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    [PandaMovieeditView addSubview:PandaMovieselectedBtn];
    self.PandaMovieselectedBtn = PandaMovieselectedBtn;
    [PandaMovieselectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PandaMovieeditView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.centerX.equalTo(PandaMovieeditView).offset(-(kScreenWidth/4.0));
        make.size.mas_equalTo(CGSizeMake(140, 45));
    }];
    
    UIView *lineView = [UIView ly_ViewWithColor:gnh_color_line];
    [PandaMovieeditView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(PandaMovieeditView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.size.mas_equalTo(CGSizeMake(0.5, 16.5f));
    }];
    
    UIButton *PandaMoviedeleteBtn = [UIButton ly_ButtonWithTitle:@"删除" titleColor:gnh_color_theme font:zy_mediumSystemFont15 target:self selector:@selector(PandaMoviedeleteBtnClick:)];
    [PandaMovieeditView addSubview:PandaMoviedeleteBtn];
    self.PandaMovieselectedBtn = PandaMoviedeleteBtn;
    [PandaMoviedeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PandaMovieeditView).offset(-ORKitMacros.iphoneXSafeHeight/2.0);
        make.centerX.equalTo(PandaMovieeditView).offset((kScreenWidth/4.0));
        make.size.mas_equalTo(CGSizeMake(140, 45));
    }];
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[ORDownLoadCellItem class]]) {
        return [FilmFacotryDownLoadTableViewCell class];
    }
    return nil;
}

#pragma mark - setupData

- (void)setupData
{
    self.navigationItem.title = @"我的下载";
    CGRect rect = self.tableView.frame;
    rect.size.height += ORKitMacros.tabBarHeight + ORKitMacros.iphoneXSafeHeight;
    self.tableView.frame = rect;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = gnh_color_b;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[sectionObject] mutableCopy];
}

- (void)checkNoDataView
{
    // 没有数据
    __block BOOL hasData = NO;
    [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GNHTableViewSectionObject *section = (GNHTableViewSectionObject *)obj;
        if (section.items.count) {
            hasData = YES;
            *stop = YES;
        }
    }];
    self.noDataView.hidden = hasData;
}

#pragma mark - UITableview Delegate

- (void)selectCellWithItem:(id<GNHBaseActionItemProtocol>)item indexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([item isKindOfClass:[ORDownLoadCellItem class]]) {
        ORDownLoadCellItem *cellItem = (ORDownLoadCellItem *)item;
        if (self.PandaMovieeditView.hidden) {
            // 跳转到视频详情
            [[FilmFactoryPlayerManager sharedInstance] jumpChannelWith:cellItem.idStr type:cellItem.type cover:cellItem.coverImg];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.PandaMovieeditView.hidden) {
        [self.PandaMoviedeleteArr addObject:[self.PandaMoviedataArr objectAtIndex:indexPath.row]];
        self.PandaMoviedeleteNum += 1;
        [self.PandaMoviedeleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.PandaMoviedeleteNum] forState:UIControlStateNormal];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.PandaMovieeditView.hidden) {
        [self.PandaMoviedeleteArr removeObject:[self.PandaMoviedataArr objectAtIndex:indexPath.row]];
        self.PandaMoviedeleteNum -= 1;
        [self.PandaMoviedeleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.PandaMoviedeleteNum] forState:UIControlStateNormal];
    }
}

#pragma mark - buttonAction

- (void)rightButtonAction:(UIButton *)btn
{
    [super rightButtonAction:btn];
    
    btn.selected = !btn.selected;
    self.PandaMoviedeleteArr = [[NSMutableArray alloc]init];
    self.PandaMoviedeleteNum = 0;

    if (btn.selected) {
        self.tableView.editing = YES;
        self.PandaMovieeditView.hidden = NO;
        
        CGRect rect = self.tableView.frame;
        rect.size.height += - (60.0f + ORKitMacros.iphoneXSafeHeight + ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight);
        self.tableView.frame = rect;
    } else {
        self.tableView.editing = NO;
        self.PandaMovieeditView.hidden = YES;
        
        CGRect rect = self.tableView.frame;
        rect.size.height = kScreenHeight - ORKitMacros.statusBarHeight - ORKitMacros.navigationBarHeight;
        self.tableView.frame = rect;
    }
}

- (void)PandaMovieselectedBtnClick:(UIButton *)btn
{
    if (!self.PandaMovieselectedBtn.selected) {
        self.PandaMovieselectedBtn.selected = YES;
        
        for (int i = 0; i < self.PandaMoviedataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        }
        [self.PandaMoviedeleteArr addObjectsFromArray:self.PandaMoviedataArr];
        self.PandaMoviedeleteNum = self.PandaMoviedataArr.count;
        [self.PandaMoviedeleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.PandaMoviedeleteNum] forState:UIControlStateNormal];
    } else {
        self.PandaMovieselectedBtn.selected = NO;
        [self.PandaMoviedeleteArr removeAllObjects];
        for (int i = 0; i < self.PandaMoviedataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        self.PandaMoviedeleteNum = 0;
        [self.PandaMoviedeleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.PandaMoviedeleteNum] forState:UIControlStateNormal];
    }
}

- (void)PandaMoviedeleteBtnClick:(UIButton *)btn
{
    if (self.tableView.editing) {
        //删除

        [self.PandaMoviedataArr removeObjectsInArray:self.PandaMoviedeleteArr];
        [self.tableView reloadData];
        
        self.PandaMoviedeleteNum = 0;
        [self.PandaMoviedeleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.PandaMoviedeleteNum] forState:UIControlStateNormal];
        
        self.PandaMovieselectedBtn.selected = NO;
        //  你的网络请求
    }
}

#pragma mark - Properties

- (PandaMovieChannelNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PandaMovieChannelNoDataView alloc] init];
        [self.tableView addSubview:_noDataView];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.tableView);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, self.view.height));
        }];
    }
    return _noDataView;
}

@end
