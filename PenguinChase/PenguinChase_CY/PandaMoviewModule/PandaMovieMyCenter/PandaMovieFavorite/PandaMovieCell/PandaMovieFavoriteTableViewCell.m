

#import "PandaMovieFavoriteTableViewCell.h"

@interface  PandaMovieFavoriteTableViewCell ()

@property (nonatomic, strong) UIImageView *PandaMoviecoverImageView;
@property (nonatomic, strong) UILabel *PandaMovietitleLabel;
@property (nonatomic, strong) UILabel *PandaMovietypeLabel;

@end

@implementation PandaMovieFavoriteTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = gnh_color_b;
        self.tintColor = gnh_color_g;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UIImageView *PandaMoviecoverImageView = [UIImageView ly_ViewWithColor:gnh_color_line];
    PandaMoviecoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    PandaMoviecoverImageView.layer.cornerRadius = 7.5f;
    PandaMoviecoverImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:PandaMoviecoverImageView];
    [PandaMoviecoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15.0f);
        make.left.equalTo(self.contentView).offset(18.0f);
        make.size.mas_equalTo(CGSizeMake(60, 80));
    }];
    self.PandaMoviecoverImageView = PandaMoviecoverImageView;
    
    UILabel *FilmFactroytitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize15 titleColor:gnh_color_a];
    FilmFactroytitleLabel.numberOfLines = 0;
    [self.contentView addSubview:FilmFactroytitleLabel];
    FilmFactroytitleLabel.textAlignment = NSTextAlignmentLeft;
    [FilmFactroytitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecoverImageView).offset(17.0f);
        make.left.mas_equalTo(PandaMoviecoverImageView.mas_right).offset(20.f);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    self.PandaMovietitleLabel = FilmFactroytitleLabel;
    
    UILabel *PandaMovietypeLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView addSubview:PandaMovietypeLabel];
    PandaMovietypeLabel.textAlignment = NSTextAlignmentRight;
    [PandaMovietypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FilmFactroytitleLabel);
        make.bottom.equalTo(PandaMoviecoverImageView).offset(-14.5f);
    }];
    self.PandaMovietypeLabel = PandaMovietypeLabel;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    if ([item isKindOfClass:[PandaMovieFavoriteListDataItem class]]) {
        PandaMovieFavoriteListDataItem *cellItem = (PandaMovieFavoriteListDataItem *)item;
        [self.PandaMoviecoverImageView sd_setImageWithURL:cellItem.coverImg.urlWithString];
        self.PandaMovietitleLabel.text = cellItem.videoName;
        if (cellItem.videoTag.length) {
            self.PandaMovietypeLabel.text = [unemptyString(cellItem.typeCh, @"") stringByAppendingFormat:@" %@",cellItem.videoTag];
        } else {
            self.PandaMovietypeLabel.text = unemptyString(cellItem.typeCh, @"");
        }
    }
}

#pragma mark - Override System Method

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieFavoriteListDataItem class]]) {
        return 95.0f;
    }
    
    return 50.0f;
}

@end

