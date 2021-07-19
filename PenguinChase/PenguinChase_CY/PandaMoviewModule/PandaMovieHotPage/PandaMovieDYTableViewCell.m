//
//  SJDYTableViewCell.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/2/19.
//

#import "PandaMovieDYTableViewCell.h"
#import <SJBaseVideoPlayer/SJPlayModel.h>
#import "PandaMovieLikeView.h"

@interface SJPlayerSuperImageView : UIImageView <SJPlayModelPlayerSuperview>
@end
@implementation SJPlayerSuperImageView
@end

@interface ORHotVideoItemButton : UIButton
@end

@implementation ORHotVideoItemButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.imageView.frame = CGRectMake((width - 24) / 2, 0, 24, 24);
    
    CGFloat titleW = self.titleLabel.frame.size.width;
    CGFloat titleH = self.titleLabel.frame.size.height;
    
    self.titleLabel.frame = CGRectMake((width - titleW) / 2, height - titleH, titleW, titleH);
}

@end

@interface PandaMovieDYTableViewCell ()
@property (nonatomic, strong) SJPlayerSuperImageView *playerSuperImageView;

@property (nonatomic, strong) UIButton              *playBtn;
@property (nonatomic, strong) ORHotVideoItemButton   *collectBtn;  // 收藏
@property (nonatomic, strong) PandaMovieLikeView            *likeView;    // 点赞
@property (nonatomic, strong) ORHotVideoItemButton   *shareBtn;    // 分享
@property (nonatomic, strong) PandaMovieSliderView          *sliderView;

@property (nonatomic, strong) UILabel               *nameLabel;
@property (nonatomic, strong) UILabel               *contentLabel;

@end

@implementation PandaMovieDYTableViewCell

#pragma mark - LifeCycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        self.backgroundColor = UIColor.blackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    SJPlayerSuperImageView *playerSuperImageView = [SJPlayerSuperImageView.alloc initWithFrame:CGRectZero];
    playerSuperImageView.contentMode = UIViewContentModeScaleAspectFit;
    playerSuperImageView.userInteractionEnabled = YES;
    playerSuperImageView.clipsToBounds = YES;
    [self.contentView addSubview:playerSuperImageView];
    [playerSuperImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.playerSuperImageView = playerSuperImageView;
    
    [self addSubview:self.collectBtn];
    [self addSubview:self.likeView];
    [self addSubview:self.shareBtn];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.sliderView];
    [self addSubview:self.playBtn];
            
    CGFloat bottomM = ORKitMacros.tabBarHeight;
    self.sliderView.frame = CGRectMake(0, kScreenHeight - ORKitMacros.tabBarHeight - 0.5, kScreenWidth, ADAPTATIONRATIO * 1.0f);
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ADAPTATIONRATIO * 30.0f);
        make.bottom.equalTo(self).offset(-(ADAPTATIONRATIO * 30.0f + bottomM));
        make.width.mas_equalTo(ADAPTATIONRATIO * 504.0f);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.bottom.equalTo(self.contentLabel.mas_top).offset(-ADAPTATIONRATIO * 20.0f);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-ADAPTATIONRATIO * 30.0f);
        make.bottom.equalTo(self.sliderView.mas_top).offset(-ADAPTATIONRATIO * 100.0f);
        make.width.mas_equalTo(ADAPTATIONRATIO * 110.0f);
        make.height.mas_equalTo(45.0f);
    }];
    
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn);
        make.bottom.equalTo(self.shareBtn.mas_top).offset(-ADAPTATIONRATIO * 45.0f);
        make.width.mas_equalTo(ADAPTATIONRATIO * 110.0f);
        make.height.mas_equalTo(45.0f);
    }];
    
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn);
        make.bottom.equalTo(self.likeView.mas_top).offset(-ADAPTATIONRATIO * 45.0f);
        make.width.mas_equalTo(ADAPTATIONRATIO * 110.0f);
        make.height.mas_equalTo(45.0f);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - setupData

- (void)setVideoItem:(PandaMovieHotChannelDataItem *)videoItem
{
    _videoItem = videoItem;
    
    [self.playerSuperImageView sd_setImageWithURL:videoItem.coverImg.urlWithString];
    self.nameLabel.text = @"@企鹅追剧";
    self.contentLabel.text = videoItem.videoDesc;
    
    [self.likeView PandaMoviesetupLikeState:videoItem.like];
    [self.likeView PanDaMoviesetupLikeCount:@(videoItem.likes).stringValue];
    
    if (videoItem.favourite) {
        self.collectBtn.selected = YES;
    } else {
        self.collectBtn.selected = NO;
    }
}

