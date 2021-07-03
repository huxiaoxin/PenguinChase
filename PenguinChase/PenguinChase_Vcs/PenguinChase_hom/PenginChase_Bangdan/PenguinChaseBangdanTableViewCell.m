//
//  PenguinChaseBangdanTableViewCell.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseBangdanTableViewCell.h"
#import <SDCycleScrollView.h>
#import "WWStarView.h"
#import "PenguinChaseWantBtn.h"
@interface PenguinChaseBangdanTableViewCell ()
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) SDCycleScrollView * PengunSDC;
@property(nonatomic,strong) UILabel * PenguinTitle;
@property(nonatomic,strong) UIView  * PenguinStarView;
@property(nonatomic,strong) WWStarView * starView;
@property(nonatomic,strong) UILabel * penuinSourcelb;
@property(nonatomic,strong) UILabel * PenuinRatelb;
@property(nonatomic,strong) UILabel * PenuinInfolb;
@property(nonatomic,strong) PenguinChaseWantBtn * wantBtn;
@property(nonatomic,strong) UILabel * PenguinContentlb;
@property(nonatomic,strong) UIView  * PenguinBtomline;
@end
@implementation PenguinChaseBangdanTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinThubImgView];
    [self.contentView addSubview:self.PengunSDC];
    [self.contentView addSubview:self.PenguinTitle];
    [self.contentView addSubview:self.PenguinStarView];
    [self.contentView addSubview:self.PenuinRatelb];

    [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.inset(RealWidth(15));
        make.size.mas_equalTo(CGSizeMake(RealWidth(100), RealWidth(140)));
    }];
    [_PengunSDC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(10));
        make.right.mas_equalTo(-RealWidth(15));
        make.top.mas_equalTo(RealWidth(15));
        make.height.mas_equalTo(RealWidth(140));
    }];
    [_PenguinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(RealWidth(15));
        make.right.mas_equalTo(RealWidth(50));
        make.top.mas_equalTo(_PenguinThubImgView.mas_bottom).offset(RealWidth(10));
    }];
    [_PenguinStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(RealWidth(15));
        make.top.mas_equalTo(_PenguinTitle.mas_bottom).offset(RealWidth(5));
        make.size.mas_equalTo(CGSizeMake(RealWidth(80), RealWidth(10)));
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [_PenguinStarView addSubview:self.starView];
    [self.contentView addSubview:self.penuinSourcelb];
    [self.contentView addSubview:self.PenuinInfolb];
    [self.contentView addSubview:self.wantBtn];
    [self.contentView addSubview:self.PenguinContentlb];
    [self.contentView addSubview:self.PenguinBtomline];
    [_penuinSourcelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_starView);
        make.left.mas_equalTo(_starView.mas_right).offset(RealWidth(4));
    }];
    [_PenuinRatelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(RealWidth(50));
        make.centerY.mas_equalTo(_penuinSourcelb.mas_centerY);
        make.left.mas_equalTo(_penuinSourcelb.mas_right).offset(RealWidth(3));
    }];
    [_PenuinInfolb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RealWidth(15));
        make.top.mas_equalTo(_starView.mas_bottom).offset(RealWidth(7));
        make.right.mas_equalTo(-RealWidth(15));
    }];
    [_wantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_starView.mas_centerY).offset(-RealWidth(5));
        make.right.mas_equalTo(-RealWidth(15));
        make.bottom.mas_equalTo(_wantBtn.PenguinBtomlb.mas_bottom);
    }];
    [_PenguinContentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(RealWidth(15));
        make.top.mas_equalTo(_PenuinInfolb.mas_bottom).offset(RealWidth(10));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-RealWidth(10));
    }];
    [_PenguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(RealWidth(15));
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}
- (SDCycleScrollView *)PengunSDC{
    if (!_PengunSDC) {
        _PengunSDC = [SDCycleScrollView new];
        _PengunSDC.autoScroll = NO;
        _PengunSDC.imageURLStringsGroup = @[@"https://img1.doubanio.com/view/photo/l/public/p2236554239.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2236548371.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2236548362.jpg"];
        _PengunSDC.layer.cornerRadius = RealWidth(5);
        _PengunSDC.layer.masksToBounds = YES;
    }
    return _PengunSDC;
}
- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView = [UIImageView new];
        _PenguinThubImgView.layer.cornerRadius = RealWidth(5);
        _PenguinThubImgView.layer.masksToBounds = YES;
        [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2233706697.jpg"]];
        
    }
    return _PenguinThubImgView;
}
- (UILabel *)PenguinTitle{
    if (!_PenguinTitle) {
        _PenguinTitle = [UILabel new];
        _PenguinTitle.textColor = LGDBLackColor;
        _PenguinTitle.font = [UIFont boldSystemFontOfSize:18];
        _PenguinTitle.text = @"巴赫曼先生和他的学生";
        _PenguinTitle.numberOfLines = 0;
    }
    return _PenguinTitle;;
}
- (UIView *)PenguinStarView{
    if (!_PenguinStarView) {
        _PenguinStarView = [UIView new];
    }
    return _PenguinStarView;
}
- (WWStarView *)starView{
    if (!_starView) {
        _starView = [[WWStarView alloc]initWithFrame:_PenguinStarView.bounds numberOfStars:5 currentStar:3 rateStyle:WholeStar isAnination:YES andamptyImageName:@"xingxing-nomal" fullImageName:@"xingxing" finish:^(CGFloat currentStar) {
            
        }];
    }
    return _starView;
}
- (UILabel *)penuinSourcelb{
    if (!_penuinSourcelb) {
        _penuinSourcelb = [UILabel new];
        _penuinSourcelb.textColor = LGDMianColor;
        _penuinSourcelb.font = [UIFont boldSystemFontOfSize:12];
        _penuinSourcelb.text = @"8.6";
        _penuinSourcelb.numberOfLines = 0;
    }
    return _penuinSourcelb;;
}
- (UILabel *)PenuinRatelb{
    if (!_PenuinRatelb) {
        _PenuinRatelb = [UILabel new];
        _PenuinRatelb.textColor = LGDMianColor;
        _PenuinRatelb.backgroundColor = [UIColor colorWithHexString:@"FCB211" Alpha:0.1];
        _PenuinRatelb.font = [UIFont boldSystemFontOfSize:10];
        _PenuinRatelb.textAlignment = NSTextAlignmentCenter;
        _PenuinRatelb.text = @"90%好评";
    }
    return _PenuinRatelb;
}
- (UILabel *)PenuinInfolb{
    if (!_PenuinInfolb) {
        _PenuinInfolb = [UILabel new];
        _PenuinInfolb.textColor = LGDGaryColor;
        _PenuinInfolb.font = [UIFont boldSystemFontOfSize:12];
        _PenuinInfolb.text = @"2021/德国/纪录片/玛丽亚/Dieterr bachm2021/德国/纪录片/玛丽亚/Dieterr bachm2021/德国/纪录片/玛丽亚/Dieterr bachm2021/德国/纪录片/玛丽亚/Dieterr bachm2021/德国/纪录片/玛丽亚/Dieterr bachm";
    }
    return _PenuinInfolb;
}
- (PenguinChaseWantBtn *)wantBtn{
    if (!_wantBtn) {
        _wantBtn = [PenguinChaseWantBtn new];
        [_wantBtn addTarget:self action:@selector(PenguinChaseWantBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _wantBtn.penguinTopimgView.image = [UIImage imageNamed:@"yishoucang"];
        //yishoucang
        //xiangkan
    }
    return _wantBtn;
}
- (UILabel *)PenguinContentlb{
    if (!_PenguinContentlb) {
        _PenguinContentlb = [UILabel new];
        _PenguinContentlb.textColor = LGDLightBLackColor;
        _PenguinContentlb.font = [UIFont systemFontOfSize:12];
        _PenguinContentlb.numberOfLines = 3;
        [_PenguinContentlb setText:@"在一次原始森林的看守任务中，一位女看林人遇见了两位过着“后启示录”式蛮荒生活的生存者，一对父子。这对父子的信仰似乎自成一派，与自然的关系也微妙诡秘。看林人对这对父子的身世充满怀疑，但当他们的林中小屋在夜里被一种神秘生物袭击，她恍然发觉，在这片肆意生长的荒野，孕育着更加可怕的凶险……" lineSpacing:3];
    }
    return _PenguinContentlb;
}
- (UIView *)PenguinBtomline{
    if (!_PenguinBtomline) {
        _PenguinBtomline = [UIView new];
        _PenguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinBtomline;
}
-(void)PenguinChaseWantBtnClick{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
