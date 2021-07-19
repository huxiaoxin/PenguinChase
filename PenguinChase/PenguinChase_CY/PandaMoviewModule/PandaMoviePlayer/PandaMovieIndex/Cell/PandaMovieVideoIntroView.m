//
//  PandaMovieVideoIntroView.m
//
//  Created by chenyuan on 2021/1/26.
//

#import "PandaMovieVideoIntroView.h"

@interface PandaMovieVideoIntroView () <UITextViewDelegate>
@property (nonatomic, weak) LYCoverView *backView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UILabel *videoTitleLabel;
@property (nonatomic, strong) UILabel *areaLabel; // 地区
@property (nonatomic, strong) UILabel *yearLabel; // 年份
@property (nonatomic, strong) UILabel *typeLabel; // 类型
@property (nonatomic, strong) UILabel *directorLabel; // 导演
@property (nonatomic, strong) UILabel *actorLabel; // 主演

@property (nonatomic, strong) PandaMovieVideoDetailItem *videoDetailItem;

@end

@implementation PandaMovieVideoIntroView

#pragma mark - Class Method

+ (LYCoverView *)showIntroAlertView:(PandaMovieVideoDetailItem *)detailItem completeBlock:(PandaMovieIntroCompleteBlock)completeBlock
{
    LYCoverView *backView = [LYCoverView showView:nil inView:[ORAppWindow appWindow]];
    backView.touchDisMiss = NO;
    
    CGFloat orgin_y = ORKitMacros.statusBarHeight + (212.5 * kScreenWidth)/375.0;
    PandaMovieVideoIntroView *contentView = [[PandaMovieVideoIntroView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - orgin_y)];
    contentView.backView = backView;
    contentView.videoIntroCompleteBlock = completeBlock;
    contentView.videoDetailItem = detailItem;
    [backView addSubview:contentView];
    [contentView setupData];
    
    [UIView animateWithDuration:0.25 animations:^{
        contentView.frame = CGRectMake(0, orgin_y, kScreenWidth, kScreenHeight - orgin_y);
    }];
    
    return backView;
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"简介" font:zy_blodFontSize17 titleColor:gnh_color_k];
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(13.0f);
        make.height.mas_offset(45.0f);
    }];
    
    UIButton *closeButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMoview_close_arrow" selecteImageName:@"pandaMoview_close_arrow" target:self selector:@selector(closeAction:)];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-9.5f);
        make.centerY.equalTo(titleLabel);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    [closeButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    
    UIView *liveView = [UIView ly_ViewWithColor:gnh_color_line];
    [self addSubview:liveView];
    [liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    UILabel *videoTitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize17 titleColor:gnh_color_k];
    [self addSubview:videoTitleLabel];
    [videoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(liveView.mas_bottom).offset(21.5f);
        make.left.equalTo(self).offset(13.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.height.mas_offset(16.0f);
    }];
    self.videoTitleLabel = videoTitleLabel;
    
    UILabel *areaLabel = [UILabel ly_LabelWithTitle:@"地区：" font:zy_mediumSystemFont14 titleColor:gnh_color_u];
    [self addSubview:areaLabel];
    [areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(videoTitleLabel.mas_bottom).offset(16.0f);
        make.left.equalTo(self).offset(13.5f);
        make.height.mas_offset(13.0f);
    }];
    self.areaLabel = areaLabel;
    
    UILabel *yearLabel = [UILabel ly_LabelWithTitle:@"年份：" font:zy_mediumSystemFont14 titleColor:gnh_color_u];
    [self addSubview:yearLabel];
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(self).offset(13.5f);
        make.height.mas_offset(13.0f);
    }];
    self.yearLabel = yearLabel;
    
    UILabel *typeLabel = [UILabel ly_LabelWithTitle:@"类型：" font:zy_mediumSystemFont14 titleColor:gnh_color_u];
    [self addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yearLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(self).offset(13.5f);
        make.height.mas_offset(13.0f);
    }];
    self.typeLabel = typeLabel;
    
    UILabel *directorLabel = [UILabel ly_LabelWithTitle:@"导演：" font:zy_mediumSystemFont14 titleColor:gnh_color_u];
    [self addSubview:directorLabel];
    [directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(self).offset(13.5f);
        make.height.mas_offset(13.0f);
    }];
    self.directorLabel = directorLabel;
    
    UILabel *actorLabel = [UILabel ly_LabelWithTitle:@"主演：" font:zy_mediumSystemFont14 titleColor:gnh_color_u];
    [self addSubview:actorLabel];
    [actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(directorLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(self).offset(13.5f);
        make.height.mas_offset(13.0f);
    }];
    self.actorLabel = actorLabel;
    
    // 内容
    UITextView *contentTextView = [UITextView ly_ViewWithColor:gnh_color_b];
    contentTextView.textAlignment = NSTextAlignmentLeft;
    contentTextView.textColor = gnh_color_u;
    contentTextView.font = zy_mediumSystemFont14;
    contentTextView.editable = NO;
    [self addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(actorLabel.mas_bottom).offset(28.0f);
        make.left.equalTo(self).offset(13.5);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-ORKitMacros.iphoneXSafeHeight);
    }];
    self.contentTextView = contentTextView;
}

#pragma mark - buttonAction

- (void)closeAction:(UIButton *)btn
{
    [self.backView disMiss];
}

#pragma mark - setupData

- (void)setupData
{
    self.videoTitleLabel.text = unemptyString(self.videoDetailItem.videoName, @"") ;
    
    self.areaLabel.text = [@"地区：" stringByAppendingString:unemptyString(self.videoDetailItem.areaTypeCh, @"")];
    self.yearLabel.text = [@"年份：" stringByAppendingString:unemptyString(self.videoDetailItem.yearTypeCh, @"")];
    self.typeLabel.text = [@"类型：" stringByAppendingString:unemptyString(self.videoDetailItem.childTypeCh, @"")];
    self.directorLabel.text = [@"导演：" stringByAppendingString:unemptyString(self.videoDetailItem.director, @"")];
    self.actorLabel.text = [@"主演：" stringByAppendingString:unemptyString(self.videoDetailItem.actor, @"")];
    
    if (self.videoDetailItem.videoDesc.length) {
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.videoDetailItem.videoDesc];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 8.0f;
        [attri addAttributes:@{NSParagraphStyleAttributeName: style, NSFontAttributeName:zy_mediumSystemFont14, NSForegroundColorAttributeName: gnh_color_u} range:NSMakeRange(0, self.videoDetailItem.videoDesc.length)];
        self.contentTextView.attributedText = attri;
    }
}

@end
