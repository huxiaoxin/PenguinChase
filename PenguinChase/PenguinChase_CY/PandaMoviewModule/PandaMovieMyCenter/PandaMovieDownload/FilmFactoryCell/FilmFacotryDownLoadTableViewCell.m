
#import "FilmFacotryDownLoadTableViewCell.h"

@implementation ORDownLoadCellItem

@end

@interface  FilmFacotryDownLoadTableViewCell ()

@property (nonatomic, strong) UIImageView *FilmFactroycoverImageView;
@property (nonatomic, strong) UILabel *FilmFactroytitleLabel;
@property (nonatomic, strong) UILabel *FilmFactroytimeLabel;

@end

@implementation FilmFacotryDownLoadTableViewCell

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
    
    UIImageView *FilmFactroycoverImageView = [UIImageView ly_ViewWithColor:UIColor.clearColor];
    FilmFactroycoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:FilmFactroycoverImageView];
    [FilmFactroycoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(104, 57));
    }];
    self.FilmFactroycoverImageView = FilmFactroycoverImageView;
    
    UILabel *FilmFactroytitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize15 titleColor:gnh_color_a];
    [self.contentView addSubview:FilmFactroytitleLabel];
    FilmFactroytitleLabel.textAlignment = NSTextAlignmentLeft;
    [FilmFactroytitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FilmFactroycoverImageView).offset(3.0f);
        make.left.mas_equalTo(FilmFactroycoverImageView.mas_right).offset(10.f);
    }];
    self.FilmFactroytitleLabel = FilmFactroytitleLabel;
    
    UILabel *FilmFactroytimeLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView addSubview:FilmFactroytimeLabel];
    FilmFactroytimeLabel.textAlignment = NSTextAlignmentRight;
    [FilmFactroytimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FilmFactroytitleLabel);
        make.bottom.equalTo(FilmFactroycoverImageView).offset(-2.5f);
    }];
    self.FilmFactroytimeLabel = FilmFactroytimeLabel;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = NO;
    if ([item isKindOfClass:[ORDownLoadCellItem class]]) {
        ORDownLoadCellItem *cellItem = (ORDownLoadCellItem *)item;
        [self.FilmFactroycoverImageView sd_setImageWithURL:cellItem.coverImg.urlWithString];
        self.FilmFactroytitleLabel.text = cellItem.videoName;
        self.FilmFactroytimeLabel.text = @(cellItem.videoSeconds.intValue / 60).stringValue;
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[ORDownLoadCellItem class]]) {
        return 77.0f;
    }
    
    return 50.0f;
}

@end
