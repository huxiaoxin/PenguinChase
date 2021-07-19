

#import "PandaMovieLoginViewController.h"
#import "GNHBaseTextField.h"
#import "UICountingLabel.h"
#import "PandaMovieH5ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "SSKeychain.h"
#import "SvUDIDTools.h"
#import <UMPush/UMessage.h>
#import "FilmFacotryLoginSMSCodeDataModel.h"
#import "PandaMovieLoginDataModel.h"
#import "UIView+EnlargeTouchArea.h"
#import "FilmFactoryUserInformManager.h"

@interface PandaMovieLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UILabel *PandMovietitleLabel;  // 标题
@property (nonatomic, strong) GNHBaseTextField *PandaMoviephoneTextField;

@property (nonatomic, strong) GNHBaseTextField *PandaMoviecodeTextField;

@property (nonatomic, strong) UICountingLabel *PandaMoviecodeCountingLb;

@property (nonatomic, strong) UIButton *PandaMoviesubmitBtn;
@property (nonatomic, strong) UILabel *PandaMovietipsLabel;

@property (nonatomic, strong) MDFButton *PandaMoviexieYiBtn;
@property (nonatomic, strong) UIButton *PandaMoviexieYi1Btn;
@property (nonatomic, strong) UIButton *PandaMoviexieYi2Btn;

@property (nonatomic, strong) FilmFacotryLoginSMSCodeDataModel *PandaMovieloginSMSModel;
@property (nonatomic, strong) PandaMovieLoginDataModel *loginDataModel;

@end

@implementation PandaMovieLoginViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    pandaback1
//    self.view.backgroundColor = [UIColor whiteColor]
    UIImageView * PandabackImgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    PandabackImgView.image = [UIImage imageNamed:@"backimg"];
    PandabackImgView.userInteractionEnabled = YES;
    [self.view addSubview:PandabackImgView];
    [self setupUI];
    
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 竖屏，防止横屏播放或者横屏直播过程中，token失效自动切换登录
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIDeviceOrientationendFullScreen" object:nil];
    
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - setupUI

