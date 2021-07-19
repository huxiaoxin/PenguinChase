
#import "PandaMovieSearchViewController.h"
#import "GNHBaseTextField.h"
#import "PandaMovieSearchHotDataModel.h"
#import <VTMagic.h>
#import <VTMagicProtocol.h>
#import "PandaMovieSearchChannelViewController.h"
#import <BUAdSDK/BUAdSDK.h>
@interface PandaMovieSearchViewController () <VTMagicViewDataSource, VTMagicViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) PandaMovieSearchHotDataModel *searchHotDataModel;

@property (strong, nonatomic) VTMagicController *magicController;
@property (nonatomic, strong) NSMutableArray *pandaMoviematchTypes; // 分类赛事
@property (nonatomic, strong) NSMutableArray *PandaMoviemenuTitles; // 分类赛事标题
@property (nonatomic, assign) NSInteger PandaMoviecurrentType;

@property (nonatomic, strong) GNHBaseTextField *PandaMoviesearchTextField;  //  输入框
@property (nonatomic, strong) UIButton *PandaMoviecancelBtn; //  取消按钮

@property (nonatomic, strong) UIView *PandaMoviehistorySearchView; // 历史搜索
@property (nonatomic, strong) UIView *PandaMoviehotSearchView; // 热门搜索

@property (nonatomic, strong) NSMutableArray *historyKeywords;

@property (nonatomic, strong) UIButton *PandaMovieprehistoryButton; // 历史搜索
@property (nonatomic, strong) UIButton *PandaMovieprehotButton;     // 热门搜索
@property (nonatomic, strong) BUNativeExpressBannerView *bannerAdView;  // banner 广告

@end

@implementation PandaMovieSearchViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupDatas];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 去掉导航栏底线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.searchHotDataModel PandaMoviehotKeywords];
    [FilmFactoryUMConfig analytics:pandazj_search label:@"搜索"];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.PandaMoviesearchTextField resignFirstResponder];
    
    // 恢复导航栏底线
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - SetupData

- (void)setupUI
{
    self.view.backgroundColor = gnh_color_b;
    self.tableView.backgroundColor = gnh_color_b;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 导航栏配置
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.PandaMoviecancelBtn];
    
    //搜索框
    GNHBaseTextField *PandaMoviesearchTextField = [[GNHBaseTextField alloc] initWithFrame:CGRectMake(0, -50, kScreenWidth, 30)];
    PandaMoviesearchTextField.delegate = self;
    PandaMoviesearchTextField.backgroundColor = gnh_color_h;
    PandaMoviesearchTextField.font = zy_fontSize13;
    PandaMoviesearchTextField.leftViewMode = UITextFieldViewModeAlways;
    PandaMoviesearchTextField.leftViewGap = 10.0f;
    PandaMoviesearchTextField.textRectLeftGap = 4.0f;
    PandaMoviesearchTextField.editingRectLeftGap = 4.0f;
    PandaMoviesearchTextField.returnKeyType = UIReturnKeySearch;
    PandaMoviesearchTextField.enablesReturnKeyAutomatically = YES;
    PandaMoviesearchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    PandaMoviesearchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    PandaMoviesearchTextField.layer.cornerRadius = 15;
    PandaMoviesearchTextField.layer.masksToBounds = YES;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"搜索关键词" attributes:@{NSFontAttributeName:zy_fontSize13, NSForegroundColorAttributeName:gnh_color_e}];
    [PandaMoviesearchTextField setAttributedPlaceholder:attr];
    PandaMoviesearchTextField.clipsToBounds = YES;
    self.PandaMoviesearchTextField = PandaMoviesearchTextField;
    // 搜索图标 com_search
    UIImage *image = [UIImage imageNamed:@"pandaMoview_searching_icon"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
    PandaMoviesearchTextField.leftView = iconImageView;
    self.navigationItem.titleView = self.PandaMoviesearchTextField;
    
    // 历史搜索
    UIView *PandaMoviehistorySearchView = [UIView ly_ViewWithColor:gnh_color_b];
    [self.tableView addSubview:PandaMoviehistorySearchView];
    [PandaMoviehistorySearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView);
        make.left.right.equalTo(self.view);
    }];
    self.PandaMoviehistorySearchView = PandaMoviehistorySearchView;
    self.PandaMoviehistorySearchView.hidden = YES;
    
    // 历史搜索
    UILabel *historyTitleLabel = [UILabel ly_LabelWithTitle:@"历史搜索" font:zy_mediumSystemFont15 titleColor:gnh_color_a];
    historyTitleLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMoviehistorySearchView addSubview:historyTitleLabel];
    [historyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviehistorySearchView).offset(12.0f);
        make.left.equalTo(PandaMoviehistorySearchView).offset(15.0f);
        make.height.mas_equalTo(14.0f);
    }];
    
    UIButton *deleteBtn = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_delete_icon" selecteImageName:@"pandaMoview_delete_icon" target:self selector:@selector(deleteHistorySearch:)];
    [PandaMoviehistorySearchView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PandaMoviehistorySearchView).offset(-9.5f);
        make.centerY.equalTo(historyTitleLabel);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    [deleteBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];

    // 添加分类赛事
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ORKitMacros.statusBarHeight + ORKitMacros.navigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.magicController.view.hidden = YES;
    
    
    
    
    // 添加banner广告
    self.bannerAdView = [[BUNativeExpressBannerView alloc] initWithSlotID:@"946261349" rootViewController:self adSize:CGSizeMake(kScreenWidth - 15, 150) interval:30];
    [self.view addSubview:self.bannerAdView];
    [self.bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-GK_SAFEAREA_BTM-10);
        make.left.right.inset(15);
        make.height.mas_equalTo(150.f);
    }];
    [self.bannerAdView loadAdData];
}

