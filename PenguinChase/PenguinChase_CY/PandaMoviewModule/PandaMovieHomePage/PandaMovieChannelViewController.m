//
//  ORChannelViewController.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/12.
//

#import "PandaMovieChannelViewController.h"
#import "PandaMovieFetchSubChanelMenuDataModel.h"
#import "PandaMovieBannerDataModel.h"
#import <CWCarousel.h>
#import "PandaMovieChannelNoDataView.h"
#import "PandaMovieChannelTableViewCell.h"
#import "PandaMovieH5ViewController.h"
#import "PandaMoVieChannelSenceDataModel.h"
#import "PandaMovieVideoSenceRefreshDataModel.h"
#import "PandaMovieChannelMoreViewController.h"
#import "PenguinChaseVideoDetailViewController.h"
#define kImageViewTag 666
#define kDescViewTag 999

#define kchannelDataSize  20 // 默认请求20条数据
//
@interface PandaMovieChannelViewController () <CWCarouselDatasource, CWCarouselDelegate>
@property (nonatomic, strong) PandaMovieFetchSubChanelMenuDataModel *subChanelMenuDataModel; // 子菜单
@property (nonatomic, strong) PandaMovieBannerDataModel *bannerDataModel;
@property (nonatomic, strong) PandaMoVieChannelSenceDataModel *channelSenceDataModel; // 模块数据
@property (nonatomic, strong) PandaMovieVideoSenceRefreshDataModel *videoSenceRefreshDataModel; // 换一换

@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *animationView;

/// 数据源
@property (nonatomic, strong) NSMutableArray *bannerDataArr;
@property (nonatomic, strong) NSMutableArray <__kindof ORSubChannelMenuDataItem *> *menuArr;

@property (nonatomic, assign) NSInteger dataPage; // 数据页码
@property (nonatomic, assign) NSInteger preDataPage;

@property (nonatomic, strong) PandaMovieChannelNoDataView *noDataView;

@property (nonatomic, strong) UIButton *pretagButton;
@property (nonatomic, copy) NSString *childtype; // 子类型

@property (nonatomic, assign) CGFloat top_offset;

@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation PandaMovieChannelViewController
#define ARC4RANDOM_MAX      0x100000000

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
    
    self.carousel.isAuto = YES;
    [self.carousel controllerWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 暂停banner滚动
    [self.carousel controllerWillDisAppear];
}

#pragma mark - SetupData

- (void)setupUI
{
    CGRect rect = self.tableView.frame;
    rect.size.height = self.view.size.height;
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    self.tableView.frame = rect;
    self.bannerDataArr = nil;
    
    self.isNeedPullDownToRefreshAction = YES;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = LGDViewBJColor;
    
    // 配置数据
    GNHTableViewSectionObject *sectionObject = [[GNHTableViewSectionObject alloc] init];
    self.sections = [@[sectionObject] mutableCopy];
    [self.tableView reloadData];
    
    // 表头
    self.animationView.backgroundColor = LGDViewBJColor;
    self.animationView.clipsToBounds = YES;
        
    UIView *gapView = [UIView ly_ViewWithColor:LGDViewBJColor];
    [self.animationView addSubview:gapView];
    [gapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.animationView);
        make.height.mas_equalTo(7.5f);
    }];
    
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_1];
    flowLayout.itemSpace_H = 20.0f;
    flowLayout.itemWidth = kScreenWidth - 20;
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectZero
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    carousel.pageControl.pageIndicatorTintColor = UIColor.lightTextColor;
    carousel.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [carousel.pageControl setTransform:CGAffineTransformMakeScale(0.75, 0.75)];
    [self.animationView addSubview:carousel.pageControl]; // 添加到aniView
    [self.animationView addSubview:carousel];
    [self.animationView bringSubviewToFront:carousel.pageControl];
    [carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(7.5f);
        make.left.right.equalTo(self.animationView);
        make.bottom.equalTo(self.animationView).offset(-7.5f);
    }];
    carousel.backgroundColor =  LGDViewBJColor;
    carousel.autoTimInterval = 3;
    carousel.endless = YES;
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
    self.carousel = carousel;
}

