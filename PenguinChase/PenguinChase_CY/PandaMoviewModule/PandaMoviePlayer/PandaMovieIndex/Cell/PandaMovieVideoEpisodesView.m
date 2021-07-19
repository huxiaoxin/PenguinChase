//
//  PandaMovieVideoEpisodesView.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/26.
//

#import "PandaMovieVideoEpisodesView.h"

@interface PandaMovieVideoEpisodesView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) LYCoverView *backView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) PandaMovieVideoDetailItem *videoDetailItem;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation PandaMovieVideoEpisodesView

#pragma mark - Class Method

+ (LYCoverView *)showIntroAlertView:(PandaMovieVideoDetailItem *)detailItem completeBlock:(PandaMovieVideoEpisodesCompleteBlock)completeBlock
{
    LYCoverView *backView = [LYCoverView showView:nil inView:[ORAppWindow appWindow]];
    backView.touchDisMiss = NO;
    
    CGFloat orgin_y = ORKitMacros.statusBarHeight + (212.5 * kScreenWidth)/375.0;
    PandaMovieVideoEpisodesView *contentView = [[PandaMovieVideoEpisodesView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - orgin_y)];
    contentView.backView = backView;
    contentView.videoEpisodesCompleteBlock = completeBlock;
    contentView.videoDetailItem = detailItem;
    [backView addSubview:contentView];
    [contentView setupData];
    
    [UIView animateWithDuration:0.25 animations:^{
        contentView.frame = CGRectMake(0, orgin_y, kScreenWidth, kScreenHeight - orgin_y);
    }];
    
    return backView;
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"选集" font:zy_blodFontSize17 titleColor:gnh_color_k];
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(13.0f);
        make.height.mas_offset(45.0f);
    }];
    
    UIButton *closeButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_close_arrow" selecteImageName:@"pandaMoview_close_arrow" target:self selector:@selector(closeAction:)];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-9.5f);
        make.centerY.equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    [closeButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    UIView *liveView = [UIView ly_ViewWithColor:gnh_color_line];
    [self addSubview:liveView];
    [liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    collectionView.backgroundColor = gnh_color_b;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(liveView.mas_bottom).offset(17.0f);
        make.bottom.equalTo(self).offset(-ORKitMacros.iphoneXSafeHeight);
        make.left.right.equalTo(self).inset(15.0f);
    }];
    self.collectionView = collectionView;
}

#pragma mark - buttonAction

- (void)closeAction:(UIButton *)btn
{
    [self.backView disMiss];
}

#pragma mark - setupData

- (void)setupData
{

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
    NSString *sourceName = self.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoDetailItem.episodes[sourceName];
    
    return episodes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sourceName = self.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoDetailItem.episodes[sourceName];
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    UILabel *tagLabel = nil;
    for (UIView *subview in cell.contentView.subviews) {
        if (subview.tag >= 100 && [subview isKindOfClass:[UILabel class]]) {
            tagLabel = (UILabel *)subview;
        }
    }
    if (!tagLabel) {
        tagLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize18 titleColor:gnh_color_k];
        tagLabel.layer.cornerRadius = 5.f;
        tagLabel.layer.borderWidth = 0.5f;
        tagLabel.layer.masksToBounds = YES;
        tagLabel.tag = indexPath.row + 100;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        NSString *episode = [episodes mdf_safeObjectAtIndex:indexPath.row];
        if ([episode isEqualToString:self.videoDetailItem.episode]) {
            self.selectIndexPath = indexPath;
        }
    }
    
    if ([[episodes mdf_safeObjectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        tagLabel.text = [episodes mdf_safeObjectAtIndex:indexPath.row];
    } else {
        tagLabel.text = [[episodes mdf_safeObjectAtIndex:indexPath.row] stringValue];
    }
    tagLabel.layer.borderColor = gnh_color_t.CGColor;
    tagLabel.textColor = gnh_color_k;
    if (self.selectIndexPath.row == indexPath.row && self.selectIndexPath) {
        tagLabel.layer.borderColor = gnh_color_theme.CGColor;
        tagLabel.textColor = gnh_color_theme;
    }
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sourceName = self.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoDetailItem.episodes[sourceName];
    CGSize rectSize = [@([episodes.lastObject intValue]).stringValue textWithSize:18 size:CGSizeZero];
    
    return CGSizeMake(rectSize.width + 40.0f, 40.0f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    NSString *sourceName = self.videoDetailItem.source.sourceName;
    NSArray *episodes = self.videoDetailItem.episodes[sourceName];
    CGSize rectSize = [@([episodes.lastObject intValue]).stringValue textWithSize:18 size:CGSizeZero];
    
    CGFloat gap = 10.0f;
    for (NSInteger i = 2; i < 8; i++) {
        CGFloat gapTmp = (kScreenWidth - 30.0f - i * (rectSize.width + 40.0f)) / (i - 1);
        if (gapTmp > 0) {
            if (gapTmp < 5.0f) {
                // 取上一次
                break;
            }
            gap = gapTmp;
            
            if (gap <= 10.0f) {
                break;
            }
        } else {
            break;;
        }
    }
        
    return gap;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *preSelectCell = [collectionView cellForItemAtIndexPath:self.selectIndexPath];
    UILabel *tmpPreLabel = [preSelectCell.contentView viewWithTag:self.selectIndexPath.row + 100];
    tmpPreLabel.layer.borderColor = gnh_color_t.CGColor;
    tmpPreLabel.textColor = gnh_color_k;
    
    self.selectIndexPath = indexPath;
    
    UICollectionViewCell *selectCell = [collectionView cellForItemAtIndexPath:self.selectIndexPath];
    UILabel *tmpLabel = [selectCell.contentView viewWithTag:self.selectIndexPath.row + 100];
    tmpLabel.layer.borderColor = gnh_color_theme.CGColor;
    tmpLabel.textColor = gnh_color_theme;
    
    if (self.videoEpisodesCompleteBlock) {
        self.videoEpisodesCompleteBlock(self.selectIndexPath.row);

        [self.backView disMiss];
    }
}


@end
