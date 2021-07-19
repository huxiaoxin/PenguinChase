
#import "FilmFacorryAgreementHints.h"
#import "GNHBaseTextView.h"

@interface FilmFacorryAgreementHints ()<UITextViewDelegate>
@property (nonatomic, copy) NSString *hints;
@property (nonatomic, strong) GNHBaseTextView *contentTV;
@property (nonatomic, strong) UIButton *disagreeBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, weak) LYCoverView *coverView;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *links;
@property (nonatomic, copy) void(^clickAction)(NSString *link, ZYAgreementActionType type);

@end
@implementation FilmFacorryAgreementHints

- (instancetype)initWithHints:(NSString *)hints links:(NSDictionary<NSString *, NSString *> *)links {
    if (self = [super init]) {
        self.hints = hints;
        self.links = links;
        [self configUI];
        [self configData];
    }
    return self;
}

- (void)showInView:(UIView *)view clickAction:(nonnull void (^)(NSString *link, ZYAgreementActionType type))clickAction {
    self.clickAction = clickAction;
    [self.coverView removeFromSuperview];
    self.coverView = [LYCoverView showView:self inView:view];
    self.coverView.touchDisMiss = NO;
}

- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    UILabel *titleLb = [UILabel ly_LabelWithTitle:@"企鹅追剧" font:[UIFont boldSystemFontOfSize:16] titleColor:gnh_color_a];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.right.equalTo(self);
    }];
    
    self.contentTV = [GNHBaseTextView ly_TextViewWithText:self.hints font:[UIFont systemFontOfSize:14] textColor:gnh_color_a delegate:self];
    self.contentTV.isHiddenEditMenu = YES;
    self.contentTV.selectable = YES;
    self.contentTV.editable = NO;
    self.contentTV.scrollEnabled = NO;
    [self addSubview:self.contentTV];
    [self.contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.width.mas_offset(kScreenWidth - 45.0 * 2);
    }];
    
    self.disagreeBtn = [UIButton ly_ButtonWithTitle:@"不同意" titleColor:gnh_color_a font:[UIFont systemFontOfSize:14] target:self selector:@selector(btnClick:)];
    self.disagreeBtn.layer.cornerRadius = 7.5;
    self.disagreeBtn.layer.borderColor = RGBA_HexCOLOR(0xDEDEDE, 1.0).CGColor;
    self.disagreeBtn.layer.borderWidth = 1;
    self.disagreeBtn.tag = ZYAgreementActionTypeDisagree;
    [self addSubview:self.disagreeBtn];
    [self.disagreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTV.mas_bottom).offset(20);
        make.left.equalTo(self).offset(35.0f);
        make.size.mas_offset(CGSizeMake(108, 42));
        make.bottom.equalTo(self).offset(-20);
    }];
    
    self.agreeBtn = [UIButton ly_ButtonWithTitle:@"同意" titleColor:UIColor.whiteColor font:[UIFont systemFontOfSize:14] target:self selector:@selector(btnClick:)];
    self.agreeBtn.layer.cornerRadius = 7.5;
    self.agreeBtn.tag = ZYAgreementActionTypeAgree;
    self.agreeBtn.backgroundColor = gnh_color_theme;
    [self addSubview:self.agreeBtn];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTV.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-35.0f);
        make.size.mas_offset(CGSizeMake(108, 42));
        make.bottom.equalTo(self).offset(-20);
    }];
}

- (void)configData {
    if (self.hints.length) {
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.hints];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.headIndent = 10;
        style.lineSpacing = 4.0f;
        [attri addAttributes:@{NSParagraphStyleAttributeName: style, NSFontAttributeName: self.contentTV.font, NSForegroundColorAttributeName: self.contentTV.textColor} range:NSMakeRange(0, self.hints.length)];
        if (self.links.count) {
            [self.links enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
                NSRange range = [self.hints rangeOfString:obj];
                if (range.location != NSNotFound) {
                    [attri addAttributes:@{NSParagraphStyleAttributeName: style, NSFontAttributeName: self.contentTV.font, NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#1A89FD"], NSLinkAttributeName: key} range:range];
                }
            }];
        }
        self.contentTV.attributedText = attri;
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange {
    if (self.clickAction) {
        self.clickAction(URL.scheme, ZYAgreementActionTypePrivacyAgreement || ZYAgreementActionTypeUserAgreement);
    }
    return NO;
}

- (void)disMiss {
    [self.coverView disMiss];
}

- (void)btnClick:(UIButton *)button {
    if (self.clickAction) {
        self.clickAction(nil, button.tag);
    }
}

@end
