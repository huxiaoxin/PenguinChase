

#import "PandaMovieChannelNoDataView.h"

@implementation PandaMovieChannelNoDataView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = gnh_color_c;
        
        [self FilmFactorysetupView];
    }
    return self;
}

- (void)FilmFactorysetupView
{
    UIImageView *PandaMovieiconImageView = [UIImageView ly_ImageViewWithImageName:@"PandaMoview_nodat"];
    [self addSubview:PandaMovieiconImageView];
    [PandaMovieiconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(240.0f - kGNHNavigationBarHeight - kGNHStatusBarHeight);
        make.centerX.equalTo(self);
    }];
    
    UILabel *PandaMovietipsLabel = [UILabel ly_LabelWithTitle:@"暂无数据～" font:zy_mediumSystemFont14 titleColor:gnh_color_e];
    [self addSubview:PandaMovietipsLabel];
    [PandaMovietipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMovieiconImageView.mas_bottom).offset(32.5);
        make.centerX.equalTo(self);
    }];
}

@end
