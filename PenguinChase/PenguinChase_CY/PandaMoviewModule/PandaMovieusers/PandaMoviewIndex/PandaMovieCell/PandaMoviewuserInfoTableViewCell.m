
#import "PandaMoviewuserInfoTableViewCell.h"

@implementation PandaMoviewuserinfoCellitem

@end

@interface PandaMoviewuserInfoTableViewCell ()

@property (nonatomic, strong) UIView *PandaMoviewbackView;
@property (nonatomic, strong) UIImageView *PandaMoviewprotrailImageView;
@property (nonatomic, strong) UILabel *PandaMovietitleLabel;
@property (nonatomic, strong) UILabel *PandaMoviecontentLabel;
@property (nonatomic, strong) UIImageView *PandaMoviearrowImageView;

@end

@implementation PandaMoviewuserInfoTableViewCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = gnh_color_b;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *PandaMovietitleLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize15 titleColor:gnh_color_a];
    [self.contentView addSubview:PandaMovietitleLabel];
    PandaMovietitleLabel.textAlignment = NSTextAlignmentLeft;
    [PandaMovietitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.centerY.equalTo(self.contentView);
    }];
    self.PandaMovietitleLabel = PandaMovietitleLabel;
    
    UILabel *PandaMoviecontentLabel = [UILabel ly_LabelWithTitle:@"" font:zy_fontSize15 titleColor:gnh_color_f];
    [self.contentView addSubview:PandaMoviecontentLabel];
    PandaMoviecontentLabel.textAlignment = NSTextAlignmentRight;
    [PandaMoviecontentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.centerY.equalTo(self.contentView);
    }];
    self.PandaMoviecontentLabel = PandaMoviecontentLabel;
    
    UIImageView *PandaMoviewprotrailImageView = [UIImageView ly_ViewWithColor:UIColor.clearColor];
    PandaMoviewprotrailImageView.layer.cornerRadius = 15.0f;
    PandaMoviewprotrailImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:PandaMoviewprotrailImageView];
    [PandaMoviewprotrailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-33.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
    }];
    self.PandaMoviewprotrailImageView = PandaMoviewprotrailImageView;
    
    UIImageView *PandaMoviearrowImageView = [UIImageView ly_ImageViewWithImageName:@"pandamoview_gray_arrow"];
    [self.contentView addSubview:PandaMoviearrowImageView];
    [PandaMoviearrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-9.5f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(18.0f, 18.0f));
    }];
    self.PandaMoviearrowImageView = PandaMoviearrowImageView;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = NO;
    self.PandaMoviearrowImageView.hidden = YES;
    self.PandaMoviecontentLabel.hidden = YES;
    self.PandaMoviewprotrailImageView.hidden = YES;
    if ([item isKindOfClass:[PandaMoviewuserinfoCellitem class]]) {
        PandaMoviewuserinfoCellitem *cellItem = (PandaMoviewuserinfoCellitem *)item;
        self.PandaMovietitleLabel.text = cellItem.title;
        if (cellItem.image) {
            self.PandaMoviewprotrailImageView.image = cellItem.image;
        } else {
            [self.PandaMoviewprotrailImageView sd_setImageWithURL:[NSURL URLWithString:cellItem.anchorUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
        }
        self.PandaMoviecontentLabel.text = cellItem.content;
        switch (cellItem.cellType) {
            case PandaMoviewCellTypePortrail: { // 头像
                self.PandaMoviearrowImageView.hidden = NO;
                self.PandaMoviewprotrailImageView.hidden = NO;
                
                self.bottomLineEdgeInsets = UIEdgeInsetsMake(0, 15.0f, 0, 0);
                
                break;
            }
            case PandaMoviewCellTypeNickName: { // 昵称
                self.PandaMoviearrowImageView.hidden = NO;
                self.PandaMoviecontentLabel.hidden = NO;
                
                [self.PandaMoviecontentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView).offset(-35.0f);
                }];
                
                self.bottomLineEdgeInsets = UIEdgeInsetsMake(0, 0.0f, 0, 0);
                
                break;
            }
            default:
                break;
        }
        [self bringSubviewToFront:self.bottomLine];
        self.lineColor = gnh_color_line;
    }
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    if ([item isKindOfClass:[PandaMoviewuserinfoCellitem class]]) {
        return 56.0f;
    }
    
    return 45.0f;
}

@end
