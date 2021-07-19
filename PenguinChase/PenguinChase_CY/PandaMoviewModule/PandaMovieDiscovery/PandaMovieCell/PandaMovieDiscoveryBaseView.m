

#import "PandaMovieDiscoveryBaseView.h"

@interface PandaMovieDiscoveryBaseView ()

@property (nonatomic, strong) UIImageView *PandaMoviecoverImageView; // 封面
@property (nonatomic, strong) UIImageView *PandaMoVieplayImageView; // 播放标记
@property (nonatomic, strong) UILabel *PandaMovietipsLabel; // 提示（全集 、评分）
@property (nonatomic, strong) UILabel *PandaMovienameLabel; // 影视名称

@end

@implementation PandaMovieDiscoveryBaseView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LGDViewBJColor;
        
        [self setupUIs];
    }
    
    return self;
}

- (void)setupUIs
{
    // 封面
    UIImageView *PandaMoviecoverImageView = [UIImageView ly_ViewWithColor:gnh_color_line];
    PandaMoviecoverImageView.layer.cornerRadius = 10.0f;
    PandaMoviecoverImageView.layer.masksToBounds = YES;
    PandaMoviecoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:PandaMoviecoverImageView];
    [PandaMoviecoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(166.0f * ((kScreenWidth - 20 - 10)/3.0) / 115.0f);
    }];
    self.PandaMoviecoverImageView = PandaMoviecoverImageView;
    
    UIImageView *bottomCoverImgView = [UIImageView ly_ImageViewWithImageName:@"PandaMoview_thub_icon_bg"];
    [PandaMoviecoverImageView addSubview:bottomCoverImgView];
    [bottomCoverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(PandaMoviecoverImageView);
        make.height.mas_equalTo(@(27.5));
    }];
    
    UILabel *PandaMovietipsLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont12 titleColor:gnh_color_b];
    [PandaMoviecoverImageView addSubview:PandaMovietipsLabel];
    [PandaMovietipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PandaMoviecoverImageView).offset(-7.5f);
        make.bottom.equalTo(PandaMoviecoverImageView).offset(-4.5f);
        make.height.mas_equalTo(@11.5f);
    }];
    PandaMovietipsLabel.textAlignment = NSTextAlignmentRight;
    self.PandaMovietipsLabel = PandaMovietipsLabel;
    
    // 影视名称
    UILabel *PandaMovienameLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont14 titleColor:[UIColor whiteColor]];
    [self addSubview:PandaMovienameLabel];
    [PandaMovienameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecoverImageView.mas_bottom).offset(7.5f);
        make.left.equalTo(PandaMoviecoverImageView).offset(2.5f);
        make.right.equalTo(PandaMoviecoverImageView).offset(-10.0f);
        make.height.mas_equalTo(@13);
    }];
    PandaMovienameLabel.textAlignment = NSTextAlignmentLeft;
    self.PandaMovienameLabel = PandaMovienameLabel;
}

- (void)PandaMovierefreshData:(PandaMovieDiscoveryDataItem *)dataItem
{
    [self.PandaMoviecoverImageView sd_setImageWithURL:[NSURL URLWithString:dataItem.coverImg] placeholderImage:[UIImage imageNamed:@"PandaMoview_default_thubIcon"]];
    self.PandaMovietipsLabel.text = unemptyString(dataItem.videoTag,  [NSString stringWithFormat:@"%.1f", dataItem.score.floatValue]);
    self.PandaMovienameLabel.text = dataItem.videoName;
}

@end