- (void)configPandaMoviehotSearchView
{
    // 热门搜索
    [self.PandaMoviehotSearchView removeFromSuperview];
    UIView *PandaMoviehotSearchView = [UIView ly_ViewWithColor:gnh_color_b];
    [self.tableView addSubview:PandaMoviehotSearchView];
    [PandaMoviehotSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PandaMoviehistorySearchView.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    self.PandaMoviehotSearchView = PandaMoviehotSearchView;
    
    // 热门搜索
    UILabel *hotTitleLabel = [UILabel ly_LabelWithTitle:@"热门搜索" font:zy_mediumSystemFont15 titleColor:gnh_color_a];
    hotTitleLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMoviehotSearchView addSubview:hotTitleLabel];
    [hotTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviehotSearchView).offset(20.0f);
        make.left.equalTo(PandaMoviehotSearchView).offset(15.0f);
        make.height.mas_equalTo(14.0f);
    }];
    
    __block CGFloat hotOrigin_x = 15.0f;
    __block CGFloat hotOrigin_y = 56.0f;
    __block CGRect hotTmpRect = CGRectZero;
    [self.searchHotDataModel.searchHotKeyItem.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = (NSString *)obj;
        CGSize tagSize = [title textWithSize:14.0f size:CGSizeZero];

        if (hotTmpRect.size.width > 0) {
            if (CGRectGetMaxX(hotTmpRect) + tagSize.width + 33.0f + 15.0f > kScreenWidth) {
                // 换行
                hotOrigin_x = 15.0f;
                hotOrigin_y = CGRectGetMaxY(hotTmpRect) + 12.0f;
            } else {
                hotOrigin_x = CGRectGetMaxX(hotTmpRect) + 10.0f;
                hotOrigin_y = CGRectGetMinY(hotTmpRect);
            }
        }
        
        UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:gnh_color_a font:zy_mediumSystemFont14 target:self selector:@selector(hotSearchAction:)];
        tagButton.backgroundColor = gnh_color_h;
        tagButton.layer.cornerRadius = 15.f;
        tagButton.layer.masksToBounds = YES;
        tagButton.frame = CGRectMake(hotOrigin_x, hotOrigin_y, tagSize.width + 33.0f, 30.0f);
        [PandaMoviehotSearchView addSubview:tagButton];
        hotTmpRect = tagButton.frame;
    }];
    [PandaMoviehotSearchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetMaxY(hotTmpRect) + 20.0f);
    }];
}

- (void)refreshPandaMoviehistorySearchView
{
    for (UIView *subview in self.PandaMoviehistorySearchView.subviews) {
        if ([subview isKindOfClass:[UILabel class]] && subview.tag >= 100) {
            [subview removeFromSuperview];
        }
    }
    __block CGFloat origin_x = 15.0f;
    __block CGFloat origin_y = 38.0f;
    __block CGRect tmpRect = CGRectZero;
    [self.historyKeywords enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = (NSString *)obj;
        CGSize tagSize = [title textWithSize:14.0f size:CGSizeZero];

        if (tmpRect.size.width > 0) {
            if (CGRectGetMaxX(tmpRect) + tagSize.width + 33.0f + 15.0f > kScreenWidth) {
                // 换行
                origin_x = 15.0f;
                origin_y = CGRectGetMaxY(tmpRect) + 12.0f;
            } else {
                origin_x = CGRectGetMaxX(tmpRect) + 10.0f;
                origin_y = CGRectGetMinY(tmpRect);
            }
        }
        
        UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:gnh_color_a font:zy_mediumSystemFont14 target:self selector:@selector(historySearchAction:)];
        tagButton.backgroundColor = gnh_color_h;
        tagButton.layer.cornerRadius = 15.f;
        tagButton.layer.masksToBounds = YES;
        tagButton.tag = 100 + idx;
        tagButton.frame = CGRectMake(origin_x, origin_y, tagSize.width + 33.0f, 30.0f);
        [self.PandaMoviehistorySearchView addSubview:tagButton];
        tmpRect = tagButton.frame;
    }];
    [self.PandaMoviehistorySearchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetMaxY(tmpRect) + 20.0f);
    }];
}

