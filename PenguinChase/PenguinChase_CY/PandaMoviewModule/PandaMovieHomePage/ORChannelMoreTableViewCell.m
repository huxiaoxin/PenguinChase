//
//  ORChannelMoreTableViewCell.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/25.
//

#import "ORChannelMoreTableViewCell.h"
#import "PandaMovieChannelBaseItemView.h"

#define kItemWidth (kScreenWidth - 10 * 2 - 10)/3.0
#define kItemHeight (200.0f * kItemWidth)/115.0

@interface ORChannelMoreCollectionCell : UICollectionViewCell
@property (nonatomic, strong) PandaMovieChannelBaseItemView *channelItemView;

- (void)reloadCollectionViewData:(PandaMovieVideoBaseItem *)dataItem;

@end

@implementation ORChannelMoreCollectionCell

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PandaMovieChannelBaseItemView *channelItemView = [[PandaMovieChannelBaseItemView alloc] init];
        [self addSubview:channelItemView];
        [channelItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        self.channelItemView = channelItemView;
    }
    
    return [super initWithFrame:frame];
}

- (void)reloadCollectionViewData:(PandaMovieVideoBaseItem *)dataItem
{
    [self.channelItemView refreshData:dataItem];
}

@end


@interface ORChannelMoreTableViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView; // 直播展示区
@property (nonatomic, strong) PandaMovieIndexChannelItem *recommendChannelItem;

@end

@implementation ORChannelMoreTableViewCell

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
    [collectionView registerClass:[ORChannelMoreCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10.0f);
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView).inset(10.0f);
    }];
    self.collectionView = collectionView;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    PandaMovieIndexChannelItem *channelItem = (PandaMovieIndexChannelItem *)item;
    self.recommendChannelItem = channelItem;
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    [self.collectionView reloadData];
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
    return self.recommendChannelItem.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORChannelMoreCollectionCell *cell = (ORChannelMoreCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.recommendChannelItem.list.count) {
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.recommendChannelItem.list mdf_safeObjectAtIndex:indexPath.row];
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
    if (self.channelItemCallBack) {
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.recommendChannelItem.list mdf_safeObjectAtIndex:indexPath.row];
        self.channelItemCallBack(channelBaseItem);
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieIndexChannelItem class]]) {
        PandaMovieIndexChannelItem *channelItem = (PandaMovieIndexChannelItem *)item;
        if (channelItem.list.count) {
            CGFloat height = 0.0f;
            if (channelItem.list.count % 3 == 0) {
                height = (channelItem.list.count / 3) * (kItemHeight + 5.0f); // 高度 + 间隙
            } else {
                height = (channelItem.list.count / 3 + 1) * (kItemHeight + 5.0f); // 高度 + 间隙
            }
            
            return height + 5 + 10;
        }
    }
    
    return [super heightForItem:item];
}

@end