- (void)setupUI
{
    UIButton *backButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_leff_white_arrow" selecteImageName:nil target:self selector:@selector(leftButtonAction:)];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ORKitMacros.statusBarHeight + 20.0f - 8.5f);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(41.0f, 41.0f));
    }];
        
    UIScrollView *bgScorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgScorllView.showsVerticalScrollIndicator = NO;
    bgScorllView.showsHorizontalScrollIndicator = NO;
    bgScorllView.automaticallyAdjustsScrollIndicatorInsets = NO;
    if (@available(iOS 11.0, *)) {
        bgScorllView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:bgScorllView];
    self.scrollview = bgScorllView;
    self.scrollview.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 1);
        
    UILabel *PandMovietitleLabel = [UILabel ly_LabelWithTitle:@"手机号快捷登录" font:zy_blodFontSize24 titleColor:[UIColor whiteColor]];
    [bgScorllView addSubview:PandMovietitleLabel];
    [PandMovietitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgScorllView).offset(ORKitMacros.statusBarHeight + 92);
        make.left.equalTo(bgScorllView).offset(40.5f);
        make.height.mas_equalTo(23.0f);
    }];
    self.PandMovietitleLabel = PandMovietitleLabel;
    
    UIView *lineV1 = [UIView ly_ViewWithColor:gnh_color_line];
    [bgScorllView addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PandMovietitleLabel.mas_bottom).offset(82.5f);
        make.left.equalTo(PandMovietitleLabel);
        make.right.mas_equalTo(self.view.mas_right).offset(-36.5);
        make.height.mas_offset(0.5f);
    }];
    
    GNHBaseTextField *PandaMoviephoneTextField = [GNHBaseTextField ly_TextFieldWithPlaceholder:@"" font:zy_mediumSystemFont16];
    PandaMoviephoneTextField.textColor = [UIColor whiteColor];
    PandaMoviephoneTextField.delegate = self;
    PandaMoviephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    PandaMoviephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName:zy_mediumSystemFont16, NSForegroundColorAttributeName:RGBA_HexCOLOR(0xC4C6CD, 1.0)}];
    [PandaMoviephoneTextField setAttributedPlaceholder:attr];
    [PandaMoviephoneTextField addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [bgScorllView addSubview:PandaMoviephoneTextField];
    [PandaMoviephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineV1);
        make.bottom.mas_equalTo(lineV1.mas_bottom);
        make.height.mas_offset(52);
    }];
    self.PandaMoviephoneTextField = PandaMoviephoneTextField;
    self.PandaMoviephoneTextField.text = ORShareAccountComponent.accountNum;
    
    UIView *lineV2 = [UIView ly_ViewWithColor:gnh_color_line];
    [bgScorllView addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineV1.mas_bottom).offset(63.5f);
        make.left.right.height.equalTo(lineV1);
    }];

    GNHBaseTextField *PandaMoviecodeTextField = [GNHBaseTextField ly_TextFieldWithPlaceholder:@"" font:zy_fontSize13];
    PandaMoviecodeTextField.textColor = [UIColor whiteColor];
    PandaMoviecodeTextField.delegate = self;
    PandaMoviecodeTextField.font = zy_fontSize15;
    PandaMoviecodeTextField.keyboardType = UIKeyboardTypeDefault;
    NSAttributedString *attrCode = [[NSAttributedString alloc]initWithString:@"请输入短信验证码" attributes:@{NSFontAttributeName:zy_mediumSystemFont16,NSForegroundColorAttributeName:RGBA_HexCOLOR(0xC4C6CD, 1.0)}];
    [PandaMoviecodeTextField setAttributedPlaceholder:attrCode];
    [PandaMoviecodeTextField addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [bgScorllView addSubview:PandaMoviecodeTextField];
    [PandaMoviecodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineV2);
        make.bottom.mas_equalTo(lineV2.mas_bottom);
        make.height.mas_offset(52);
    }];
    self.PandaMoviecodeTextField = PandaMoviecodeTextField;
        
    UICountingLabel *PandaMoviecodeCountingLb = [[UICountingLabel alloc] init];
    PandaMoviecodeCountingLb.method = UILabelCountingMethodLinear;
    PandaMoviecodeCountingLb.text = @"获取验证码";
    GNHWeakObj(PandaMoviecodeCountingLb);
    PandaMoviecodeCountingLb.formatBlock = ^NSString *(CGFloat value) {
        if (value == 1) {
            weakPandaMoviecodeCountingLb.textColor = LGDMianColor;
            return @"重新获取";
        } else {
            weakPandaMoviecodeCountingLb.textColor = RGBA_HexCOLOR(0xC4C6CD, 1.0);
            return [NSString stringWithFormat:@"%d秒后重发", (int)value];
        }
    };
    PandaMoviecodeCountingLb.textColor = LGDMianColor;
    PandaMoviecodeCountingLb.font = zy_mediumSystemFont16;
    PandaMoviecodeCountingLb.textAlignment = NSTextAlignmentCenter;
    
    GNHWeakSelf;
    [PandaMoviecodeCountingLb mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
        [weakSelf.view endEditing:YES];
        NSString *code = weakSelf.PandaMoviecodeCountingLb.text;
        if ([code isEqualToString:@"获取验证码"] || [code isEqualToString:@"重新获取"]) {
            if ([weakSelf checkPhoneState]) {
                [weakSelf.PandaMovieloginSMSModel FilmFacotrysendSMS:weakSelf.PandaMoviephoneTextField.text];
            } else {
                [SVProgressHUD showInfoWithStatus:@"请输入合法的手机号"];
            }
        }
    }];
    [bgScorllView addSubview:PandaMoviecodeCountingLb];
    [PandaMoviecodeCountingLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-35.5f);
        make.centerY.equalTo(PandaMoviecodeTextField);
        make.size.mas_offset(CGSizeMake(90, 27));
    }];
    self.PandaMoviecodeCountingLb = PandaMoviecodeCountingLb;

    self.PandaMoviesubmitBtn = [UIButton ly_ButtonWithTitle:@"登录" titleColor:gnh_color_b font:zy_blodFontSize17 target:self selector:@selector(submitAction)];
    self.PandaMoviesubmitBtn.backgroundColor = LGDMianColor;
    self.PandaMoviesubmitBtn.layer.cornerRadius = 22.0f;
    self.PandaMoviesubmitBtn.layer.masksToBounds = YES;
    self.PandaMoviesubmitBtn.enabled = NO;
    [bgScorllView addSubview:self.PandaMoviesubmitBtn];
    [self.PandaMoviesubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV2.mas_bottom).offset(41);
        make.left.right.equalTo(self.view).inset(35.5f);
        make.height.mas_offset(44);
    }];
        
    UIView *xieYiView = [UIView ly_ViewWithColor:UIColor.clearColor];
    [bgScorllView addSubview:xieYiView];
    [xieYiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgScorllView).offset(self.view.height - (50 + 21.5 + ORKitMacros.iphoneXSafeHeight));
        make.centerX.equalTo(bgScorllView);
        make.height.mas_equalTo(50.0f);
    }];
    
    self.PandaMoviexieYiBtn = [MDFButton ly_ButtonWithNormalImageName:@"pandMoview_check_seachI_icon" selecteImageName:@"pandanMoview_seltee_icon" target:self selector:@selector(xieYiAction:)];
    self.PandaMoviexieYiBtn.touchEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
    [xieYiView addSubview:self.PandaMoviexieYiBtn];
    [self.PandaMoviexieYiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xieYiView);
        make.size.mas_offset(CGSizeMake(24, 24));
        make.centerY.equalTo(xieYiView);
    }];

    UILabel *xieYiLb = [UILabel ly_LabelWithTitle:@"登录即表示您已同意" font:[UIFont systemFontOfSize:12] titleColor:gnh_color_e];
    [xieYiView addSubview:xieYiLb];
    [xieYiLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PandaMoviexieYiBtn.mas_right).offset(5);
        make.centerY.equalTo(xieYiView);
    }];

    self.PandaMoviexieYi1Btn = [UIButton ly_ButtonWithTitle:@"《用户协议》" titleColor:LGDMianColor font:zy_mediumSystemFont12 target:self selector:@selector(xieYiAction:)];
    [xieYiView addSubview:self.PandaMoviexieYi1Btn];
    [self.PandaMoviexieYi1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xieYiLb.mas_right);
        make.centerY.equalTo(xieYiLb);
    }];

    UILabel *addLb = [UILabel ly_LabelWithTitle:@"和" font:zy_mediumSystemFont12 titleColor:gnh_color_e];
    [xieYiView addSubview:addLb];
    [addLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PandaMoviexieYi1Btn.mas_right);
        make.centerY.equalTo(xieYiLb);
    }];

    self.PandaMoviexieYi2Btn = [UIButton ly_ButtonWithTitle:@"《隐私政策》"  titleColor:LGDMianColor font:zy_mediumSystemFont12 target:self selector:@selector(xieYiAction:)];
    [xieYiView addSubview:self.PandaMoviexieYi2Btn];
    [self.PandaMoviexieYi2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addLb.mas_right);
        make.right.lessThanOrEqualTo(xieYiView).offset(-10);
        make.centerY.equalTo(xieYiLb);
    }];
    
    [self.view bringSubviewToFront:backButton];
}

