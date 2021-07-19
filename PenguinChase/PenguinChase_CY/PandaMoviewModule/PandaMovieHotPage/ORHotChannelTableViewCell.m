//
//  ORHotChannelTableViewCell.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/22.
//

#import "ORHotChannelTableViewCell.h"

@interface  ORHotChannelTableViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UIImageView *topbackImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *videoTimeLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *shareButton; // 分享
@property (nonatomic, strong) UIButton *likeButton;  // 点赞
@property (nonatomic, strong) UIButton *moreButton;  // 更多

@property (nonatomic, strong)  PandaMovieHotChannelDataItem *channelItem;

@end

@implementation ORHotChannelTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LGDViewBJColor;
        self.tintColor = gnh_color_g;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UIImageView *coverImageView = [UIImageView ly_ViewWithColor:UIColor.clearColor];
    coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:coverImageView];
    [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo((212.5 * kScreenWidth) / 375.0f);
    }];
    self.coverImageView = coverImageView;
    
    UIImageView *playImageView = [UIImageView ly_ImageViewWithImageName:@"pandaMovie_hot_play_icon"];
    [self.contentView addSubview:playImageView];
    [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(coverImageView);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    self.playImageView = playImageView;
    self.playImageView.hidden = YES;
    
    UIImageView *topbackImageView = [UIImageView ly_ImageViewWithImageName:@"pandaMovie_hot_topBack_icon"];
    [self.contentView addSubview:topbackImageView];
    [topbackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
    }];
    self.topbackImageView = topbackImageView;
    
    UILabel *titleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize16 titleColor:gnh_color_b];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11.5f);
        make.left.equalTo(self.contentView).offset(17.0f);
        make.right.equalTo(topbackImageView);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *videoTimeLabel = [UILabel ly_LabelWithTitle:@"" font:zy_blodFontSize14 titleColor:gnh_color_b];
    [coverImageView addSubview:videoTimeLabel];
    videoTimeLabel.textAlignment = NSTextAlignmentRight;
    [videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(coverImageView).offset(-14.0f);
        make.bottom.equalTo(coverImageView).offset(-12.0f);
    }];
    self.videoTimeLabel = videoTimeLabel;
    
    UIView *bottomView = [UIView ly_ViewWithColor:LGDViewBJColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(coverImageView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(42.0f);
    }];
    self.bottomView = bottomView;
    
    UILabel *timeLabel = [UILabel ly_LabelWithTitle:@"" font:zy_mediumSystemFont14 titleColor:[UIColor whiteColor]];
    [bottomView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(11.5f);
        make.centerY.equalTo(bottomView);
        make.width.mas_equalTo(100.0f);
    }];
    self.timeLabel = timeLabel;
    self.timeLabel.hidden = YES;
    
    UIButton *moreButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMovie_hotMore_icon" selecteImageName:@"pandaMovie_hotMore_icon" target:self selector:@selector(moreAction:)];
    [bottomView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-2.5f);
        make.centerY.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(24.0f, 24.0f));
    }];
    self.moreButton = moreButton;
    
    UIButton *likeButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMovie_hotlike_icon" selecteImageName:@"pandaMovie_hotlike_icon" target:self selector:@selector(likeAction:)];
    [likeButton setTitle:@"10000" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    likeButton.titleLabel.font = zy_mediumSystemFont14;
    [likeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [bottomView addSubview:likeButton];
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreButton.mas_left).offset(-4.5f);
        make.centerY.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(80.0f, 24.0f));
    }];
    self.likeButton = likeButton;
    
    UIButton *shareButton = [UIButton ly_ButtonWithNormalImageName:@"pandaMovie_hot_share" selecteImageName:@"pandaMovie_hot_share" target:self selector:@selector(shareAction:)];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = zy_mediumSystemFont14;
    [shareButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    [bottomView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(likeButton.mas_left).offset(-13.5f);
        make.centerY.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(50.0f, 24.0f));
    }];
    self.shareButton = shareButton;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    if ([item isKindOfClass:[PandaMovieHotChannelDataItem class]]) {
        PandaMovieHotChannelDataItem *channelItem = (PandaMovieHotChannelDataItem *)item;
        self.channelItem = channelItem;
        
        [self.coverImageView sd_setImageWithURL:channelItem.coverImg.urlWithString placeholderImage:[UIImage imageNamed:@"pandaMovie_cover_default"]];
        
        NSInteger hour = [channelItem.videoSeconds integerValue]/60.0/60.0;
        NSInteger minite = [channelItem.videoSeconds integerValue]/60.0;
        if (minite >= 60) {
            minite = minite % 60;
        }
        NSInteger seconds = [channelItem.videoSeconds integerValue] % 60;

        NSString *timeStr = @"";
        if (hour >= 1) {
            timeStr = [NSString stringWithFormat:@"%02ld:",(long)hour];
        }
        timeStr = [timeStr stringByAppendingFormat:@"%02ld:%02ld", (long)minite, (long)seconds];
        self.videoTimeLabel.text = [NSString stringWithFormat:@"%@",timeStr];
        self.titleLabel.text = channelItem.videoName;
        
        [self.likeButton setTitle:@(channelItem.likes).stringValue forState:UIControlStateNormal];
        CGSize tagSize = [@(channelItem.likes).stringValue textWithSize:14.0f size:CGSizeZero];
        [self.likeButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(tagSize.width + 24.0f + 4.0f, 24.0f));
        }];
        
        [self.coverImageView mdf_whenSingleTapped:^(UIGestureRecognizer *gestureRecognizer) {
            if (self.hotChannelActionBlock) {
                self.hotChannelActionBlock(self.channelItem, ORHotChannelActionTypePlay);
            }
        }];
    }
}

#pragma mark - buttonAction

- (void)moreAction:(UIButton *)button
{
    if (self.hotChannelActionBlock) {
        self.hotChannelActionBlock(self.channelItem, ORHotChannelActionTypeMore);
    }
}

- (void)likeAction:(UIButton *)button
{
    if (self.hotChannelActionBlock) {
        self.hotChannelActionBlock(self.channelItem, ORHotChannelActionTypeLike);
    }
}

- (void)shareAction:(UIButton *)button
{
    if (self.hotChannelActionBlock) {
        self.hotChannelActionBlock(self.channelItem, ORHotChannelActionTypeShare);
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMovieHotChannelDataItem class]]) {
        return 42.0f + (212.5 * kScreenWidth) / 375.0f;
    }
    return 42.0f;
}

@end
