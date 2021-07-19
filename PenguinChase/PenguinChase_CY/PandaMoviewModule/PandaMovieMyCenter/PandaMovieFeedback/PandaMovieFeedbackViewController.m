
#import "PandaMovieFeedbackViewController.h"
#import "PandaMovieFeedbackDataModel.h"
#import <WebKit/WebKit.h>
@interface PandaMovieFeedbackViewController () <UITextViewDelegate>
@property (nonatomic, strong) PandaMovieFeedbackDataModel *feedbackDataModel;
@property (nonatomic, strong) UITextView *PandaMoviecontentTextView;
@property (nonatomic, strong) UILabel    *PandaMovieplaceholderLabel;
@property (nonatomic, strong) UILabel    *PandaMoviecountLabel;
@end

@implementation PandaMovieFeedbackViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupData];
    
    [self setupNotifications];
     

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - setupUI

- (void)setupUI
{
    GNHWeakSelf;
    
    UITextView *PandaMoviecontentTextView = [UITextView ly_TextViewWithText:@"" font:zy_fontSize14 textColor:gnh_color_a delegate:self];
    PandaMoviecontentTextView.backgroundColor = gnh_color_d;
    PandaMoviecontentTextView.textAlignment = NSTextAlignmentLeft;
    PandaMoviecontentTextView.delegate = self;
    PandaMoviecontentTextView.layer.cornerRadius = 10.0f;
    PandaMoviecontentTextView.layer.masksToBounds = YES;
    [self.tableView addSubview:PandaMoviecontentTextView];
    self.PandaMoviecontentTextView = PandaMoviecontentTextView;
    [PandaMoviecontentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).inset(15.0f);
        make.top.equalTo(self.tableView).offset(15.0f);
        make.height.mas_equalTo(154.0f);
    }];
    
    UILabel *PandaMovieplaceholderLabel = [UILabel ly_LabelWithTitle:@"请描述您的问题～" font:zy_fontSize14 titleColor:gnh_color_e];
    PandaMovieplaceholderLabel.textAlignment = NSTextAlignmentLeft;
    PandaMovieplaceholderLabel.numberOfLines = 0;
    PandaMovieplaceholderLabel.enabled = NO;
    PandaMovieplaceholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.PandaMoviecontentTextView addSubview:PandaMovieplaceholderLabel];
    [PandaMovieplaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.PandaMoviecontentTextView).offset(7.0f);
        make.left.equalTo(weakSelf.PandaMoviecontentTextView).offset(5.0f);
        make.right.equalTo(weakSelf.PandaMoviecontentTextView).offset(-7.0f);
    }];
    self.PandaMovieplaceholderLabel = PandaMovieplaceholderLabel;
    
    UILabel *PandaMoviecountLabel = [UILabel ly_LabelWithTitle:@"0/200" font:zy_fontSize14 titleColor:gnh_color_f];
    PandaMoviecountLabel.textAlignment = NSTextAlignmentRight;
    [self.PandaMoviecontentTextView addSubview:PandaMoviecountLabel];
    [PandaMoviecountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecontentTextView).offset(132.0f);
        make.right.mas_equalTo(self.view.mas_right).offset(-24.f);
        make.height.mas_offset(10.0f);
    }];
    self.PandaMoviecountLabel = PandaMoviecountLabel;
    
    UIButton *submitButton = [[UIButton alloc] init];
    submitButton.backgroundColor = LGDMianColor;
    submitButton.layer.cornerRadius = 22.0f;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:gnh_color_b forState:UIControlStateNormal];
    submitButton.titleLabel.font = zy_fontSize15;
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PandaMoviecontentTextView.mas_bottom).offset(17.0f);
        make.left.right.equalTo(self.view).inset(15.0f);
        make.height.mas_equalTo(@44.0f);
    }];
}

#pragma mark - setupData

- (void)setupData
{
    self.navigationItem.title = @"意见反馈";
}

#pragma mark - UITextView delegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.PandaMovieplaceholderLabel.text = textView.text;
    if (textView.text.length == 0) {
        self.PandaMovieplaceholderLabel.text = @"请留下您宝贵的意见～";
    } else {
        self.PandaMovieplaceholderLabel.text = @"";
    }
    
    self.PandaMoviecountLabel.text = [NSString stringWithFormat:@"%@/200", @(textView.text.length)];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length + text.length > 200) {
        return NO;
    }
    
    return YES;;
}

#pragma mark - buttonAction

- (void)submitAction:(id)sender
{
    if (!self.PandaMoviecontentTextView.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请留下您宝贵的意见～"];
        return;
    }
    
    [self.feedbackDataModel PandaMoviesubmitWithContent:self.PandaMoviecontentTextView.text];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isKindOfClass:[PandaMovieFeedbackDataModel class]]) {
        [SVProgressHUD showSuccessWithStatus:@"已提交"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

#pragma mark - Properties

- (PandaMovieFeedbackDataModel *)feedbackDataModel
{
    if (!_feedbackDataModel) {
        _feedbackDataModel = [self produceModel:[PandaMovieFeedbackDataModel class]];
    }
    return _feedbackDataModel;
}

@end