+ (Class)cellClsForItem:(id)item
{
    if ([item isKindOfClass:[ORChannelSenceDataItem class]]) {
        return [PandaMovieChannelTableViewCell class];
    }
    
    return nil;
}

- (void)configForCell:(GNHBaseTableViewCell *)cell item:(id)item
{
    GNHWeakSelf;
    if ([item isKindOfClass:[ORChannelSenceDataItem class]]) {
        PandaMovieChannelTableViewCell *channelTableViewCell = (PandaMovieChannelTableViewCell *)cell;
        channelTableViewCell.channelItemCallBack = ^(PandaMovieVideoBaseItem * _Nonnull dataItem, NSString *sence, NSString *sceneName, NSInteger type) {
            if (type == 1) {
                // 更多
                PandaMovieChannelMoreViewController *moreViewController = [[PandaMovieChannelMoreViewController alloc] init];
                moreViewController.sceneType = weakSelf.typeId;
                moreViewController.scene = sence;
                moreViewController.sceneName = sceneName;
                [weakSelf.navigationController pushViewController:moreViewController animated:YES];
            } else {
                // 详情
                
                
                
                if ([[ORNetworkingManager sharedInstance] OssSet]) {
                    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class]];
                    int x = arc4random() % dataArr.count;
                    PenguinChaseVideoModel *  MypandaModel = [dataArr objectAtIndex:x];
                    CGFloat val1 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                    CGFloat val2 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                    CGFloat val3 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                    CGFloat val4 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);
                    CGFloat val5 = ((CGFloat)arc4random()/ARC4RANDOM_MAX);

                    PenguinChaseVideoModel   * pandaModel = [[PenguinChaseVideoModel alloc]init];
//                    pandaModel.pandaMoiveThuburl  = dataItem.coverImg;
//                    pandaModel.PandaMoviewName =  dataItem.videoName;
//                    pandaModel.PandaMoviewengishName = @"暂无";
//                    pandaModel.PandaMoviewType = [NSString stringWithFormat:@"%@/%@",dataItem.typeCh,dataItem.areaTypeCh];
//                    pandaModel.PandaMoviewArtiss = dataItem.actor;
//                    pandaModel.PandaMoviewstar_five   = val1;
//                    pandaModel.PandaMoviewstar_foure  = val2;
//                    pandaModel.PandaMoviewstar_three  = val3;
//                    pandaModel.PandaMoviewstar_two    = val4;
//                    pandaModel.PandaMoviewstar_one   = val5;
//                    pandaModel.PandaMoview_isCollected = NO;
//                    pandaModel.PandaMoview_listArr = MypandaModel.PandaMoview_listArr;
//                    pandaModel.PandaMoview_intrduce = dataItem.videoDesc;
//                    pandaModel.PandaMoview_soureNums = [dataItem.idStr integerValue];
//                    pandaModel.PandaMoview_DBNums = [dataItem.score floatValue];
//                    pandaModel.PandaMovie_ID = MypandaModel.PandaMovie_ID;
//                    pandaModel.PandaMoview_tagOne =  dataItem.videoTag;
//                    pandaModel.PandaMoview_tagtwo  = @"";
//                    pandaModel.time = dataItem.createTime;
//                    pandaModel.Top_filmType = 110;
//                    pandaModel.total_Num = 12;
                    PenguinChaseVideoDetailViewController * FilmDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
                    FilmDetailVc.hidesBottomBarWhenPushed = YES;
                    FilmDetailVc.pengModel = pandaModel;
                    [self.navigationController pushViewController:FilmDetailVc animated:YES];
                }else{
                [[FilmFactoryPlayerManager sharedInstance] jumpChannelWith:dataItem.idStr type:dataItem.type cover:dataItem.coverImg];
                }
            }
        };
        channelTableViewCell.refreshDataCallback = ^(NSString * _Nonnull scene, NSInteger indexRow) {
            weakSelf.currentRow = indexRow;
            // 换一换
            [weakSelf.videoSenceRefreshDataModel fetchChannelSenceDataWithType:scene videoType:weakSelf.typeId];
        };
    }
}

#pragma mark - setupData

- (void)setupDatas
{
    self.dataPage = 1;
    
    // 获取数据
    [self pullDownToRefreshAction];
}

