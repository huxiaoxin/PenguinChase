//
//  PandaMovieChannelTableViewCell.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/21.
//

#import "PandaMovieChannelTableViewCell.h"
#import "PandaMovieChannelBaseItemView.h"

#define kItemWidth (kScreenWidth - 10 * 2 - 10)/3.0
#define kItemHeight (200.0f * kItemWidth)/115.0

@interface ORChannelCollectionCell : UICollectionViewCell
@property (nonatomic, strong) PandaMovieChannelBaseItemView *channelItemView;

- (void)reloadCollectionViewData:(PandaMovieVideoBaseItem *)dataItem;

@end

@implementation ORChannelCollectionCell

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


@interface PandaMovieChannelTableViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView; // 直播展示区
@property (nonatomic, strong) ORChannelSenceDataItem *channelItem;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moreLabel; // 更多

@property (nonatomic, strong) UIButton *refreshButton; // 刷新

@end

@implementation PandaMovieChannelTableViewCell

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
    
    UIView *topView = [UIView ly_ViewWithColor:LGDViewBJColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(@43);
    }];
    
    UIImageView *iconImageView = [UIImageView ly_ImageViewWithImageName:@"index_hot"];
    [topView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10.5f);
        make.centerY.equalTo(topView);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize17 titleColor:[UIColor whiteColor]];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImageView);
        make.left.equalTo(iconImageView.mas_right).offset(7.0f);
    }];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageView = [UIImageView ly_ImageViewWithImageName:@"com_arrow"];
    [topView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-10.5f);
        make.centerY.equalTo(topView);
    }];
    
    UILabel *moreLabel = [UILabel ly_LabelWithTitle:@"更多" font:zy_mediumSystemFont15 titleColor:gnh_color_j];
    [topView addSubview:moreLabel];
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImageView);
        make.right.equalTo(arrowImageView.mas_left).offset(1.0f);
    }];
    self.moreLabel = moreLabel;
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = LGDViewBJColor;
    [collectionView registerClass:[ORChannelCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(43.0f);
        make.bottom.equalTo(self.contentView).offset(-42.0f - 5.0f);
        make.left.right.equalTo(self.contentView).inset(10.0f);
    }];
    self.collectionView = collectionView;
    
    UIButton *refreshButton = [UIButton ly_ButtonWithNormalImageName:@"index_refresh" selecteImageName:@"index_refresh" target:self selector:@selector(refreshAction:)];
    [refreshButton setTitle:@"换一换" forState:UIControlStateNormal];
    [refreshButton setTitleColor:gnh_color_a forState:UIControlStateNormal];
    refreshButton.titleLabel.font = zy_mediumSystemFont15;
    refreshButton.backgroundColor = RGBA_HexCOLOR(0xf5f5f5, 1.0);
    [refreshButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [refreshButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    refreshButton.layer.cornerRadius = 8.0f;
    refreshButton.layer.masksToBounds = YES;
    [self.contentView addSubview:refreshButton];
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(collectionView.mas_bottom);
        make.left.right.equalTo(self.contentView).inset(10.0f);
        make.height.mas_offset(42.0f);
    }];
    self.refreshButton = refreshButton;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[ORChannelSenceDataItem class]]) {
        ORChannelSenceDataItem *channelItem = (ORChannelSenceDataItem *)item;
        self.channelItem = channelItem;
        self.topLine.hidden = YES;
        self.bottomLine.hidden = YES;
        
        self.titleLabel.text = channelItem.name;
        self.iconImageView.hidden = YES;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12.5f);
        }];
        [self.collectionView reloadData];
        
        // 点击更多
        GNHWeakSelf;
        [self.moreLabel setEnlargeEdgeWithTop:20 right:50 bottom:20 left:20];
        [self.moreLabel mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
            if (weakSelf.channelItemCallBack) {
                weakSelf.channelItemCallBack(nil, channelItem.scene, channelItem.name, 1);
            }
        }];
    }
}

#pragma mark - ButtonAction

- (void)refreshAction:(UIButton *)button
{
    if (self.refreshDataCallback) {
        self.refreshDataCallback(self.channelItem.scene, self.indexPath.row);
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
    return self.channelItem.videoDtoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORChannelCollectionCell *cell = (ORChannelCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.channelItem.videoDtoList.count) {
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.channelItem.videoDtoList mdf_safeObjectAtIndex:indexPath.row];
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
        PandaMovieVideoBaseItem *channelBaseItem = (PandaMovieVideoBaseItem *)[self.channelItem.videoDtoList mdf_safeObjectAtIndex:indexPath.row];
        self.channelItemCallBack(channelBaseItem, nil, nil, 0);
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[ORChannelSenceDataItem class]]) {
        ORChannelSenceDataItem *channelItem = (ORChannelSenceDataItem *)item;
        NSInteger count = channelItem.videoDtoList.count ;
        if (count > 0) {
            CGFloat height = 0.0f;
            if (count % 3 == 0) {
                height = (count / 3) * (kItemHeight + 5.0f); // 高度 + 间隙
            } else {
                height = (count / 3 + 1) * (kItemHeight + 5.0f); // 高度 + 间隙
            }
            
            return height + 43.0f + 42.0f + 5;
        }
    }
    
    return [super heightForItem:item];
}

@end
