

#import "PandaMovieWatchRecordTableViewCell.h"

@interface  PandaMovieWatchRecordTableViewCell ()

@property (nonatomic, strong) UIImageView *PandaMoviecoverImageView;
@property (nonatomic, strong) UILabel *PandaMovietitleLabel;
@property (nonatomic, strong) UILabel *PandaMovietimeLabel;

@end

@implementation PandaMovieWatchRecordTableViewCell

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
        make.left.equalTo(self.contentView).offset(18.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(104, 57));
    }];
    self.PandaMoviecoverImageView = PandaMoviecoverImageView;
    
    UILabel *PandaMovietitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize15 titleColor:gnh_color_a];
    [self.contentView addSubview:PandaMovietitleLabel];
    PandaMovietitleLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMovietitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecoverImageView).offset(3.0f);
        make.left.mas_equalTo(PandaMoviecoverImageView.mas_right).offset(10.f);
    }];
    self.PandaMovietitleLabel = PandaMovietitleLabel;
    
    UILabel *PandaMovietimeLabel = [UILabel ly_LabelWithTitle:@"观看至" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView addSubview:PandaMovietimeLabel];
    PandaMovietimeLabel.textAlignment = NSTextAlignmentRight;
    [PandaMovietimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PandaMovietitleLabel);
        make.bottom.equalTo(PandaMoviecoverImageView).offset(-2.5f);
    }];
    self.PandaMovietimeLabel = PandaMovietimeLabel;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    if ([item isKindOfClass:[PandaMovieWatchRecordDataItem class]]) {
        PandaMovieWatchRecordDataItem *cellItem = (PandaMovieWatchRecordDataItem *)item;
        [self.PandaMoviecoverImageView sd_setImageWithURL:cellItem.coverImg.urlWithString];
        self.PandaMovietitleLabel.text = cellItem.videoName;

        NSInteger hour = cellItem.watchSeconds/60.0/60.0;
        NSInteger minite = cellItem.watchSeconds/60.0;
        if (minite >= 60) {
            minite = minite % 60;
        }
        NSInteger seconds = cellItem.watchSeconds % 60;
        
        NSString *timeStr = @"";
        if (hour >= 1) {
            timeStr = [NSString stringWithFormat:@"%02ld:",(long)hour];
        }
        timeStr = [timeStr stringByAppendingFormat:@"%02ld:%02ld", (long)minite, (long)seconds];
        self.PandaMovietimeLabel.text = [NSString stringWithFormat:@"观看至 %@",timeStr];
    }
}

#pragma mark - Override System Method

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieWatchRecordDataItem class]]) {
        return 77.0f;
    }
    
    return 50.0f;
}

@end


