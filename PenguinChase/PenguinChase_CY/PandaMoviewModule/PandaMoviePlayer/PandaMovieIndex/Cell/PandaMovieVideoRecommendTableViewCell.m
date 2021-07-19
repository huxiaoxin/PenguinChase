
#import "PandaMovieVideoRecommendTableViewCell.h"
#import "PandaMovieChannelBaseItemView.h"
#import "PandaMovieVideoRecommendView.h"
#import "PandaMovieVideoRecommendDataModel.h"

#define kItemWidth (kScreenWidth - 10 * 2 - 10)/3.0
#define kItemHeight (200.0f * kItemWidth)/115.0

@interface ORVideoRecommedCollectionCell : UICollectionViewCell
@property (nonatomic, strong) PandaMovieVideoRecommendView *pandaitemView;

- (void)reloadCollectionViewData:(PandaMovieVideoBaseItem *)dataItem;

@end

@implementation ORVideoRecommedCollectionCell

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PandaMovieVideoRecommendView *pandaitemView = [[PandaMovieVideoRecommendView alloc] init];
        [self addSubview:pandaitemView];
        [pandaitemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        self.pandaitemView = pandaitemView;
    }
    
    return [super initWithFrame:frame];
}

- (void)reloadCollectionViewData:(PandaMovieVideoBaseItem *)dataItem
{
    [self.pandaitemView refreshData:dataItem];
}

@end


@interface PandaMovieVideoRecommendTableViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView; // 直播展示区
@property (nonatomic, strong) PandaMovieVideoRecommendItem *videoRecommendItem;

@end

@implementation PandaMovieVideoRecommendTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = gnh_color_b;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"为你推荐" font:zy_blodFontSize17 titleColor:gnh_color_k];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17.0f);
        make.left.equalTo(self.contentView).offset(13.0f);
        make.height.mas_offset(16.0f);
    }];
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = gnh_color_b;
    [collectionView registerClass:[ORVideoRecommedCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(43.0f);
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView).inset(10.0f);
    }];
    self.collectionView = collectionView;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieVideoRecommendItem class]]) {
        PandaMovieVideoRecommendItem *videoRecommendItem = (PandaMovieVideoRecommendItem *)item;
        self.videoRecommendItem = videoRecommendItem;
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
    return self.videoRecommendItem.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORVideoRecommedCollectionCell *cell = (ORVideoRecommedCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.videoRecommendItem.data.count) {
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.videoRecommendItem.data mdf_safeObjectAtIndex:indexPath.row];
        [cell reloadCollectionViewData:channelBaseItem];
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
    if (self.recommendItemCallBack) {
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.videoRecommendItem.data mdf_safeObjectAtIndex:indexPath.row];
        self.recommendItemCallBack(channelBaseItem);
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieVideoRecommendItem class]]) {
        PandaMovieVideoRecommendItem *videoRecommendItem = (PandaMovieVideoRecommendItem *)item;
        if (videoRecommendItem.data.count) {
            CGFloat height = 0.0f;
            if (videoRecommendItem.data.count % 3 == 0) {
                height = (videoRecommendItem.data.count / 3) * (kItemHeight + 5.0f); // 高度 + 间隙
            } else {
                height = (videoRecommendItem.data.count / 3 + 1) * (kItemHeight + 5.0f); // 高度 + 间隙
            }
            
            return height + 43 + 5 + ORKitMacros.iphoneXSafeHeight;
        }
    }
    
    return [super heightForItem:item];
}

@end