- (void)refreshHeaderData
{
    UIView *headerView = [UIView ly_ViewWithColor:LGDViewBJColor];
    
    if (self.bannerDataArr.count) {
        [headerView addSubview:self.animationView];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, self.animationView.size.height);
    }
    
    if (self.menuArr.count > 0) {
        UIView *subMenuView = [UIView ly_ViewWithColor:UIColor.clearColor];
        __block CGFloat hotOrigin_x = 15.0f;
        __block CGFloat hotOrigin_y = 0.0f;
        __block CGRect hotTmpRect = CGRectZero;
        [self.menuArr enumerateObjectsUsingBlock:^(__kindof ORSubChannelMenuDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj.name;
            CGSize tagSize = [title textWithSize:13.0f size:CGSizeZero];

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

            UIButton *tagButton = [UIButton ly_ButtonWithTitle:title titleColor:gnh_color_m font:zy_mediumSystemFont13 target:self selector:@selector(tagButtonAction:)];
            tagButton.backgroundColor = gnh_color_n;
            tagButton.layer.cornerRadius = 12.5f;
            tagButton.layer.masksToBounds = YES;
            tagButton.frame = CGRectMake(hotOrigin_x, hotOrigin_y, tagSize.width + 30.0f, 25.0f);
            tagButton.tag = 100 + idx;
            [subMenuView addSubview:tagButton];
            hotTmpRect = tagButton.frame;
        }];
        [headerView addSubview:subMenuView];

        if (self.bannerDataArr.count) {
            subMenuView.frame = CGRectMake(0, CGRectGetMaxY(self.animationView.frame) + 7, self.animationView.width, CGRectGetMaxY(hotTmpRect) + 20.0f);
            headerView.frame = CGRectMake(0, 0, kScreenWidth, self.animationView.size.height + subMenuView.height);
        } else {
            subMenuView.frame = CGRectMake(0, 7 + 10, self.animationView.width, CGRectGetMaxY(hotTmpRect) + 20.0f);
            headerView.frame = CGRectMake(0, 0, kScreenWidth, subMenuView.height + 10);
        }
    }

    self.tableView.tableHeaderView = headerView;
    self.top_offset = CGRectGetHeight(headerView.frame);
    
    // 没有数据
    [self checkNoDataView];
}

- (void)setTypeId:(NSString *)typeId
{
    _typeId = typeId;
    
    // 刷新
    [self pullDownToRefreshAction];
}

#pragma mark - ButtonAction

- (void)tagButtonAction:(UIButton *)btn
{
    // 搜索数据
    self.pretagButton.backgroundColor = gnh_color_n;
    [self.pretagButton setTitleColor:gnh_color_m forState:UIControlStateNormal];
    self.pretagButton = btn;
    self.pretagButton.backgroundColor = gnh_color_q;
    [self.pretagButton setTitleColor:gnh_color_theme forState:UIControlStateNormal];

    GNHWeakSelf;
    [self.menuArr enumerateObjectsUsingBlock:^(__kindof ORSubChannelMenuDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == btn.tag - 100) {
            weakSelf.childtype = obj.type;
            *stop = YES;
        }
    }];
}

#pragma mark - CWCarouselDelegate Delegate

- (NSInteger)numbersForCarousel
{
    return self.bannerDataArr.count;
}

- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index
{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = LGDViewBJColor;
    UIImageView *imgView = [cell.contentView viewWithTag:kImageViewTag];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.backgroundColor = LGDViewBJColor;
        imgView.tag = kImageViewTag;
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10;
    }
    
    UIImageView *coverImgView = [cell.contentView viewWithTag:200];
    if(!coverImgView) {
        coverImgView = [UIImageView ly_ImageViewWithImageName:@"index_cover_bg"];
        coverImgView.frame = CGRectMake(0, cell.contentView.bounds.size.height - 40.0f, cell.contentView.bounds.size.width, 40.0f);
        coverImgView.tag = 200;
        [cell.contentView addSubview:coverImgView];
    }
        
    UILabel *descLabel = [cell.contentView viewWithTag:kDescViewTag];
    if (!descLabel) {
        descLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize17 titleColor:gnh_color_b];
        descLabel.frame = CGRectMake(12, cell.contentView.bounds.size.height - 40.0f, cell.contentView.bounds.size.width, 40.0f);
        descLabel.tag = kDescViewTag;
        [cell.contentView addSubview:descLabel];
    }
    

    
    if ([[ORNetworkingManager sharedInstance] OssSet]) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://img9.doubanio.com/view/photo/l/public/p2580840216.jpg"] placeholderImage:[UIImage imageNamed:@"index_banner_cover_default"]];
        descLabel.text = @"A Quiet Place: Part II";

    }else{
        ORBannerDataItem *bannerDataItem = (ORBannerDataItem *)[self.bannerDataArr mdf_safeObjectAtIndex:index];
        [imgView sd_setImageWithURL:bannerDataItem.image.urlWithString placeholderImage:[UIImage imageNamed:@"index_banner_cover_default"]];
        descLabel.text = bannerDataItem.desc;
    }
    
    return cell;
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"...%ld...", (long)index);
    ORBannerDataItem *dataItem = (ORBannerDataItem *)[self.bannerDataArr mdf_safeObjectAtIndex:index];
    switch (dataItem.redirectType) {
        case BannerRedirectTypeH5: {
            UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:dataItem.redirectLink.urlWithString];
            vc.edgesForExtendedLayout = UIRectEdgeNone;
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case BannerRedirectTypeNative: {
            break;
        }
        case BannerRedirectTypeVideoDetail: {
            // 详情
            NSString *videoID = dataItem.redirectLink;
            NSString *videoType = dataItem.videoType;
            if (videoID.length && videoType.length) {
                //
                if ([[ORNetworkingManager sharedInstance] OssSet]) {
                    NSArray * dataArr = [WHC_ModelSqlite query:[PenguinChaseVideoModel class] where:[NSString stringWithFormat:@"penguinChase_MoviewID = '%d'",666]];
                    PenguinChaseVideoModel *  MypandaModel = [dataArr objectAtIndex:0];
                    PenguinChaseVideoDetailViewController * FilmDetailVc = [[PenguinChaseVideoDetailViewController alloc]init];
                    FilmDetailVc.hidesBottomBarWhenPushed = YES;
                    FilmDetailVc.pengModel = MypandaModel;
                    [self.navigationController pushViewController:FilmDetailVc animated:YES];
 
                }else{
                    [[FilmFactoryPlayerManager sharedInstance] jumpChannelWith:videoID type:videoType cover:@""];
                }
        
            }
            break;;
        }
        default:
            break;
    }
}

- (void)CWCarousel:(CWCarousel *)carousel didStartScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow
{
    NSLog(@"开始滑动: %ld", index);
}

- (void)CWCarousel:(CWCarousel *)carousel didEndScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow
{
    NSLog(@"结束滑动: %ld", index);
}

#pragma mark - VTMagicReuseProtocol delegate

- (void)vtm_prepareForReuse
{
    // 清空数据
    [self.bannerDataArr removeAllObjects];
    [self.menuArr removeAllObjects];
    self.top_offset = 0.0f;
}

#pragma mark - Refresh

