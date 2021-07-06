

    #import "PenguinChaseLoginViewController.h"
    #import "PenguinaboutUsViewController.h"
    #import "UITextField+AddPlaceholder.h"
    @interface PenguinChaseLoginViewController ()
    {
        NSTimer *    _PenguinChaseTimers;
        NSInteger _PenguinChaseNums;
        
    }
    @property(nonatomic,strong) UITextField * CarpguinChasePhoneTextField;
    @property(nonatomic,strong) UITextField * CarpguinChasePasswordTextField;
    @property(nonatomic,strong) UIButton * CarpguinChaseCodeBtn;
    @end

    @implementation PenguinChaseLoginViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        _PenguinChaseNums = 60;
        self.view.backgroundColor = [UIColor whiteColor];
        self.gk_navBarAlpha = 0;
        UIButton *  PenguinChaseClearBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [PenguinChaseClearBtn setTitle:@"跳过" forState:UIControlStateNormal];
        PenguinChaseClearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [PenguinChaseClearBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
        [PenguinChaseClearBtn addTarget:self action:@selector(PenguinChaseClearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.gk_navItemRightSpace = RealWidth(20);
        self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinChaseClearBtn];
        
        UIImageView * LogoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(RealWidth(20), NaviH+RealWidth(30), RealWidth(36), RealWidth(36))];
        LogoImgView.layer.cornerRadius = RealWidth(18);
        LogoImgView.layer.masksToBounds = YES;
        LogoImgView.image = [UIImage imageNamed:@"whitelogo"];
        [self.view addSubview:LogoImgView];
        
        UILabel * penguinNamelb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LogoImgView.frame)+RealWidth(5), CGRectGetMidY(LogoImgView.frame)-RealWidth(7.5), RealWidth(100), RealWidth(20))];
        penguinNamelb.textColor = [UIColor blackColor];
        penguinNamelb.font = [UIFont boldSystemFontOfSize:20];
        penguinNamelb.text = @"企鹅追剧";
        [self.view addSubview:penguinNamelb];
        
        UILabel * tipslb = [[UILabel alloc]initWithFrame:CGRectMake(RealWidth(20), CGRectGetMaxY(LogoImgView.frame)+RealWidth(20), RealWidth(250), RealWidth(20))];
        tipslb.textColor = LGDMianColor;
        tipslb.font = [UIFont boldSystemFontOfSize:20];
        tipslb.text = @"欢迎使用";
        [self.view addSubview:tipslb];
        
        UILabel * subtipslb = [[UILabel alloc]initWithFrame:CGRectMake(RealWidth(20), CGRectGetMaxY(tipslb.frame)+RealWidth(10), RealWidth(250), RealWidth(13))];
        subtipslb.textColor = LGDLightBLackColor;
        subtipslb.font = [UIFont systemFontOfSize:13];
        subtipslb.text = @"未注册时输入手机号即注册成功";
        [self.view addSubview:subtipslb];
        
        
        UIView * PenguinChaseInputViews  = [[UIView alloc]initWithFrame:CGRectMake(RealWidth(20), CGRectGetMaxY(subtipslb.frame)+RealWidth(20), SCREEN_Width-RealWidth(40), RealWidth(90))];
        PenguinChaseInputViews.layer.borderColor = LGDLightBLackColor.CGColor;
        PenguinChaseInputViews.layer.borderWidth = 0.5;
        PenguinChaseInputViews.layer.cornerRadius = RealWidth(5);
        PenguinChaseInputViews.layer.masksToBounds = YES;
        [self.view addSubview:PenguinChaseInputViews];
        
        UIView *  verline = [[UIView alloc]initWithFrame:CGRectMake(0, RealWidth(45), CGRectGetWidth(PenguinChaseInputViews.frame), 0.5)];
        verline.backgroundColor = LGDLightBLackColor;
        [PenguinChaseInputViews addSubview:verline];
        
        UIImageView * phoneImg =[self imgConfigWithName:[UIImage imageNamed:@"denglu-shoujihao"] imgFrame:CGRectMake(RealWidth(15), RealWidth(13.5), RealWidth(18), RealWidth(18))];
        [PenguinChaseInputViews addSubview:phoneImg];
        
        UIImageView * codeImg =[self imgConfigWithName:[UIImage imageNamed:@"mima"] imgFrame:CGRectMake(RealWidth(15), RealWidth(13.5)+CGRectGetMaxY(verline.frame), RealWidth(18), RealWidth(18))];
        [PenguinChaseInputViews addSubview:codeImg];
        
        
        UITextField * CarpguinChasePhoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImg.frame)+RealWidth(10), 0, CGRectGetWidth(PenguinChaseInputViews.frame)-CGRectGetMaxX(phoneImg.frame)-RealWidth(10), RealWidth(45))];
        CarpguinChasePhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        CarpguinChasePhoneTextField.font = [UIFont systemFontOfSize:16];
        CarpguinChasePhoneTextField.textColor = LGDBLackColor;
        CarpguinChasePhoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        [CarpguinChasePhoneTextField addPlaceholders:[UIFont systemFontOfSize:13] holderStr:@"手机号" holderColor:LGDGaryColor];
        [PenguinChaseInputViews addSubview:CarpguinChasePhoneTextField];
        _CarpguinChasePhoneTextField =  CarpguinChasePhoneTextField;
        
        
        UITextField * CarpguinChasePasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImg.frame)+RealWidth(10), CGRectGetMaxY(verline.frame), CGRectGetWidth(PenguinChaseInputViews.frame)-CGRectGetMaxX(phoneImg.frame)-RealWidth(10+80), RealWidth(45))];
        CarpguinChasePasswordTextField.keyboardType = UIKeyboardTypeDefault;
        CarpguinChasePasswordTextField.font = [UIFont systemFontOfSize:16];
        CarpguinChasePasswordTextField.textColor = LGDBLackColor;
        CarpguinChasePasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
        [CarpguinChasePasswordTextField addPlaceholders:[UIFont systemFontOfSize:13] holderStr:@"验证码或密码" holderColor:LGDGaryColor];
        [PenguinChaseInputViews addSubview:CarpguinChasePasswordTextField];
        _CarpguinChasePasswordTextField = CarpguinChasePasswordTextField;
        
        
        UIButton * CarpguinChaseCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(PenguinChaseInputViews.frame)-RealWidth(80), CGRectGetMaxY(verline.frame), RealWidth(80), RealWidth(45))];
        CarpguinChaseCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [CarpguinChaseCodeBtn setTitleColor:LGDMianColor forState:UIControlStateNormal];
        [CarpguinChaseCodeBtn addTarget:self action:@selector(CarpguinChaseCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [CarpguinChaseCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [PenguinChaseInputViews addSubview:CarpguinChaseCodeBtn];
        _CarpguinChaseCodeBtn = CarpguinChaseCodeBtn;
        
        
        
        UIButton * CarpguinChaseLoginbtn = [[UIButton alloc]initWithFrame:CGRectMake(RealWidth(20), CGRectGetMaxY(PenguinChaseInputViews.frame)+RealWidth(30), SCREEN_Width-RealWidth(40), RealWidth(40))];
        [CarpguinChaseLoginbtn setBackgroundColor:LGDMianColor];
        CarpguinChaseLoginbtn.layer.cornerRadius = RealWidth(5);
        CarpguinChaseLoginbtn.layer.masksToBounds = YES;
        [CarpguinChaseLoginbtn setTitle:@"登录" forState:UIControlStateNormal];
        CarpguinChaseLoginbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        CarpguinChaseLoginbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [CarpguinChaseLoginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [CarpguinChaseLoginbtn addTarget:self action:@selector(CarpguinChaseLoginbtnActions) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:CarpguinChaseLoginbtn];
        
        
        UILabel * privatelb =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(CarpguinChaseLoginbtn.frame)+RealWidth(20), SCREEN_Width, RealWidth(15))];
        privatelb.textAlignment = NSTextAlignmentCenter;
        privatelb.font = [UIFont systemFontOfSize:13];
        privatelb.userInteractionEnabled = YES;
        [self.view addSubview:privatelb];
        NSString * Str1 = @"登录或注册，即代表你同意";
        NSString *Str2 = @"<用户使用协议>";
        NSMutableAttributedString * attbute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",Str1,Str2]];
        [attbute addAttribute:NSForegroundColorAttributeName value:LGDGaryColor range:NSMakeRange(0, Str1.length)];
        [attbute addAttribute:NSForegroundColorAttributeName value:LGDMianColor range:NSMakeRange(Str1.length, Str2.length)];
        privatelb.attributedText = attbute;
        
        UITapGestureRecognizer * privaterTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PrivateTapClick)];
        [privatelb addGestureRecognizer:privaterTap];
    }
    -(void)CarpguinChaseCodeBtnClick:(UIButton *)codeBtn{
        if (_CarpguinChasePhoneTextField.text.length == 0) {
            [LCProgressHUD showInfoMsg:@"请输入手机号"];
            return;
        }
        if (_CarpguinChasePhoneTextField.text.length != 11) {
            [LCProgressHUD showInfoMsg:@"请输入正确的手机号"];
            return;
        }
        [LCProgressHUD showLoading:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD showInfoMsg:@"发送成功"];
            self->_PenguinChaseTimers = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CarpguinChaseLoginbtnCodeAclciks) userInfo:nil repeats:YES];
            [self->_PenguinChaseTimers fire];
            
        });
        
    }
    -(void)CarpguinChaseLoginbtnCodeAclciks{
        _PenguinChaseNums--;
        _CarpguinChaseCodeBtn.enabled = NO;
        [_CarpguinChaseCodeBtn setTitle:[NSString stringWithFormat:@"%lds后可重发",(long)_PenguinChaseNums] forState:UIControlStateNormal];
        if (_PenguinChaseNums == 0) {
            [_PenguinChaseTimers invalidate];
            [_CarpguinChaseCodeBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
            _CarpguinChaseCodeBtn.enabled = YES;
        }
        
    }
    -(void)CarpguinChaseLoginbtnActions{
        
        if (_CarpguinChasePhoneTextField.text.length == 0) {
            [LCProgressHUD showInfoMsg:@"请输入手机号"];
            return;
        }
        if (_CarpguinChasePhoneTextField.text.length != 11) {
            [LCProgressHUD showInfoMsg:@"请输入正确的手机号"];
            return;
        }
        if (_CarpguinChasePasswordTextField.text.length == 0) {
            [LCProgressHUD showInfoMsg:@"请输入验证码或密码"];
            return;
        }
        [LCProgressHUD showLoading:@""];
        MJWeakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([weakSelf.CarpguinChasePhoneTextField.text isEqualToString:@"15068761251"] && [weakSelf.CarpguinChasePasswordTextField.text isEqualToString:@"test001"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FilmFacotryLoginSucced" object:nil];
                
                [LCProgressHUD showSuccess:@"登录成功"];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }else{
                [LCProgressHUD showInfoMsg:@"密码错误"];
            }
            
        });
        
    }
    -(void)PrivateTapClick{
        PenguinaboutUsViewController * privateVc = [[PenguinaboutUsViewController alloc]init];
        privateVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:privateVc animated:YES];
    }
    -(UIImageView *)imgConfigWithName:(UIImage *)imgNamestr imgFrame:(CGRect)imgFrame{
        UIImageView * img = [[UIImageView alloc]initWithFrame:imgFrame];
        img.image =  imgNamestr;
        return img;
    }
    -(UILabel *)holderlbWithConfig:(NSString *)lbstr lbFrame:(CGRect)lbFrame{
        UILabel * lb =[[UILabel alloc]initWithFrame:lbFrame];
        lb.text = lbstr;
        lb.textColor =  LGDLightGaryColor;
        lb.font = [UIFont systemFontOfSize:13];
        return lb;
    }
    -(void)PenguinChaseClearBtnClick{
        [self dismissViewControllerAnimated:YES completion:nil];
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