- (void)setDelegate:(id<PandaMovieHotVideoControlViewDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setProgress:(float)progress
{    
    self.sliderView.value = progress;
}

- (void)startLoading
{
    [self.sliderView showLineLoading];
}

- (void)stopLoading
{
    [self.sliderView hideLineLoading];
}

- (void)showLikeAnimation
{
    [self.likeView PandaMoviestartAnimationWithIsLike:YES];
}

- (void)showUnLikeAnimation
{
    [self.likeView PandaMoviestartAnimationWithIsLike:NO];
}

- (void)setIsPlayButtonHidden:(BOOL)isPlayButtonHidden
{
    _playBtn.hidden = isPlayButtonHidden;
    
    // 隐藏
    if (_playBtn.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.collectBtn.alpha = 1.0;
            self.likeView.alpha = 1.0;
            self.shareBtn.alpha = 1.0;
            self.sliderView.alpha = 1.0;
            self.nameLabel.alpha = 1.0;
            self.contentLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.collectBtn.alpha = 0.0;
            self.likeView.alpha = 0.0;
            self.shareBtn.alpha = 0.0;
            self.sliderView.alpha = 0.0;
            self.nameLabel.alpha = 0.0;
            self.contentLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (BOOL)isPlayButtonHidden
{
    return _playBtn.isHidden;
}

- (BOOL)isPlayButtonSelected
{
    return _playBtn.isSelected;
}

- (void)resumePlayStatus:(BOOL)isSelected
{
    self.playBtn.selected = isSelected;
}

- (void)setIsHiddenContentView:(BOOL)isHiddenContentView
{
}

#pragma mark - Action

- (void)praiseBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(controlViewDidClickPriase:)]) {
        [self.delegate controlViewDidClickPriase:self];
    }
}

- (void)collectBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(controlViewDidClickCollect:)]) {
        [self.delegate controlViewDidClickCollect:self];
    }
}

- (void)shareBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(controlViewDidClickShare:)]) {
        [self.delegate controlViewDidClickShare:self];
    }
}

- (void)playBtnClick:(id)sender
{
    self.playBtn.selected = !self.playBtn.isSelected;
    
    if ([self.delegate respondsToSelector:@selector(controlViewDidClickPlayBtn:)]) {
        [self.delegate controlViewDidClickPlayBtn:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount > 1) {
        if ([self.delegate respondsToSelector:@selector(controlView:touchesBegan:withEvent:)]) {
            [self.delegate controlView:self touchesBegan:touches withEvent:event];
        }
    }
}

#pragma mark - 懒加载

- (PandaMovieLikeView *)likeView
{
    if (!_likeView) {
        _likeView = [PandaMovieLikeView new];
        GNHWeakSelf;
        _likeView.pandalikeViewAction = ^(BOOL isLike) {
            [weakSelf praiseBtnClick:nil];
        };
    }
    return _likeView;
}

- (ORHotVideoItemButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [ORHotVideoItemButton new];
        [_collectBtn setImage:[UIImage imageNamed:@"pandaMoview_hotDerttail_colltecd_nomal"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"pandaMoview_hotDerttail_colltecd_sel"] forState:UIControlStateSelected];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        _collectBtn.titleLabel.font = zy_mediumSystemFont13;
        [_collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

- (ORHotVideoItemButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [ORHotVideoItemButton new];
        [_shareBtn setImage:[UIImage imageNamed:@"pandaMoview_DetailShare_icon"] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = zy_mediumSystemFont13;
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _nameLabel.userInteractionEnabled = YES;
    }
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _contentLabel;
}

- (PandaMovieSliderView *)sliderView
{
    if (!_sliderView) {
        _sliderView = [PandaMovieSliderView new];
        _sliderView.isHideSliderBlock = NO;
        _sliderView.sliderHeight = 1.0f;
        _sliderView.maximumTrackTintColor = RGBA_HexCOLOR(0x494949, 1.0);
        _sliderView.minimumTrackTintColor = [UIColor whiteColor];
    }
    return _sliderView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setImage:[UIImage imageNamed:@"pandaMoview_casue_icon"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"pandaMoview_play_icon"] forState:UIControlStateSelected];
        _playBtn.hidden = YES;
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

@end
