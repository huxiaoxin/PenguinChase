

#import "PandaMovieThrowScreenHelpViewController.h"

@interface PandaMovieThrowScreenHelpViewController ()

@end

@implementation PandaMovieThrowScreenHelpViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupData];
}

#pragma mark - setupUI

- (void)setupUI
{
    UIScrollView *contentScrollView = [UIScrollView ly_ViewWithColor:UIColor.whiteColor];
    [self.view addSubview:contentScrollView];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight));
    }];
    
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"如何投视频到电视？" font:zy_blodFontSize16 titleColor:RGBA_HexCOLOR(0x2B2D3C, 1.0)];
    [contentScrollView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentScrollView).offset(21.0f);
        make.height.mas_offset(15.0f);
    }];
    
    UILabel *firstLabel = [UILabel ly_LabelWithTitle:@"1" font:zy_blodFontSize12 titleColor:gnh_color_b];
    firstLabel.layer.cornerRadius = 8.0f;
    firstLabel.layer.masksToBounds = YES;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.backgroundColor = gnh_color_theme;
    [contentScrollView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(19.0f);
        make.left.equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(16.0f, 16.0f));
    }];
    
    UILabel *firstContentLabel = [UILabel ly_LabelWithTitle:nil font:zy_blodFontSize16 titleColor:gnh_color_f];
    [contentScrollView addSubview:firstContentLabel];
    firstContentLabel.numberOfLines = 0;
    [firstContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLabel).offset(-1);
        make.left.equalTo(firstLabel.mas_right).offset(6.0f);
        make.right.equalTo(self.view).offset(-26.0f);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{NSFontAttributeName:zy_mediumSystemFont15,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:gnh_color_f
                                 };
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"打开智能电视/盒子/投影仪/电视果，确认设备与手机连接着相同Wi-Fi。" attributes:attributes];
    firstContentLabel.attributedText = string;
    
    UIImageView *firstImageView = [UIImageView ly_ImageViewWithImageName:@"pandaMoview_wifi_icon_noen"];
    [contentScrollView addSubview:firstImageView];
    [firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstContentLabel.mas_bottom).offset(30.0f);
        make.centerX.equalTo(contentScrollView);
    }];
    
    UILabel *secondLabel = [UILabel ly_LabelWithTitle:@"2" font:zy_blodFontSize12 titleColor:gnh_color_b];
    secondLabel.layer.cornerRadius = 8.0f;
    secondLabel.layer.masksToBounds = YES;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.backgroundColor = gnh_color_theme;
    [contentScrollView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstImageView.mas_bottom).offset(31.0f);
        make.left.equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(16.0f, 16.0f));
    }];
    
    UILabel *secondContentLabel = [UILabel ly_LabelWithTitle:nil font:zy_blodFontSize16 titleColor:gnh_color_f];
    [contentScrollView addSubview:secondContentLabel];
    secondContentLabel.numberOfLines = 0;
    [secondContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLabel).offset(-1);
        make.left.equalTo(secondLabel.mas_right).offset(6.0f);
        make.right.equalTo(self.view).offset(-26.0f);
    }];

    NSMutableAttributedString *secondstring = [[NSMutableAttributedString alloc] initWithString:@"点击播放器右上角的TV投屏按钮进入投屏界面，选择想投屏的设备即可完成投屏。" attributes:attributes];
    secondContentLabel.attributedText = secondstring;
    
    UIImageView *secondImageView = [UIImageView ly_ImageViewWithImageName:@"PandaMoview_screend_shot_icon"];
    [contentScrollView addSubview:secondImageView];
    [secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondContentLabel.mas_bottom).offset(15.0f);
        make.centerX.equalTo(contentScrollView);
    }];
    
    UILabel *thirdTitleLabel = [UILabel ly_LabelWithTitle:@"为什么还是投射失败？" font:zy_blodFontSize16 titleColor:RGBA_HexCOLOR(0x2B2D3C, 1.0)];
    [contentScrollView addSubview:thirdTitleLabel];
    [thirdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondImageView.mas_bottom).offset(37.0f);
        make.left.equalTo(contentScrollView).offset(21.0f);
        make.height.mas_offset(15.0f);
    }];
    
    UILabel *thirdContentLabel = [UILabel ly_LabelWithTitle:nil font:zy_blodFontSize16 titleColor:gnh_color_f];
    [contentScrollView addSubview:thirdContentLabel];
    thirdContentLabel.numberOfLines = 0;
    [thirdContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdTitleLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(thirdTitleLabel);
        make.right.equalTo(self.view).offset(-26.0f);
    }];
    NSMutableAttributedString *thirdString = [[NSMutableAttributedString alloc] initWithString:@"1.电视/盒子与手机没有连接在同一个WiFi，或者 手机可能连接了4G网络。\n2.电视/盒子机型老旧，不支持DLNA投射协议， 建议在电视上安装乐播投屏进行投射。\n3.局域网中存在多个路由器，建议手机与设备处 于同一路由器的WiFi环境。" attributes:attributes];
    thirdContentLabel.attributedText = thirdString;
    contentScrollView.contentSize = CGSizeMake(300, kScreenHeight - ORKitMacros.navigationBarHeight - ORKitMacros.statusBarHeight + 1);
}

#pragma mark - setupData

- (void)setupData
{
    self.navigationItem.title = @"投屏帮助";
}


@end
