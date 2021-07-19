//
//  PandaMovieSendingViewController.m
//  PandaMovie
//
//  Created by zjlk03 on 2021/5/31.
//

#import "PandaMovieSendingViewController.h"
#import "SDVideoController.h"
#import "SDVideoAlbumViewController.h"
#import "GNHNavigationController.h"
#import "UITextField+AddPlaceholder.h"
@interface PandaMovieSendingViewController ()
@property(nonatomic,strong) UITextField * TitleTextField;
@property(nonatomic,strong) UIImageView * VieoThubImgView;
@property(nonatomic,strong)UIImageView *mainVideoView;

@property(nonatomic,strong)AVPlayerLayer *videoLayer;
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playItem;
@property(nonatomic,strong)AVAssetImageGenerator *imageGenerator;
@property(nonatomic,assign) BOOL isLoad;
@end

@implementation PandaMovieSendingViewController
- (AVPlayerLayer *)videoLayer {
    
    if (_videoLayer == nil) {
        _videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _videoLayer.frame = _mainVideoView.bounds;
    }
    return _videoLayer;
}

- (AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}
- (UIImageView *)mainVideoView {
    
    if (_mainVideoView == nil) {
        _mainVideoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, RealWidth(200), GK_SCREEN_WIDTH, RealWidth(400))];
        _mainVideoView.userInteractionEnabled = YES;
        [_mainVideoView.layer addSublayer:self.videoLayer];
    }
    return _mainVideoView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLoad = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发布视频";
    self.view.backgroundColor = [UIColor whiteColor];

    UIView * titleInputView = [[UIView alloc]initWithFrame:CGRectMake(RealWidth(10), RealWidth(15), GK_SCREEN_WIDTH-RealWidth(20), RealWidth(40))];
    titleInputView.backgroundColor = LGDLightGaryColor;
    titleInputView.layer.cornerRadius = RealWidth(5);
    titleInputView.layer.masksToBounds = YES;
    [self.view addSubview:titleInputView];
    
    UITextField * titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(RealWidth(10), 0, CGRectGetWidth(titleInputView.frame)-RealWidth(20), CGRectGetHeight(titleInputView.frame))];
    titleTextField.textColor = [UIColor blackColor];
    titleTextField.font = zy_mediumSystemFont12;
    titleTextField.clearButtonMode =  UITextFieldViewModeAlways;
    [titleTextField addPlaceholders:zy_mediumSystemFont12 holderStr:@"给你的视频取个标题吧～" holderColor:LGDGaryColor];
    [titleInputView addSubview:titleTextField];
    _TitleTextField =  titleTextField;
    
    UIButton * addVideobtn = [[UIButton alloc]initWithFrame:CGRectMake(RealWidth(10), CGRectGetMaxY(titleInputView.frame)+RealWidth(15), GK_SCREEN_WIDTH-RealWidth(20), RealWidth(40))];
    [addVideobtn setBackgroundColor:LGDMianColor];
    [addVideobtn setTitle:@"添加视频" forState:UIControlStateNormal];
    addVideobtn.titleLabel.font = zy_mediumSystemFont12;
    addVideobtn.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [addVideobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addVideobtn.layer.cornerRadius = RealWidth(4);
    addVideobtn.layer.masksToBounds = YES;
    [addVideobtn addTarget:self action:@selector(VideoThubImgViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addVideobtn];

    [self.view addSubview:self.mainVideoView];
    
    self.gk_navItemRightSpace = RealWidth(20);
    UIButton * PandaSednBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PandaSednBtn setImage:[UIImage imageNamed:@"send_icon"] forState:UIControlStateNormal];
    [PandaSednBtn addTarget:self action:@selector(PandaSednBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PandaSednBtn];
    
    BOOL xieyi = [[NSUserDefaults standardUserDefaults] boolForKey:@"xieyiyuedu"];
    if (xieyi == NO) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您在使用<企鹅追剧>时，在您发布视频的时候必须遵守法律法规,在以下几条必须遵守\n1、禁止发布传送传播破坏社会的违法内容。\n2、不得侵犯他人隐私权。\n3、不得发布恶意虚构事实欺骗他人。\n4、不得涉及黄赌毒。\n5、不得发布政治敏感内容。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action  =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction * action1  =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"xieyiyuedu"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        [alter addAction:action];
        [alter addAction:action1];
        [self presentViewController:alter animated:YES completion:nil];
    }


}
 
-(void)PandaSednBtnClick{
    if (_TitleTextField.text.length == 0) {
        [LCProgressHUD showInfoMsg:@"给你的视频取个标题吧~"];
        return;
    }
    if (self.isLoad == NO) {
        [LCProgressHUD showInfoMsg:@"请上传视频"];
        return;
    }
    
    
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
        [LCProgressHUD showLoading:@"上传中...."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD showSuccess:@"上传成功，等待平台审核!"];
            [self.navigationController popViewControllerAnimated:YES];
        });
    
    }
    
}
-(void)VideoThubImgViewClick{
    SDVideoConfig *config = [[SDVideoConfig alloc] init];
    config.returnViewController = self;
    NSMutableArray * tempArr = [NSMutableArray array];
    MJWeakSelf;
    config.returnBlock = ^(NSString *mergeVideoPathString, NSArray *videoAssetarr) {
        weakSelf.isLoad = YES;
        NSURL * url = [NSURL  fileURLWithPath:mergeVideoPathString];;
        AVPlayerItem * itme = [[AVPlayerItem alloc]initWithURL:url];
        [weakSelf.player replaceCurrentItemWithPlayerItem:itme];
        [weakSelf.player play];
   
    };
    SDVideoAlbumViewController *albumViewController = [[SDVideoAlbumViewController alloc] initWithCameraConfig:config];
    UINavigationController *albumNavigationController = [[GNHNavigationController alloc] initWithRootViewController:albumViewController];
    albumNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:albumNavigationController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
