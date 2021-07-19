

#import "PandaMovieChooseSourceView.h"

@interface PandaMovieChooseSourceCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *PandaMovieiconImageView;
@property (nonatomic, strong) UILabel *PandaMovienameLabel;

- (void)refreshData:(NSString *)icon sourceName:(NSString *)sourceName;

@end

@implementation PandaMovieChooseSourceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *PandaMovieiconImageView = [UIImageView ly_ViewWithColor:UIColor.whiteColor];
        [self addSubview:PandaMovieiconImageView];
        [PandaMovieiconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20.0f);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(21.0f, 21.0));
        }];
        self.PandaMovieiconImageView = PandaMovieiconImageView;
        
        UILabel *PandaMovienameLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont14 titleColor:RGBA_HexCOLOR(0x31333A, 1.0)];
        [self addSubview:PandaMovienameLabel];
        self.PandaMovienameLabel = PandaMovienameLabel;
    }
    return self;
}

- (void)refreshData:(NSString *)icon sourceName:(NSString *)sourceName
{
    
    [self.PandaMovieiconImageView sd_setImageWithURL:icon.urlWithString];
    self.PandaMovienameLabel.text = sourceName;
    
    if (!icon.length) {
        [self.PandaMovienameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    } else {
        [self.PandaMovienameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.PandaMovieiconImageView.mas_right).offset(4.0);
            make.centerY.equalTo(self.PandaMovieiconImageView);
        }];
    }
}

@end


@interface PandaMovieChooseSourceView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <__kindof PandaMovieVideoSourceItem *> *sources;
@property (nonatomic, copy) NSString *selectSourceName;

@end


@implementation PandaMovieChooseSourceView

- (instancetype)PandaMovieinitWithFrame:(CGRect)frame sources:(NSMutableArray <__kindof PandaMovieVideoSourceItem *> *)sources selectSource:(NSString *)selectSourceName{
    if (self == [super initWithFrame:frame]) {
        self.sources = sources;
        self.selectSourceName = selectSourceName;
        self.backgroundColor = UIColor.whiteColor;

        [self setupView];
            
        [self setupData];
    }
    return self;
}

#pragma mark - setup

- (void)setupView
{
    UICollectionViewFlowLayout *channelCountFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [channelCountFlowLayout setItemSize:CGSizeMake(110, 36)];
    [channelCountFlowLayout setMinimumLineSpacing:10];
    [channelCountFlowLayout setMinimumInteritemSpacing:12];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:channelCountFlowLayout];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    collectionView.backgroundColor = UIColor.whiteColor;
    [collectionView registerClass:[PandaMovieChooseSourceCollectionViewCell class] forCellWithReuseIdentifier:
     @"PandaMovieChooseSourceCollectionViewCell"];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setupData
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PandaMovieChooseSourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PandaMovieChooseSourceCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 8.0f;
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = RGBA_HexCOLOR(0xDFDFDF, 1.0).CGColor;
    
    PandaMovieVideoSourceItem *item = (PandaMovieVideoSourceItem *)[self.sources mdf_safeObjectAtIndex:indexPath.row];
    [cell refreshData:item.icon sourceName:item.sourceName];
    
    // 添加选中边框
    if ([item.sourceName isEqualToString:self.selectSourceName]) {
        cell.PandaMovienameLabel.textColor = gnh_color_theme;
        cell.layer.borderColor = gnh_color_theme.CGColor;
    } else {
        cell.PandaMovienameLabel.textColor = RGBA_HexCOLOR(0x31333A, 1.0);
        cell.layer.borderColor = RGBA_HexCOLOR(0xDFDFDF, 1.0).CGColor;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PandaMovieVideoSourceItem *item = (PandaMovieVideoSourceItem *)[self.sources mdf_safeObjectAtIndex:indexPath.row];
    if (self.chooseSourceCompleteBlock) {
        self.chooseSourceCompleteBlock(item.sourceName);
        self.hidden = YES;
    }
}

#pragma mark - HitTest

- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            if ([view.layer.presentationLayer hitTest:point]) {
                return view;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}
    

@end
