//
//  GNHBaseTableViewController.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/11/22.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import "GNHBaseTableViewController.h"
#import "GNHTableViewSectionObject.h"
#import "GNHBaseTableViewCell.h"
#import <MJRefresh.h>

@interface GNHBaseTableViewController () <GNHBaseDataModelDelegate>

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end

@implementation GNHBaseTableViewController

#pragma mark - Deallocated

- (void)dealloc
{
    if (_models) {
        [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[GNHBaseDataModel class]]) {
                [(GNHBaseDataModel *)obj cancel];
            }
        }];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableViewStyle = style;
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBaseUI];
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupBaseUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat iphoneX_gap_height = 0.0f;
    if ([UIDevice ly_hasFringeScreen]) {
        iphoneX_gap_height = -34.0f;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORKitMacros.navigationBarHeight + ORKitMacros.statusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight + iphoneX_gap_height) style:self.tableViewStyle];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.selectedIndexPath) {
        self.selectedIndexPath = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if (self.isNeedPullDownToRefreshAction) {
        [self stopPullDownToRefreshAnimation];
    }
    
    if (self.selectedIndexPath) {
        [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GNHTableViewSectionObject *sectionObj = [self.sections mdf_safeObjectAtIndex:section];
    return [[sectionObj items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<GNHBaseActionItemProtocol> item = [self getItemAtIndexPath:indexPath];
    Class cls = [[self class] cellClsForItem:item];
    NSString *cellId = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([item class]), NSStringFromClass(cls)];
    GNHBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        if (self.allowNibLoad) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(cls) owner:nil options:nil];
            cell = [array lastObject];
        } else {
            cell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
    }
    
    if ([item conformsToProtocol:@protocol(GNHBaseActionItemProtocol)]) {
        id<GNHBaseActionItemProtocol> protocolItem = (id<GNHBaseActionItemProtocol>)item;
        if ([protocolItem showAccessoryView]) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_cell_arr"]];
        } else {
            cell.accessoryView = nil;
        }
    }

    cell.indexPath = indexPath;
    cell.cellLocationType = [self cellLocationWithItem:item atIndexPath:indexPath];
    [cell configTopAndBottomLine];
    [self configForCell:cell item:item];
    [cell setItem:item];
    
    return cell;
}

- (GNHBaseTableviewCellLocationType)cellLocationWithItem:(id)cellItem atIndexPath:(NSIndexPath *)indexPath
{
    GNHBaseTableviewCellLocationType locationType = GNHBaseTableviewCellLocationTypeUnknown;
    GNHTableViewSectionObject *sectionObj = [self.sections mdf_safeObjectAtIndex:indexPath.section];
    NSUInteger index = [sectionObj.items indexOfObject:cellItem];
    if (index == 0) {
        if (sectionObj.items.count == 1) {
            locationType = GNHBaseTableviewCellLocationTypeOneCell;
        } else {
            locationType = GNHBaseTableviewCellLocationTypeTopCell;
        }
    } else if (index == (sectionObj.items.count - 1)) {
        locationType = GNHBaseTableviewCellLocationTypeBottomCell;
    } else if (index != NSNotFound) {
        locationType = GNHBaseTableviewCellLocationTypeMiddleCell;
    }
    return locationType;
}

- (id)getItemAtIndexPath:(NSIndexPath *)indexPath
{
    GNHTableViewSectionObject *sectionObj = [self.sections mdf_safeObjectAtIndex:indexPath.section];
    id<GNHBaseActionItemProtocol> item = [sectionObj.items mdf_safeObjectAtIndex:indexPath.row];
    
    return item;
}

+ (Class)cellClsForItem:(id)item
{
    return [GNHBaseTableViewCell class];
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    // 子类配置
}

#pragma mark -  Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    GNHTableViewSectionObject *sectionObj = [self.sections mdf_safeObjectAtIndex:section];
    if (sectionObj.headerHeight <= 1e-6) {
        return tableView.sectionHeaderHeight;
    }
    return sectionObj.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    GNHTableViewSectionObject *sectionObj = [self.sections mdf_safeObjectAtIndex:section];
    if (sectionObj.footerHeight <= 1e-6) {
        return tableView.sectionFooterHeight;
    }
    return sectionObj.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<GNHBaseActionItemProtocol> item = [self getItemAtIndexPath:indexPath];
    Class cellCls = [[self class] cellClsForItem:item];
    if ([cellCls isSubclassOfClass:[GNHBaseTableViewCell class]]) {
        return [cellCls heightForItem:item];
    }
    
    return self.tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    
    id<GNHBaseActionItemProtocol> item = [self getItemAtIndexPath:indexPath];
    id<GNHBaseActionSectionProtocol> sectionObject = [self.sections mdf_safeObjectAtIndex:indexPath.section];
    
    NSString *itemSelectorString = [item respondsToSelector:@selector(didSelectSelector)] ? [item didSelectSelector] : nil;
    NSString *sectionSelectorString = [sectionObject respondsToSelector:@selector(didSelectSelector)] ? [sectionObject didSelectSelector] : nil;
    NSString *selectorString = itemSelectorString.length ? itemSelectorString : sectionSelectorString;
    
    if (selectorString.length > 0) {
        SEL selector = NSSelectorFromString(selectorString);
        if (selector != NULL && [self respondsToSelector:selector]) {
            NSMethodSignature *ms = [self methodSignatureForSelector:selector];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([ms numberOfArguments] == 2) {
                [self performSelector:selector];
            } else if ([ms numberOfArguments] == 3) {
                [self performSelector:selector withObject:item];
            } else if ([ms numberOfArguments] == 4) {
                [self performSelector:selector withObject:item withObject:indexPath];
            } else {
                NSLog(@"can not perform table view call back exceed 3 paras");
            }
            
            if (self.selectedIndexPath) {
                [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
            }
#pragma clang diagnostic pop
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GNHTableViewSectionObject *sectionObject = [self.sections mdf_safeObjectAtIndex:section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, sectionObject.headerHeight)];
    headerView.backgroundColor = gnh_color_b;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    titleLabel.text = sectionObject.headerTitle;
    titleLabel.textColor = gnh_color_e;
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

#pragma mark - Pull Down & up Refresh

- (void)reloadDataWithHasMore:(BOOL)hasMore
{
    if (hasMore != YES) {
        [self stopPullUpToNoticeNoMoreData];
    } else {
        [self stopPullUpToRefreshAnimation];
    }
}

- (void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullDownToRefreshAction = isEnable;
    __weak typeof(self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.tableView.mj_header = [GNHMJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf pullDownToRefreshAction];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

- (void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullUpToRefreshAction = isEnable;
    __weak typeof(self) weakSelf = self;
    if (_isNeedPullUpToRefreshAction) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf pullUpToRefreshAction];
        }];
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = footer;
    } else {
        self.tableView.mj_footer = nil;
    }
}

- (void)pullDownToRefreshAction
{
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)pullUpToRefreshAction
{
}

- (void)stopPullDownToRefreshAnimation
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)stopPullUpToRefreshAnimation
{
    [self.tableView.mj_footer endRefreshing];
}

- (void)stopPullUpToNoticeNoMoreData
{
    [self stopPullUpToRefreshAnimation];
    
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

@end


