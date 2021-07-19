

#import "PandaMovieSearchResultTableViewCell.h"
#import "PandaMovieVideoBaseItem.h"

@interface PandaMovieSearchResultTableViewCell ()
@property (nonatomic, strong) UIImageView *PandaMoviecoverImageView; // 封面
@property (nonatomic, strong) UILabel *PandaMovievideoNameLabel; // 名字
@property (nonatomic, strong) UILabel *PandaMovieepisodesLabel; // 集数
@property (nonatomic, strong) UILabel *PandaMoviedescLabel; // 描述
@property (nonatomic, strong) UILabel *PandaMovieactorLabel; // 演员
@property (nonatomic, strong) PandaMovieVideoBaseItem *videoBaseItem;

@end

@implementation PandaMovieSearchResultTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = gnh_color_c;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UIImageView *PandaMoviecoverImageView = [UIImageView ly_ViewWithColor:gnh_color_line];
    PandaMoviecoverImageView.layer.cornerRadius = 10.0f;
    PandaMoviecoverImageView.layer.masksToBounds = YES;
    PandaMoviecoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:PandaMoviecoverImageView];
    [PandaMoviecoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15.0f);
        make.left.equalTo(self).offset(11);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    self.PandaMoviecoverImageView = PandaMoviecoverImageView;
    
    UILabel *PandaMovievideoNameLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont14 titleColor:gnh_color_r];
    [self.contentView  addSubview:PandaMovievideoNameLabel];
    [PandaMovievideoNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecoverImageView).offset(6.5f);
        make.left.equalTo(PandaMoviecoverImageView.mas_right).offset(10.5f);
        make.right.equalTo(self).offset(-15.0f);
        make.height.mas_offset(13.0f);
    }];
    self.PandaMovievideoNameLabel = PandaMovievideoNameLabel;
    
    UILabel *PandaMovieepisodesLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView  addSubview:PandaMovieepisodesLabel];
    [PandaMovieepisodesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMovievideoNameLabel.mas_bottom).offset(17.5f);
        make.left.equalTo(PandaMoviecoverImageView.mas_right).offset(10.5f);
        make.height.mas_offset(11.5f);
    }];
    self.PandaMovieepisodesLabel = PandaMovieepisodesLabel;
    
    UILabel *PandaMoviedescLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView  addSubview:PandaMoviedescLabel];
    [PandaMoviedescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMovieepisodesLabel.mas_bottom).offset(9.5f);
        make.left.equalTo(PandaMoviecoverImageView.mas_right).offset(10.5f);
        make.height.mas_offset(11.5f);
    }];
    self.PandaMoviedescLabel = PandaMoviedescLabel;
    
    UILabel *PandaMovieactorLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [self.contentView addSubview:PandaMovieactorLabel];
    [PandaMovieactorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviedescLabel.mas_bottom).offset(9.5f);
        make.left.equalTo(PandaMoviecoverImageView.mas_right).offset(10.5f);
        make.height.mas_offset(11.5f);
    }];
    self.PandaMovieactorLabel = PandaMovieactorLabel;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieVideoBaseItem class]]) {
        PandaMovieVideoBaseItem *videoBaseItem = (PandaMovieVideoBaseItem *)item;
        self.videoBaseItem = videoBaseItem;
        self.topLine.hidden = YES;
        self.bottomLine.hidden = YES;
        
        [self.PandaMoviecoverImageView sd_setImageWithURL:videoBaseItem.coverImg.urlWithString];
        self.PandaMovievideoNameLabel.text = videoBaseItem.videoName;
        
        self.PandaMovieepisodesLabel.hidden = YES;
        if (videoBaseItem.videoTag.length) {
            self.PandaMovieepisodesLabel.text = videoBaseItem.videoTag;
            self.PandaMovieepisodesLabel.hidden = NO;
        }
        
        // 描述
        NSString *descStr = unemptyString(videoBaseItem.yearTypeCh, @"");
        if (descStr.length) {
            if (videoBaseItem.typeCh.length) {
                descStr = [descStr stringByAppendingFormat:@"/%@", videoBaseItem.typeCh];
            }
            if (videoBaseItem.childTypeCh.length) {
                descStr = [descStr stringByAppendingFormat:@"/%@", videoBaseItem.childTypeCh];
            }
        }
        self.PandaMoviedescLabel.text = descStr;
        // 演员
        if (videoBaseItem.actor.length) {
            self.PandaMovieactorLabel.text = [@"主演：" stringByAppendingString:videoBaseItem.actor];
        }
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieVideoBaseItem class]]) {
        return 100 + 15.0f;
    }
    
    return [super heightForItem:item];
}

@end