#pragma mark - setupData

- (void)setupDatas
{
    self.historyKeywords = [[ORUserDefaults objectForKey:ORSearchkeywordsKey] mutableCopy];
    if (!self.historyKeywords) {
        self.historyKeywords = [NSMutableArray array];
    }
    
    // 历史搜索
    self.PandaMoviehistorySearchView.hidden = self.historyKeywords.count > 0 ? NO : YES;
    if (!self.PandaMoviehistorySearchView.hidden) {
        [self refreshPandaMoviehistorySearchView];
    }
    
    // 加载菜单
    [self reloadMenuChannelData];
}
    
- (void)refreshUI
{
    // 热门搜索
    [self configPandaMoviehotSearchView];
    if (self.PandaMoviehistorySearchView.hidden) {
        [self.PandaMoviehotSearchView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView);
        }];
    } else {
        [self.PandaMoviehotSearchView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.PandaMoviehistorySearchView.mas_bottom);
        }];
    }
}

- (void)reloadMenuChannelData
{
    self.pandaMoviematchTypes = [NSMutableArray arrayWithArray:[FilmFactoryMenuChannelManager sharedInstance].channelMenuItem.data];
    
    // 标题
    NSMutableArray *PandaMoviemenuTitles = [NSMutableArray array];
    
    [self.pandaMoviematchTypes enumerateObjectsUsingBlock:^(PandaMovieChannelMenuDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [PandaMoviemenuTitles mdf_safeAddObject:obj.name];
    }];
    self.PandaMoviemenuTitles = [PandaMoviemenuTitles mutableCopy];
    
    // 插入占位符
    PandaMovieChannelMenuDataItem *allItem = [[PandaMovieChannelMenuDataItem alloc] init];
    allItem.type = @"all";
    allItem.name = @"全部";
    [self.pandaMoviematchTypes mdf_safeReplaceObjectAtIndex:0 withObject:allItem];
    [self.PandaMoviemenuTitles mdf_safeReplaceObjectAtIndex:0 withObject:@"全部"];
}

- (void)searchDataWithKeyword
{
    // 搜索
    self.magicController.view.hidden = NO;
    [self.magicController.magicView reloadDataToPage:0];
}

#pragma mark - ButtonAction