#pragma mark - setupData

- (void)setupData
{
    [self PandaMoviesubmitBtnStatus];
}

- (void)configUI
{
    NSString *smsCodePlaceHolder = @"";
    
    self.PandaMoviecodeCountingLb.hidden = NO;
    self.PandMovietitleLabel.text = @"手机号登录";
    
    smsCodePlaceHolder = @"请输入验证码";
    
    self.PandaMoviephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.PandaMoviecodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.PandaMoviecodeTextField.secureTextEntry = NO;
    
    NSAttributedString *attrCode = [[NSAttributedString alloc]initWithString:smsCodePlaceHolder attributes:@{NSFontAttributeName:zy_fontSize15,NSForegroundColorAttributeName:RGBA_HexCOLOR(0xA0A0A0, 1.0)}];
    [self.PandaMoviecodeTextField setAttributedPlaceholder:attrCode];
    
    self.PandaMoviephoneTextField.text = @"";
    self.PandaMoviecodeTextField.text = @"";
    [self.PandaMoviephoneTextField resignFirstResponder];
    [self.PandaMoviecodeTextField resignFirstResponder];
    
    self.PandaMoviephoneTextField.text = ORShareAccountComponent.accountNum;
}

#pragma mark - buttonAction

- (void)leftButtonAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitAction
{
    [self.view endEditing:YES];
    
    if (![self checkPhoneState]) {
        [SVProgressHUD showInfoWithStatus:@"请输入合法的手机号"];
        return;
    }
    
    
    if (![self checkSMSCodeState]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的验证码"];
        return;
    }
    
    if (![self checkXieYiState]) {
        [SVProgressHUD showInfoWithStatus:@"请同意协议"];
        return;
    }
    
    BOOL isLoad = [self.loginDataModel loginAccount:self.PandaMoviephoneTextField.text code:self.PandaMoviecodeTextField.text];
    if (isLoad) {
        [SVProgressHUD showWithStatus:self.loginDataModel.loadTips];
    } else {
        [SVProgressHUD dismiss];
    }
}

