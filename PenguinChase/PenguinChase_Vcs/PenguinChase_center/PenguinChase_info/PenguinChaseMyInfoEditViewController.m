

#import "PenguinChaseMyInfoEditViewController.h"
#import "UITextField+AddPlaceholder.h"
@interface PenguinChaseMyInfoEditViewController ()
@property(nonatomic,strong) UITextField * PenguinInfoTextField;
@end

@implementation PenguinChaseMyInfoEditViewController

-(void)PenguinInfoCommitBtnClick{
    if (_PenguinInfoTextField.text.length == 0) {
        [LCProgressHUD showInfoMsg:@"没有修改任何内容"];
        return;
    }
    [LCProgressHUD showLoading:@""];
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:self->_PenguinInfoTextField.text forKey:@"CarpvideoName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [LCProgressHUD showSuccess:@"修改成功"];
        if (weakSelf.seltecdInfoBlock) {
            weakSelf.seltecdInfoBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    });
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.seltecdInfoBlock) {
        self.seltecdInfoBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"修改信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * PenguinInfoCommitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K(80), K(60))];
    UIButton * PenguinInfoCommitBtn = [[UIButton alloc]initWithFrame:CGRectMake(K(20), K(12), K(40), K(20))];
    [PenguinInfoCommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [PenguinInfoCommitBtn setTitleColor:LGDBLackColor forState:UIControlStateNormal];
    PenguinInfoCommitBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [PenguinInfoCommitBtn addTarget:self action:@selector(PenguinInfoCommitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PenguinInfoCommitView addSubview:PenguinInfoCommitBtn];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinInfoCommitView];
    
    UIView * PenguinInfoCommitContentView = [[UIView alloc]initWithFrame:CGRectMake(K(15), NaviH+K(15), SCREEN_Width-K(30), K(40))];
    PenguinInfoCommitContentView.backgroundColor = LGDLightGaryColor;
    PenguinInfoCommitContentView.layer.cornerRadius =K(5);
    PenguinInfoCommitContentView.layer.masksToBounds = YES;
    [self.view addSubview:PenguinInfoCommitContentView];
    
    UITextField * PenguinInfoTextField = [[UITextField alloc]initWithFrame:CGRectMake(K(10), 0, SCREEN_Width-K(40), K(40))];
    PenguinInfoTextField.backgroundColor = LGDLightGaryColor;
    PenguinInfoTextField.layer.cornerRadius =K(5);
    PenguinInfoTextField.layer.masksToBounds = YES;
    [PenguinInfoTextField addPlaceholders:[UIFont systemFontOfSize:14] holderStr:@"输入昵称" holderColor:LGDGaryColor];
    [PenguinInfoCommitContentView addSubview:PenguinInfoTextField];
    _PenguinInfoTextField=  PenguinInfoTextField;
    
    UILabel  * PenguinInfoTpislb = [[UILabel alloc]initWithFrame:CGRectMake(K(15), CGRectGetMaxY(PenguinInfoCommitContentView.frame)+K(10), SCREEN_Width-K(30), K(14))];
    PenguinInfoTpislb.textColor = LGDGaryColor;
    PenguinInfoTpislb.font =[UIFont systemFontOfSize:12];
    [self.view addSubview:PenguinInfoTpislb];
    
    
    NSTextAttachment * PenguinInfotextment = [[NSTextAttachment alloc]init];
    PenguinInfotextment.image = [UIImage imageNamed:@"tishi"];
    PenguinInfotextment.bounds = CGRectMake(0, -2, K(14), K(14));
    NSAttributedString * PenguinInfAttbute = [NSAttributedString attributedStringWithAttachment:PenguinInfotextment];
    NSMutableAttributedString * mutablAtt = [[NSMutableAttributedString alloc]initWithString:@" 最多输入15个字符，字母开头，设置后不能修改"];
    [mutablAtt insertAttributedString:PenguinInfAttbute atIndex:0];
    PenguinInfoTpislb.attributedText = mutablAtt;
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PenguinInfoTextField becomeFirstResponder];
    });
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
