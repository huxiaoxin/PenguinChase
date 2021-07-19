

#import "PandaMovieThrowScreenViewController.h"
#import "PandaMovieThrowScreenHelpViewController.h"
#import <NetworkExtension/NetworkExtension.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "PandaMovieWaterVaveView.h"
#import "FilmFacotryManager.h"


@interface PandaMovieThrowScreenViewCell : UITableViewCell

@property (nonatomic, strong) UILabel     *PandaMoviecopcontentLabel;
@property (nonatomic, strong) UIImageView *PandaMoviecopchooseImageview;
@property (nonatomic, strong) UILabel     *PandaMoviecoprecommendLabel;

- (void)refreshData:(BOOL)isSelected;
@end

@implementation PandaMovieThrowScreenViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        
        self.selectedBackgroundView = [UIView new];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *PandaMoviecopchooseImageview = [UIImageView ly_ImageViewWithImageName:@"pandaMoview_Chose_iocn"];
    [self.contentView addSubview:PandaMoviecopchooseImageview];
    [PandaMoviecopchooseImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    self.PandaMoviecopchooseImageview = PandaMoviecopchooseImageview;
    self.PandaMoviecopchooseImageview.hidden = YES;
    
    UILabel *PandaMoviecopcontentLabel = [[UILabel alloc] init];
    PandaMoviecopcontentLabel.textColor = RGBA_HexCOLOR(0x2B2D3C, 1.0);
    PandaMoviecopcontentLabel.font = zy_blodFontSize16;
    [self.contentView addSubview:PandaMoviecopcontentLabel];
    [PandaMoviecopcontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PandaMoviecopchooseImageview.mas_right).offset(2.0f);
        make.centerY.equalTo(self.contentView);
    }];
    self.PandaMoviecopcontentLabel = PandaMoviecopcontentLabel;
    
    UILabel *PandaMoviecoprecommendLabel = [UILabel ly_LabelWithTitle:@"推荐" font:zy_blodFontSize10 titleColor:gnh_color_theme];
    PandaMoviecoprecommendLabel.layer.cornerRadius = 2.5f;
    PandaMoviecoprecommendLabel.layer.borderColor = gnh_color_theme.CGColor;
    PandaMoviecoprecommendLabel.layer.borderWidth = 0.5f;
    PandaMoviecoprecommendLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:PandaMoviecoprecommendLabel];
    [PandaMoviecoprecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PandaMoviecopcontentLabel.mas_right).offset(5.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(27.0f, 15.0f));
    }];
    self.PandaMoviecoprecommendLabel = PandaMoviecoprecommendLabel;
    self.PandaMoviecoprecommendLabel.hidden = YES;
}

- (void)refreshData:(BOOL)isSelected
{
    self.PandaMoviecopchooseImageview.hidden = !isSelected;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *backgroundColor = self.PandaMoviecopcontentLabel.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.PandaMoviecopcontentLabel.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *backgroundColor = self.PandaMoviecopcontentLabel.backgroundColor;
    [super setSelected:selected animated:animated];
    self.PandaMoviecopcontentLabel.backgroundColor = backgroundColor;
}

@end

@interface PandaMovieThrowScreenViewController () <DLNADelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *searchDeviceView; // 搜索设备view
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) NSTimer     *timer;

@property (nonatomic, strong) UIView *deviceView; // 设备view
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *devices;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation PandaMovieThrowScreenViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupData];
}

- (void)viewControllerDidDisappear
{
    // 断开设备
    [[FilmFacotryManager sharedDLNAManager] endConnect];
    
    // 停止搜索
    [[FilmFacotryManager sharedDLNAManager] endService];
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - setupUI

- (void)setupUI
{
    UIButton *helpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 30)];
    [helpButton setTitle:@"投屏帮助" forState:UIControlStateNormal];
    [helpButton setTitleColor:gnh_color_p forState:UIControlStateNormal];
    helpButton.titleLabel.font = zy_mediumSystemFont15;
    [helpButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:helpButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *refreshButton = [UIButton ly_ButtonWithNormalImageName:@"panmdaMoview_refresh_icon" selecteImageName:@"panmdaMoview_refresh_icon" target:self selector:@selector(refreshAction:)];
    [self.view addSubview:refreshButton];
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(22.0f);
        make.right.equalTo(self.view).offset(-16.0f);
        make.size.mas_equalTo(CGSizeMake(22.0f, 22.0f));
    }];
    
    UIView *searchDeviceView = [UIView ly_ViewWithColor:UIColor.whiteColor];
    [self.view addSubview:searchDeviceView];
    [searchDeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20.0f);
        make.left.equalTo(self.view).offset(22.0f);
    }];
    self.searchDeviceView = searchDeviceView;
    
    UILabel *searchTitleLabel = [UILabel ly_LabelWithTitle:@"正在搜索投屏设备" font:zy_blodFontSize15 titleColor:RGBA_HexCOLOR(0x2B2D3C, 1.0)];
    [searchDeviceView addSubview:searchTitleLabel];
    [searchTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(searchDeviceView);
        make.height.mas_equalTo(14.5f);
    }];
    
    UILabel *wifiLabel = [UILabel ly_LabelWithTitle:@"当前WiFi：" font:zy_blodFontSize12 titleColor:RGBA_HexCOLOR(0xADAEB6, 1.0)];
    [searchDeviceView addSubview:wifiLabel];
    [wifiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchTitleLabel.mas_bottom).offset(6.0);
        make.left.equalTo(searchTitleLabel);
        make.height.mas_equalTo(12.f);
        make.bottom.equalTo(searchDeviceView);
    }];
    
    UIView *contentView = [UIView ly_ViewWithColor:UIColor.whiteColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(kScreenHeight/3.0);
    }];
    self.contentView = contentView;
    
    // 设备列表
    UIView *deviceView = [UIView ly_ViewWithColor:UIColor.whiteColor];
    [self.view addSubview:deviceView];
    [deviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset(18.0f);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2.0, 328));
    }];
    self.deviceView = deviceView;
    self.deviceView.hidden = YES;
    
    UILabel *tipsLabel = [UILabel ly_LabelWithTitle:@"选择要投射的电视" font:zy_mediumSystemFont14 titleColor:RGBA_HexCOLOR(0xABAAB8, 1.0)];
    [deviceView addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deviceView).offset(20.0);
        make.left.equalTo(deviceView).offset(2.0f);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 48.0f, kScreenWidth/2.0, 280)];
    [deviceView addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - setupData

- (void)setupData
{
    self.navigationItem.title = @"投屏";
        
    [self wiFiName];
    
    // 搜索设备
    [[FilmFacotryManager sharedDLNAManager] searchService];
    [FilmFacotryManager sharedDLNAManager].delegate = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(searchDevice) userInfo:nil repeats:YES];
    
    self.devices = [NSMutableArray array];
    [self.tableView reloadData];
}

