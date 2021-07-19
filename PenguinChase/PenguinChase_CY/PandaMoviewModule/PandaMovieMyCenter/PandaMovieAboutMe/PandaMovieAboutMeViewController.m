

#import "PandaMovieAboutMeViewController.h"
#import "PandaMovieH5ViewController.h"

@interface PandaMovieAboutMeViewController ()

@end

@implementation PandaMovieAboutMeViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDatas];
    
    [self setupUI];
}

#pragma mark - setupDatas

- (void)setupDatas
{
}

#pragma mark - setupUIs

- (void)setupUI
{
    self.title = @"关于我们";
    
    self.view.backgroundColor = gnh_color_d;
    self.tableView.backgroundColor = gnh_color_d;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImageView = [UIImageView ly_ImageViewWithImageName:@"homelogo"];
    [self.tableView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_top).offset(100);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(81.5f, 81.5f));
    }];
    
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
//    UILabel *appNameLabel = [[UILabel alloc] init];
//    appNameLabel.text = dict[@"CFBundleName"];
//    appNameLabel.textColor = gnh_color_bb;
//    appNameLabel.font = zy_fontSize13;
//    appNameLabel.textAlignment = NSTextAlignmentCenter;
//    [self.tableView addSubview:appNameLabel];
//    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(iconImageView.mas_bottom).offset(6.5f);
//        make.centerX.mas_equalTo(self.tableView.mas_centerX);
//        make.height.mas_equalTo(18.5f);
//    }];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.text = dict[@"CFBundleShortVersionString"];
    versionLabel.textColor = gnh_color_bb;
    versionLabel.font = zy_fontSize13;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(2.0f);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
        make.height.mas_equalTo(18.5f);
    }];
    
    UIView *backView = [UIView ly_ViewWithColor:UIColor.whiteColor];
    [self.tableView addSubview:backView];
    backView.layer.cornerRadius = 10.f;
    backView.layer.masksToBounds = YES;
    backView.clipsToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(77.f);
        make.left.right.equalTo(self.view).inset(15.0f);
        make.height.mas_equalTo(165.0f);
    }];
    
    UIView *lineV1 = [UIView ly_ViewWithColor:gnh_color_line];
    [backView addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(53.0f);
        make.left.right.equalTo(backView).inset(15.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *lineV2 = [UIView ly_ViewWithColor:gnh_color_line];
    [backView addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(108.0f);
        make.left.right.equalTo(backView).inset(15.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    GNHWeakSelf;
    UILabel *protocol1 = [UILabel ly_LabelWithTitle:@"用户服务协议" font:zy_fontSize15 titleColor:gnh_color_a];
    [backView addSubview:protocol1];
    protocol1.textAlignment = NSTextAlignmentLeft;
    [protocol1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView);
        make.left.equalTo(backView).offset(15.0f);
        make.right.equalTo(backView).offset(-25.0f);
        make.height.mas_equalTo(53.f);
    }];
    [protocol1 mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:orangeUserProtocol.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    UIImageView *arrowImageView1 = [UIImageView ly_ImageViewWithImageName:@"padanMoview_right_arrow"];
    [backView addSubview:arrowImageView1];
    [arrowImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-15.f);
        make.centerY.equalTo(protocol1);
    }];
    
    UILabel *protocol2 = [UILabel ly_LabelWithTitle:@"用户隐私协议" font:zy_fontSize15 titleColor:gnh_color_a];
    [backView addSubview:protocol2];
    protocol2.textAlignment = NSTextAlignmentLeft;
    [protocol2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(53);
        make.left.equalTo(backView).offset(15.0f);
        make.right.equalTo(backView).offset(-25.0f);
        make.height.mas_equalTo(53.f);
    }];
    [protocol2 mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:orangePrivacyProtocol.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    UIImageView *arrowImageView2 = [UIImageView ly_ImageViewWithImageName:@"padanMoview_right_arrow"];
    [backView addSubview:arrowImageView2];
    [arrowImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-15.f);
        make.centerY.equalTo(protocol2);
    }];
    
    // 免责声明
    UILabel *protocol3 = [UILabel ly_LabelWithTitle:@"免责声明" font:zy_fontSize15 titleColor:gnh_color_a];
    [backView addSubview:protocol3];
    protocol3.textAlignment = NSTextAlignmentLeft;
    [protocol3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV2.mas_bottom);
        make.left.equalTo(backView).offset(15.0f);
        make.right.equalTo(backView).offset(-25.0f);
        make.height.mas_equalTo(53.f);
    }];
    [protocol3 mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:orangeDisclaimerProtocol.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    UIImageView *arrowImageView3 = [UIImageView ly_ImageViewWithImageName:@"padanMoview_right_arrow"];
    [backView addSubview:arrowImageView3];
    [arrowImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-15.f);
        make.centerY.equalTo(protocol3);
    }];
    
    UILabel *websiteTipsLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize15 titleColor:gnh_color_a];
    websiteTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:websiteTipsLabel];
    [websiteTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.tableView.mas_top).offset(self.tableView.height - 50.0f - ORKitMacros.iphoneXSafeHeight);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
        make.height.mas_equalTo(18.5f);
    }];
}

#pragma mark - Notification

- (void)setupNotifications
{
    [super setupNotifications];
}


@end
