//
//  ORChannelNoDataView.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/20.
//

#import "ORChannelNoDataView.h"

@implementation ORChannelNoDataView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = gnh_color_c;
        
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIImageView *iconImageView = [UIImageView ly_ImageViewWithImageName:@"com_noData"];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(240.0f - kGNHNavigationBarHeight - kGNHStatusBarHeight);
        make.centerX.equalTo(self);
    }];
    
    UILabel *tipsLabel = [UILabel ly_LabelWithTitle:@"暂无数据～" font:zy_mediumSystemFont14 titleColor:gnh_color_e];
    [self addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom).offset(32.5);
        make.centerX.equalTo(self);
    }];
}

@end