- (void)xieYiAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (self.PandaMoviexieYi1Btn == btn) {
        //用户协议1
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:orangeUserProtocol.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (self.PandaMoviexieYi2Btn == btn) {
        //用户协议2 隐私协议
        UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:orangePrivacyProtocol.urlWithString];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        self.PandaMoviexieYiBtn.selected = !self.PandaMoviexieYiBtn.selected;
        self.PandaMoviesubmitBtn.enabled = self.PandaMoviexieYiBtn.selected;
    }
}

- (BOOL)checkPhoneState
{
    return [self.PandaMoviephoneTextField.text mdf_isValidatedMobile];
}

- (BOOL)checkSMSCodeState
{
    return [self.PandaMoviecodeTextField.text mdf_isPureInt];
}

- (BOOL)checkXieYiState
{
    return self.PandaMoviexieYiBtn.selected;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.PandaMoviecodeTextField == textField) {
        self.PandaMoviecodeTextField.text = nil;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.PandaMoviephoneTextField) {
        NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

        return [toBeString isEqualToString:@""] || [self isNumberWithText:toBeString];
    }else{
        return YES;
    }

}

- (BOOL)isNumberWithText:(NSString *)text
{
    NSString *regex = @"[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

- (void)textFieldChangeAction:(UITextField *)textField
{
    [self PandaMoviesubmitBtnStatus];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self PandaMoviesubmitBtnStatus];
}

- (void)PandaMoviesubmitBtnStatus
{
    if (self.PandaMoviephoneTextField.text.length > 1 && self.PandaMoviecodeTextField.text.length > 1) {
        self.PandaMoviesubmitBtn.enabled = YES;
        self.PandaMoviesubmitBtn.backgroundColor = LGDMianColor;
    } else {
        self.PandaMoviesubmitBtn.enabled = NO;
        self.PandaMoviesubmitBtn.backgroundColor = gnh_color_ee;
    }
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isKindOfClass:[FilmFacotryLoginSMSCodeDataModel class]]) {
        [self.PandaMoviecodeCountingLb countFrom:60 to:1 withDuration:60];
    } else if ([gnhModel isKindOfClass:[PandaMovieLoginDataModel class]]) {
        [SVProgressHUD dismiss];
        
        // 更新用户信息
        [[FilmFactoryUserInformManager sharedInstance] updateUserInfo:nil];
        
        // 存储账号
        [ORShareAccountComponent storeLastLoginAccount:self.PandaMoviephoneTextField.text];
        
        // 存储token
        [ORShareAccountComponent storeAccessToken:self.loginDataModel.loginItem.token];
        
        [ORMainAPI leaveCurrentPage:self animated:YES completion:^{
            // 登录成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:ORAccountLoginSuccessNotification object:nil userInfo:nil];
        }];
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

- (void)restoreUserInfo:(NSString *)token uid:(NSString *)uid uname:(NSString *)uname avatarUrl:(NSString *)avatarUrl
{

}

#pragma mark - Properties

- (FilmFacotryLoginSMSCodeDataModel *)PandaMovieloginSMSModel
{
    if (!_PandaMovieloginSMSModel) {
        _PandaMovieloginSMSModel = [self produceModel:[FilmFacotryLoginSMSCodeDataModel class]];
    }
    return _PandaMovieloginSMSModel;
}

- (PandaMovieLoginDataModel *)loginDataModel
{
    if (!_loginDataModel) {
        _loginDataModel = [self produceModel:[PandaMovieLoginDataModel class]];
    }
    return _loginDataModel;
}

@end
