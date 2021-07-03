//
//  PenguinChaseVideoDetailHeader.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseVideoDetailHeader.h"
#import "PenguinChaseVideodetailCollectionViewCell.h"
@interface PenguinChaseVideoDetailHeader ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UIImageView * penguinThubImgView;
@property(nonatomic,strong) UIImageView * penguinThubIconImgView;
@property(nonatomic,strong) UILabel     * PenguinNamelb;
@property(nonatomic,strong) UILabel     * PenguinEnglishlb;
@property(nonatomic,strong) UILabel     * PenguinTimelb;
@property(nonatomic,strong) UILabel     * PenguinTypelb;
@property(nonatomic,strong) UILabel     * PenguinMoveTimelb;
@property(nonatomic,strong) UILabel     * PenguinTopTitle;
@property(nonatomic,strong) UILabel     * PenguinDesclb;
@property(nonatomic,strong) UIView      * PenguinTopline;
@property(nonatomic,strong) UICollectionView * PenguinCollectionView;
@property(nonatomic,strong) UIView      * PenguinBtomline;
@property(nonatomic,strong) UIButton    * PenguinColltecdBtn;
@property(nonatomic,strong) UIView      * PenguinGaryView;
@property(nonatomic,strong) UILabel     * PenguinHotlb;
@end
@implementation PenguinChaseVideoDetailHeader
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.penguinThubImgView];
        [self addSubview:self.penguinThubIconImgView];
        [_penguinThubImgView addSubview:self.PenguinNamelb];
        [_penguinThubImgView addSubview:self.PenguinEnglishlb];
        
        [self addSubview:self.PenguinTimelb];
        [self addSubview:self.PenguinTypelb];
        [self addSubview:self.PenguinMoveTimelb];
        [self addSubview:self.PenguinColltecdBtn];
        
        [self addSubview:self.PenguinTopTitle];
        [self addSubview:self.PenguinDesclb];
        [self addSubview:self.PenguinTopline];
        [self addSubview:self.PenguinCollectionView];
        [self addSubview:self.PenguinGaryView];
        [self addSubview:self.PenguinHotlb];
        [_penguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img1.doubanio.com/view/photo/l/public/p2236554239.jpg"] placeholderImage:[UIImage imageNamed:@""]];
        
        
        [_penguinThubIconImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2233706697.jpg"] placeholderImage:nil];
        [_penguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(RealWidth(220));
        }];
        
        [_penguinThubIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(RealWidth(15));
            make.centerY.mas_equalTo(_penguinThubImgView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(RealWidth(100), RealWidth(140)));
        }];
        [_PenguinNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinThubIconImgView.mas_right).offset(RealWidth(10));
            make.top.mas_equalTo(_penguinThubIconImgView.mas_top);
        }];
        
        [_PenguinEnglishlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinThubIconImgView.mas_right).offset(RealWidth(10));
            make.top.mas_equalTo(_PenguinNamelb.mas_bottom).offset(RealWidth(5));
        }];
        [_PenguinTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinThubIconImgView.mas_right).offset(RealWidth(14));
            make.top.mas_equalTo(_penguinThubImgView.mas_bottom).offset(RealWidth(10));
        }];
        
        [_PenguinTypelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinThubIconImgView.mas_right).offset(RealWidth(14));
            make.top.mas_equalTo(_PenguinTimelb.mas_bottom).offset(RealWidth(5));
        }];

        [_PenguinMoveTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinThubIconImgView.mas_right).offset(RealWidth(14));
            make.top.mas_equalTo(_PenguinTypelb.mas_bottom).offset(RealWidth(5));
        }];
        [_PenguinColltecdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_PenguinTypelb.mas_centerY);
            make.right.mas_equalTo(-RealWidth(15));
            make.size.mas_equalTo(CGSizeMake(RealWidth(25), RealWidth(25)));
        }];
        [_PenguinTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_penguinThubIconImgView.mas_bottom).offset(RealWidth(15));
            make.left.right.inset(RealWidth(15));
        }];
        [_PenguinDesclb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_PenguinTopTitle.mas_bottom).offset(RealWidth(15));
            make.left.right.inset(RealWidth(15));
        }];
        [_PenguinTopline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(0);
            make.top.mas_equalTo(_PenguinDesclb.mas_bottom).offset(RealWidth(15));
            make.height.mas_equalTo(1);
        }];
        [_PenguinCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(0);
            make.top.mas_equalTo(_PenguinTopline);
            make.height.mas_equalTo(RealWidth(120));
        }];
        [_PenguinGaryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(0);
            make.top.mas_equalTo(_PenguinCollectionView.mas_bottom).offset(RealWidth(10));
            make.height.mas_equalTo(RealWidth(10));
        }];
        [_PenguinHotlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(RealWidth(15));
            make.top.mas_equalTo(_PenguinGaryView.mas_bottom).offset(RealWidth(10));
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedsLayout];
            [self layoutIfNeeded];
            [_penguinThubIconImgView viewShadowPathWithColor:LGDGaryColor shadowOpacity:0.5 shadowRadius:RealWidth(5) shadowPathType:LeShadowPathAround shadowPathWidth:RealWidth(5)];
            if (self.headerBlock) {
                self.headerBlock(CGRectGetMaxY(self->_PenguinHotlb.frame));
            }
        });
    }
    return self;
}
- (UIImageView *)penguinThubImgView{
    if (!_penguinThubImgView) {
        _penguinThubImgView = [UIImageView new];
        _penguinThubImgView.contentMode = UIViewContentModeScaleToFill;
        _penguinThubImgView.layer.masksToBounds = YES;
    }
    return _penguinThubImgView;
}
- (UIImageView *)penguinThubIconImgView{
    if (!_penguinThubIconImgView) {
        _penguinThubIconImgView = [UIImageView new];
        _penguinThubIconImgView.layer.cornerRadius = RealWidth(5);
        _penguinThubIconImgView.layer.borderColor =[UIColor whiteColor].CGColor;
        _penguinThubIconImgView.layer.borderWidth= RealWidth(2);
        _penguinThubIconImgView.layer.masksToBounds = YES;
        _penguinThubIconImgView.backgroundColor = [UIColor whiteColor];
    }
    return _penguinThubIconImgView;
}
- (UILabel *)PenguinNamelb{
    if (!_PenguinNamelb) {
        _PenguinNamelb = [UILabel new];
        _PenguinNamelb.textColor = [UIColor whiteColor];
        _PenguinNamelb.font = [UIFont boldSystemFontOfSize:25];
        _PenguinNamelb.text = @"速度与激情8";
    }
    return _PenguinNamelb;
}
- (UILabel *)PenguinEnglishlb{
    if (!_PenguinEnglishlb) {
        _PenguinEnglishlb = [UILabel new];
        _PenguinEnglishlb.textColor = [UIColor whiteColor];
        _PenguinEnglishlb.font = [UIFont systemFontOfSize:18];
        _PenguinEnglishlb.text = @"The Fate of the Fuirious";
    }
    return _PenguinEnglishlb;
}
- (UILabel *)PenguinTimelb{
    if (!_PenguinTimelb) {
        _PenguinTimelb = [UILabel new];
        _PenguinTimelb.textColor = LGDGaryColor;
        _PenguinTimelb.font = [UIFont systemFontOfSize:13];
        _PenguinTimelb.text = @"2小时16分钟";
    }
    return _PenguinTimelb;
}
- (UILabel *)PenguinTypelb{
    if (!_PenguinTypelb) {
        _PenguinTypelb = [UILabel new];
        _PenguinTypelb.textColor = LGDGaryColor;
        _PenguinTypelb.font = [UIFont systemFontOfSize:13];
        _PenguinTypelb.text = @"惊悚 ｜ 动作 ｜ 犯罪";
    }
    return _PenguinTypelb;
}
- (UILabel *)PenguinMoveTimelb{
    if (!_PenguinMoveTimelb) {
        _PenguinMoveTimelb = [UILabel new];
        _PenguinMoveTimelb.textColor = LGDGaryColor;
        _PenguinMoveTimelb.font = [UIFont systemFontOfSize:13];
        _PenguinMoveTimelb.text = @"2017-04-14上映";
    }
    return _PenguinMoveTimelb;
}
- (UILabel *)PenguinTopTitle{
    if (!_PenguinTopTitle) {
        _PenguinTopTitle = [UILabel new];
        _PenguinTopTitle.textAlignment = NSTextAlignmentCenter;
        _PenguinTopTitle.numberOfLines = 0;
        _PenguinTopTitle.textColor = LGDLightBLackColor;
        _PenguinTopTitle.font = [UIFont boldSystemFontOfSize:18];
        _PenguinTopTitle.text = @"硬汉豪车再纵横，依旧燃爆荷尔蒙";
    }
    return _PenguinTopTitle;
}
- (UILabel *)PenguinDesclb{
    if (!_PenguinDesclb) {
        _PenguinDesclb = [UILabel new];
        _PenguinDesclb.textAlignment = NSTextAlignmentCenter;
        _PenguinDesclb.numberOfLines = 0;
        _PenguinDesclb.textColor = LGDGaryColor;
        _PenguinDesclb.font = [UIFont boldSystemFontOfSize:13];
        [_PenguinDesclb setText:@"硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙硬汉豪车再纵横，依旧燃爆荷尔蒙" lineSpacing:RealWidth(4)];
    }
    return _PenguinDesclb;
}
- (UIView *)PenguinTopline{
    if (!_PenguinTopline) {
        _PenguinTopline = [UIView new];
        _PenguinTopline.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinTopline;
}
- (UIButton *)PenguinColltecdBtn{
    if (!_PenguinColltecdBtn) {
        _PenguinColltecdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_PenguinColltecdBtn setBackgroundColor:LGDMianColor];
        [_PenguinColltecdBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_PenguinColltecdBtn addTarget:self action:@selector(PenguinColltecdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinColltecdBtn;
}
- (UIView *)PenguinGaryView{
    if (!_PenguinGaryView) {
        _PenguinGaryView = [UIView new];
        _PenguinGaryView.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinGaryView;
}
- (UILabel *)PenguinHotlb{
    if (!_PenguinHotlb) {
        _PenguinHotlb = [UILabel new];
        _PenguinHotlb.textColor = LGDLightBLackColor;
        _PenguinHotlb.font = [UIFont boldSystemFontOfSize:18];
        _PenguinHotlb.text = @"热门评论🔥";
    }
    return _PenguinHotlb;
}
#pragma mar--收藏
-(void)PenguinColltecdBtnClick{
    
}
- (UICollectionView *)PenguinCollectionView{
    if (!_PenguinCollectionView) {
        UICollectionViewFlowLayout * penguinLayout =[[UICollectionViewFlowLayout alloc]init];
        penguinLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        penguinLayout.itemSize =  CGSizeMake(RealWidth(100), RealWidth(120));
        _PenguinCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:penguinLayout];
        _PenguinCollectionView.delegate  = self;
        _PenguinCollectionView.dataSource = self;
        _PenguinCollectionView.showsVerticalScrollIndicator = NO;
        _PenguinCollectionView.showsHorizontalScrollIndicator = NO;
        _PenguinCollectionView.backgroundColor = [UIColor whiteColor];
        [_PenguinCollectionView registerClass:[PenguinChaseVideodetailCollectionViewCell class] forCellWithReuseIdentifier:@"PenguinChaseVideodetailCollectionViewCell"];
    }
    return _PenguinCollectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseVideodetailCollectionViewCell * penguinCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PenguinChaseVideodetailCollectionViewCell" forIndexPath:indexPath];
    return penguinCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
