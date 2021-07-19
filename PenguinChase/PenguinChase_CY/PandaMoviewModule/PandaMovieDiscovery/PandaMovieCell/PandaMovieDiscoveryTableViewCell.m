
#import "PandaMovieDiscoveryTableViewCell.h"
#import "PandaMovieChannelBaseItemView.h"
#import "PandaMovieDiscoveryBaseView.h"

#define kItemWidth (kScreenWidth - 10 * 2 - 10)/3.0
#define kItemHeight (200.0f * kItemWidth)/115.0

@interface ORDiscoverCollectionCell : UICollectionViewCell
@property (nonatomic, strong) PandaMovieDiscoveryBaseView *PandaMoviechannelItemView;

- (void)FilmFactroyreloadCollectionViewData:(PandaMovieDiscoveryDataItem *)dataItem;

@end

@implementation ORDiscoverCollectionCell

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PandaMovieDiscoveryBaseView *PandaMoviechannelItemView = [[PandaMovieDiscoveryBaseView alloc] init];
        [self addSubview:PandaMoviechannelItemView];
        [PandaMoviechannelItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        self.PandaMoviechannelItemView = PandaMoviechannelItemView;
    }
    
    return [super initWithFrame:frame];
}

- (void)FilmFactroyreloadCollectionViewData:(PandaMovieDiscoveryDataItem *)dataItem
{
    [self.PandaMoviechannelItemView PandaMovierefreshData:dataItem];
}

@end


@interface PandaMovieDiscoveryTableViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView; // 直播展示区
@property (nonatomic, strong) PandaMovieDiscoveryItem *discoveryItem;

@end

@implementation PandaMovieDiscoveryTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LGDViewBJColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = LGDViewBJColor;
    [collectionView registerClass:[ORDiscoverCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView).inset(10.0f);
    }];
    self.collectionView = collectionView;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieDiscoveryItem class]]) {
        PandaMovieDiscoveryItem *channelItem = (PandaMovieDiscoveryItem *)item;
        self.discoveryItem = channelItem;
        self.topLine.hidden = YES;
        self.bottomLine.hidden = YES;
    
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionView Delegate & dataSource

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.discoveryItem.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORDiscoverCollectionCell *cell = (ORDiscoverCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.discoveryItem.list.count) {
        PandaMovieDiscoveryDataItem *channelBaseItem = (PandaMovieDiscoveryDataItem *)[self.discoveryItem.list mdf_safeObjectAtIndex:indexPath.row];
        [cell FilmFactroyreloadCollectionViewData:channelBaseItem];
    }
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kItemWidth, kItemHeight);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pandachannelItemCallBack) {
        PandaMovieDiscoveryDataItem *channelBaseItem = (PandaMovieDiscoveryDataItem *)[self.discoveryItem.list mdf_safeObjectAtIndex:indexPath.row];
        self.pandachannelItemCallBack(channelBaseItem);
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieDiscoveryItem class]]) {
        PandaMovieDiscoveryItem *channelItem = (PandaMovieDiscoveryItem *)item;
        if (channelItem.list.count) {
            CGFloat height = 0.0f;
            if (channelItem.list.count % 3 == 0) {
                height = (channelItem.list.count / 3) * (kItemHeight + 5.0f); // 高度 + 间隙
            } else {
                height = (channelItem.list.count / 3 + 1) * (kItemHeight + 5.0f); // 高度 + 间隙
            }
            
            return height + 5;
        }
    }
    
    return [super heightForItem:item];
}

@end