- (NSString *)wiFiName {
    NSArray *wiFiName = CFBridgingRelease(CNCopySupportedInterfaces());
    id info1 = nil;
    for (NSString *wfName in wiFiName) {
        info1 = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) wfName);
        if (info1 && [info1 count]) {
            break;
        }
    }

    NSDictionary *dic = (NSDictionary *)info1;
    NSString*ssidName=[[dic objectForKey:@"SSID"]lowercaseString];

    return ssidName;
}

- (void)searchDevice
{
    __block PandaMovieWaterVaveView *waterView = [[PandaMovieWaterVaveView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    waterView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/3.0);
    [self.contentView addSubview:waterView];
    
    [UIView animateWithDuration:3.5 animations:^{
        waterView.transform = CGAffineTransformScale(waterView.transform, 3, 3);
        waterView.alpha = 0;
    } completion:^(BOOL finished) {
        [waterView removeFromSuperview];
    }];
}

#pragma mark - buttonAction

- (void)rightButtonAction:(UIButton *)btn
{
    PandaMovieThrowScreenHelpViewController *helpViewController = [[PandaMovieThrowScreenHelpViewController alloc] init];
    [self.navigationController pushViewController:helpViewController animated:YES];
}

- (void)refreshAction:(UIButton *)btn
{
    self.contentView.hidden = NO;
    
    // 搜索设备
    [[FilmFacotryManager sharedDLNAManager] searchService];
}

#pragma mark - DLNADelegate

- (void)searchDLNAResult:(NSArray *)devicesArray
{
    self.contentView.hidden = YES;
    self.searchDeviceView.hidden = YES;
    self.deviceView.hidden = NO;
    
    self.devices = [devicesArray mutableCopy];
    [self.tableView reloadData];
}

- (void)searchDLNAError:(NSError *)error
{
    self.contentView.hidden = YES;
    self.searchDeviceView.hidden = NO;
}

/**
 投屏成功开始播放
 */
- (void)dlnaStartPlay
{
    // 赋值连接
    NSString *deviceName = [self.devices mdf_safeObjectAtIndex:self.selectIndexPath.row];
    
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"连接 %@成功",deviceName]];
    [[FilmFacotryManager sharedDLNAManager] setLBLelinkPlayerItemPlayUrl:self.videoUrl];
}

/**
 退出投屏成功
 */
- (void)dlnaEndPlay
{
    
}

/**
 投屏失败
 */
- (void)dlnaErrorPlay
{
    [SVProgressHUD showInfoWithStatus:@"投屏失败，请检查设备连接方式"];
    self.deviceView.hidden = YES;
    self.contentView.hidden = NO;
    self.searchDeviceView.hidden = NO;
}

#pragma mark - UITableview delegate & dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    PandaMovieThrowScreenViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[PandaMovieThrowScreenViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    NSString *deviceName = [self.devices mdf_safeObjectAtIndex:indexPath.row];
    cell.PandaMoviecopcontentLabel.text = deviceName;
    if (indexPath.row == 0) {
        cell.PandaMoviecoprecommendLabel.hidden = NO;
    } else {
        cell.PandaMoviecoprecommendLabel.hidden = YES;
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PandaMovieThrowScreenViewCell *preSelectCell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
    preSelectCell.PandaMoviecopchooseImageview.hidden = YES;

    self.selectIndexPath = indexPath;
    
    PandaMovieThrowScreenViewCell *cell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
    cell.PandaMoviecopchooseImageview.hidden = NO;

    // 建立新连接
    [[FilmFacotryManager sharedDLNAManager] endConnect];
    [[FilmFacotryManager sharedDLNAManager] startLBLelinkConnection:self.selectIndexPath.row];

    [SVProgressHUD showWithStatus:@"开始投屏"];
}


@end
