//
//  GNHBaseTableViewController.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/10/9.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNHTableViewSectionObject.h"
#import "GNHBaseViewController.h"

@class GNHBaseTableViewCell;

@interface GNHBaseTableViewController : GNHBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/// 元素是GNHTableviewSectionObject对象
@property (nonatomic, strong) NSMutableArray *sections;

/// 索引选中行
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

/// 上拉没有更多提示
@property (nonatomic, strong) UILabel *noMoreTipLabel;

/// 设置是否需要下拉刷新,默认为NO
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;

/// 设置是否需要上拉加载,默认为NO
@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

/// 标记是否正在下拉刷新
@property (nonatomic, assign, readonly, getter=isPullDownRefreshing) BOOL pullDownRefreshing;

/// 标记是否正在上拉加载
@property (nonatomic, assign, readonly, getter=isPullUpRefreshing) BOOL pullUpRefreshing;

/// 初始化tableView类型
- (instancetype)initWithStyle:(UITableViewStyle)style;

/// 上拉刷新判断
- (void)reloadDataWithHasMore:(BOOL)hasMore;

/// 下拉刷新
- (void)pullDownToRefreshAction NS_REQUIRES_SUPER;

/// 上拉刷新
- (void)pullUpToRefreshAction NS_REQUIRES_SUPER;

/// 停止上拉刷新
- (void)stopPullDownToRefreshAnimation;

/// 停止下拉刷新
- (void)stopPullUpToRefreshAnimation;

#pragma mark - Interface

// 加载Nib Cell
@property (nonatomic, assign) BOOL allowNibLoad;

// 绑定Item和cell
+ (Class)cellClsForItem:(id)item;

/// 配置指定Item的cell
- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item;

@end