- (void)pullDownToRefreshAction
{
    [super pullDownToRefreshAction];
    self.isNeedPullUpToRefreshAction = YES;
    
    // 获取banner
    [self.bannerDataModel fetchBannerWithType:self.typeId];
    // 获取二级菜单
//    [self.subChanelMenuDataModel fetchChannelMenuWithType:self.typeId];
//    self.childtype = @"";
        
    self.dataPage = 1;
    BOOL flag = [self.channelSenceDataModel fetchChannelSenceDataWithType:self.typeId]; // 默认一次性请求个
    if (flag) {
        self.channelSenceDataModel.loadType = GNHDataModelLoadTypeRefresh;
    } else {
        self.dataPage = self.preDataPage;
        [self stopPullDownToRefreshAnimation];
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieBannerDataModel class]]) {
        if ([[ORNetworkingManager sharedInstance] OssSet]) {
            self.bannerDataArr = [[self.bannerDataModel.bannerItem.data subarrayWithRange:NSMakeRange(0, 1)] mutableCopy];

        }else{
            self.bannerDataArr = self.bannerDataModel.bannerItem.data;

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.carousel freshCarousel];
            
            CGSize pointSize = [self.carousel.pageControl sizeForNumberOfPages:self.bannerDataArr.count];
            [self.carousel.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.animationView).offset(-15.0f);
                make.right.equalTo(self.animationView).offset(-12.0f);
                make.size.mas_equalTo(CGSizeMake(pointSize.width, 30.0f));
            }];
        });
        [self refreshHeaderData];
    } else if ([gnhModel isMemberOfClass:[PandaMovieFetchSubChanelMenuDataModel class]]) {
        // 二级子菜单
        self.menuArr = [self.subChanelMenuDataModel.subChannelMenuItem.data mutableCopy];
        [self refreshHeaderData];
    } else if ([gnhModel isMemberOfClass:[PandaMoVieChannelSenceDataModel class]]) {
        // 下拉刷新，数据还原
        [self stopPullDownToRefreshAnimation];
        
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        sectionObject.items = [self.channelSenceDataModel.channelSenceItem.data mutableCopy];
        
        [self.tableView reloadData];
        // 没有数据
        [self checkNoDataView];
    } else if ([gnhModel isMemberOfClass:[PandaMovieVideoSenceRefreshDataModel class]]) {
        // 换一换
        GNHTableViewSectionObject *sectionObject = self.sections.firstObject;
        ORChannelSenceDataItem *item = [sectionObject.items mdf_safeObjectAtIndex:self.currentRow];
        item.videoDtoList = [self.videoSenceRefreshDataModel.videoSenceItem.data mutableCopy];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentRow inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isMemberOfClass:[PandaMoVieChannelSenceDataModel class]]) {
        [self stopPullDownToRefreshAnimation];
        
        if (gnhModel.loadType == GNHDataModelLoadTypeLoadMore) {
            self.dataPage = self.preDataPage;
            [self stopPullUpToRefreshAnimation];
        }
        [self.tableView reloadData];
        
        // 没有数据
        [self checkNoDataView];
    }
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
    self.noDataView.frame = CGRectMake(0, self.top_offset, kScreenWidth,  self.tableView.height - self.top_offset);
}

#pragma mark - Properties

- (UIView *)animationView
{
    if(!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 195*(kScreenWidth/375.0))]; // 高度 = 180 + 上下间距7.5
        _animationView.layer.cornerRadius = 10.0f;
        _animationView.layer.masksToBounds = YES;
        
        // 遮罩层
        UIImageView *topCoverImageView = [UIImageView ly_ImageViewWithImageName:@"index_cover_top"];
        [_animationView addSubview:topCoverImageView];
        [topCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_animationView);
            make.height.mas_offset(100.0f);
        }];
    }
    return _animationView;
}

- (PandaMovieChannelNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[PandaMovieChannelNoDataView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableView.tableHeaderView.frame), kScreenWidth,  self.tableView.height - CGRectGetHeight(self.tableView.tableHeaderView.frame))];
        [self.tableView addSubview:_noDataView];
    }
    return _noDataView;
}

- (PandaMovieBannerDataModel *)bannerDataModel
{
    if (!_bannerDataModel) {
        _bannerDataModel = [self produceModel:[PandaMovieBannerDataModel class]];
    }
    return _bannerDataModel;;
}

- (PandaMovieFetchSubChanelMenuDataModel *)subChanelMenuDataModel
{
    if (!_subChanelMenuDataModel) {
        _subChanelMenuDataModel = [self produceModel:[PandaMovieFetchSubChanelMenuDataModel class]];
    }
    return _subChanelMenuDataModel;
}

- (PandaMoVieChannelSenceDataModel *)channelSenceDataModel
{
    if (!_channelSenceDataModel) {
        _channelSenceDataModel = [self produceModel:[PandaMoVieChannelSenceDataModel class]];
    }
    return _channelSenceDataModel;
}

- (PandaMovieVideoSenceRefreshDataModel *)videoSenceRefreshDataModel
{
    if (!_videoSenceRefreshDataModel) {
        _videoSenceRefreshDataModel = [self produceModel:[PandaMovieVideoSenceRefreshDataModel class]];
    }
    return _videoSenceRefreshDataModel;
}

@end