- (void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)historySearchAction:(UIButton *)btn
{
    self.PandaMovieprehistoryButton.backgroundColor = gnh_color_h;
    [self.PandaMovieprehistoryButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    self.PandaMovieprehistoryButton = btn;
    self.PandaMovieprehistoryButton.backgroundColor = gnh_color_q;
    [self.PandaMovieprehistoryButton setTitleColor:gnh_color_theme forState:UIControlStateNormal];
        
    self.PandaMoviesearchTextField.text = btn.titleLabel.text;
    // 查询数据
    [self searchDataWithKeyword];
}

- (void)hotSearchAction:(UIButton *)btn
{
    self.PandaMovieprehotButton.backgroundColor = gnh_color_h;
    [self.PandaMovieprehotButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    self.PandaMovieprehotButton = btn;
    self.PandaMovieprehotButton.backgroundColor = gnh_color_q;
    [self.PandaMovieprehotButton setTitleColor:gnh_color_theme forState:UIControlStateNormal];
    
    self.PandaMoviesearchTextField.text = btn.titleLabel.text;
    // 查询数据
    [self searchDataWithKeyword];
}

- (void)deleteHistorySearch:(UIButton *)btn
{
    [self.historyKeywords removeAllObjects];
    [ORUserDefaults setObject:self.historyKeywords forKey:ORSearchkeywordsKey];
    [ORUserDefaults synchronize];
    
    self.PandaMoviehistorySearchView.hidden = YES;
    [self refreshPandaMoviehistorySearchView];
    [self.PandaMoviehotSearchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView);
    }];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 8) {
        [SVProgressHUD showInfoWithStatus:@"您输入的关键字过长，请重新输入"];
        return NO;
    } else if (!textField.text.length) {
        [SVProgressHUD showInfoWithStatus:@"搜索的内容不能为空"];
        return NO;
    } else {
        // 查询数据
        [self searchDataWithKeyword];
        [self.PandaMoviesearchTextField resignFirstResponder];
        
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.magicController.view.hidden = YES;
    
    // 还原历史搜索样式
    self.PandaMovieprehistoryButton.backgroundColor = gnh_color_h;
    [self.PandaMovieprehistoryButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    
    // 还原热门搜索样式
    self.PandaMovieprehotButton.backgroundColor = gnh_color_h;
    [self.PandaMovieprehotButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (!toBeString.length) {
        self.magicController.view.hidden = YES;
    }
    
    return [toBeString isEqualToString:@""] || toBeString.length;
}

#pragma mark - VTMagicViewDataSource

- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return self.PandaMoviemenuTitles;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"item.identifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        MDFButton *fontButton = [[MDFButton alloc] init];
        fontButton.normalFont = zy_mediumSystemFont15;
        fontButton.selectedFont = zy_blodFontSize17;
        menuItem = fontButton;
        
        [menuItem setTitleColor:gnh_color_o forState:UIControlStateNormal];
        [menuItem setTitleColor:gnh_color_k forState:UIControlStateSelected];
    }
    [menuItem setImage:nil forState:UIControlStateNormal];
    [menuItem setImage:nil forState:UIControlStateSelected];
    menuItem.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    static NSString *pageId = @"page.identifier";
    PandaMovieSearchChannelViewController *searchChannelViewController = [magicView dequeueReusablePageWithIdentifier:pageId];
    if (!searchChannelViewController) {
        searchChannelViewController = [[PandaMovieSearchChannelViewController alloc] init];
    }
    
    PandaMovieChannelMenuDataItem *dataItem = [self.pandaMoviematchTypes mdf_safeObjectAtIndex:pageIndex];
    searchChannelViewController.typeId = dataItem.type;
    searchChannelViewController.keyword = self.PandaMoviesearchTextField.text;
    
    GNHWeakSelf;
    searchChannelViewController.searchChannelCompleteBlock = ^{
        // 关键词存储本地
        __block BOOL isExist = NO;
        [weakSelf.historyKeywords enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *keyword = (NSString *)obj;
            if ([keyword isEqualToString:weakSelf.PandaMoviesearchTextField.text]) {
                isExist = YES;
                *stop = YES;
            }
        }];
        if (!isExist) {
            [weakSelf.historyKeywords mdf_safeInsertObject:weakSelf.PandaMoviesearchTextField.text atIndex:0];
            [ORUserDefaults setObject:weakSelf.historyKeywords forKey:ORSearchkeywordsKey];
            [ORUserDefaults synchronize];
            
            weakSelf.PandaMoviehistorySearchView.hidden = NO;
            [weakSelf refreshPandaMoviehistorySearchView];
            [weakSelf.PandaMoviehotSearchView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.PandaMoviehistorySearchView.mas_bottom);
            }];
        }
    };
    
    return searchChannelViewController;
}

#pragma mark - VTMagicViewDelegate

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex
{
    
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex
{
    [self.magicController.magicView reselectMenuItem];
    self.magicController.magicView.sliderHidden = NO;
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMovieSearchHotDataModel class]]) {
        // 热门关键词
        [self refreshUI];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

#pragma mark - Properties

- (UIButton *)PandaMoviecancelBtn
{
    if (!_PandaMoviecancelBtn) {
        _PandaMoviecancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _PandaMoviecancelBtn.frame = CGRectMake(0, 0, 10, 30);
        _PandaMoviecancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _PandaMoviecancelBtn.titleLabel.font = zy_fontSize13;
        [_PandaMoviecancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_PandaMoviecancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_PandaMoviecancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _PandaMoviecancelBtn;
}

- (UIViewController<VTMagicProtocol> *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
    
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0, 10, 0, 0);
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.navigationHeight = 44;
        _magicController.magicView.separatorHidden = NO;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.itemWidth = 60.0f;
        _magicController.magicView.sliderColor = LGDMianColor;
        _magicController.magicView.sliderWidth = 15;
        _magicController.magicView.sliderHeight = 3;
        _magicController.magicView.sliderOffset = -5;
        
        // 自定义滑块
        UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 15, 3)];
        sliderView.layer.cornerRadius = 1.5f;
        sliderView.layer.masksToBounds = YES;
        [_magicController.magicView setSliderView:sliderView];
        
    }
    return _magicController;
}

- (PandaMovieSearchHotDataModel *)searchHotDataModel
{
    if (!_searchHotDataModel) {
        _searchHotDataModel = [self produceModel:[PandaMovieSearchHotDataModel class]];
    }
    return _searchHotDataModel;
}

@end
