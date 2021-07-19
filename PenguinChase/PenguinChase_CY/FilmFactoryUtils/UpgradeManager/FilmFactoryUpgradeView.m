
#import "FilmFactoryUpgradeView.h"
#import "GNHBaseButton.h"
#import "ORMainAPI.h"

@implementation FilmFactoryUpgradeView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (LYCoverView *)setupView:(NSString *)upgradeContent upgradeUrl:(NSString *)upgradeUrl version:(NSString *)version isForceUpgrade:(BOOL)isforceUpgrade
{
    LYCoverView *updateBgView = [LYCoverView showView:nil inView:[ORMainAPI appWindow]];
    updateBgView.touchDisMiss = NO;
    
    UIImageView *ImgView = [UIImageView ly_ImageViewWithImageName:@"padanMoview_upda_bj_icon"];
    ImgView.contentMode = UIViewContentModeScaleAspectFit;
    ImgView.backgroundColor = UIColor.clearColor;
    ImgView.layer.cornerRadius = 8.0f;
    ImgView.layer.masksToBounds = YES;
    ImgView.userInteractionEnabled = YES;
    [updateBgView addSubview:ImgView];
    [ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(updateBgView);
        make.size.mas_equalTo(ImgView.image.size);
    }];
    
    NSString *verStr = [@"V" stringByAppendingString:version];
    UILabel *upGradeNotiLabel = [UILabel ly_LabelWithTitle:verStr font:zy_mediumSystemFont14 titleColor:gnh_color_a];
    [ImgView addSubview:upGradeNotiLabel];
    upGradeNotiLabel.textAlignment = NSTextAlignmentCenter;
    [upGradeNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ImgView.mas_top).offset(76.5f);
        make.left.equalTo(ImgView).offset(29.0f);
        make.height.mas_equalTo(10.5f);
    }];
    
    UITextView *contentTextView = [UITextView ly_TextViewWithText:nil font:zy_mediumSystemFont14 textColor:gnh_color_f delegate:nil];
    contentTextView.editable = NO;
    contentTextView.textAlignment = NSTextAlignmentCenter;
    contentTextView.backgroundColor = [UIColor clearColor];
    [ImgView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upGradeNotiLabel.mas_bottom).with.offset(64.5f);
        make.left.mas_equalTo(ImgView).offset(25.0f);
        make.right.mas_equalTo(ImgView).offset(-25.0f);
        make.bottom.mas_equalTo(ImgView.mas_bottom).offset(-70.0f);
    }];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{NSFontAttributeName:zy_mediumSystemFont14,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    contentTextView.typingAttributes = attributes;
    contentTextView.text = upgradeContent;

    GNHBaseButton *upGradeBtn = [GNHBaseButton buttonWithTitle:@"立即升级" didClickBlock:^(__kindof GNHBaseButton *button) {
        [ORMainAPI openScheme:upgradeUrl completion:nil];
    }];
    upGradeBtn.layer.cornerRadius = 20.0f;
    [upGradeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    upGradeBtn.titleLabel.font = zy_mediumSystemFont15;
    upGradeBtn.backgroundColor = gnh_color_theme;
    [ImgView addSubview:upGradeBtn];
    [upGradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(ImgView.mas_bottom).offset(-20.0f);
        make.centerX.equalTo(ImgView);
        make.size.mas_equalTo(CGSizeMake(228, 40.0f));
    }];
    
    if (!isforceUpgrade) {
        GNHWeakObj(updateBgView);
        GNHBaseButton *closeBtn = [GNHBaseButton buttonWithTitle:@"" didClickBlock:^(__kindof GNHBaseButton *button) {
            [UIView animateWithDuration:0.3 animations:^{
                updateBgView.alpha = 0;
            } completion:^(BOOL finished) {
                [weakupdateBgView disMiss];
            }];
        }];
        [closeBtn setImage:[UIImage imageNamed:@"pandaMoview_upgared_clous_icon"] forState:UIControlStateNormal];
        [updateBgView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ImgView.mas_bottom).offset(16.5f);
            make.centerX.equalTo(ImgView);
            make.size.mas_equalTo(CGSizeMake(35.0f, 35.0f));
        }];
    }
    
    return updateBgView;
}

@end

