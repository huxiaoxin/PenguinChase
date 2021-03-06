//
//  PenguinChaseHomeTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseHomeTableViewCell.h"
@interface PenguinChaseHomeTableViewCell ()
@property(nonatomic,strong) UIView * PenguinChase_contentView;
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) UILabel     * PenguinTopTitle;
@property(nonatomic,strong) UILabel     * PenguinChaseMainArtistlb;
@property(nonatomic,strong) UILabel     * PenguinChaseWantNumlb;
@property(nonatomic,strong) UILabel     * PenguinTimelb;
@property(nonatomic,strong) UIButton    * watchBtn;
@end
@implementation PenguinChaseHomeTableViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.PenguinChase_contentView];
    [_PenguinChase_contentView addSubview:self.PenguinThubImgView];
    [_PenguinChase_contentView addSubview:self.PenguinTopTitle];
    [_PenguinChase_contentView addSubview:self.PenguinChaseMainArtistlb];
    [_PenguinChase_contentView addSubview:self.PenguinChaseWantNumlb];
    [_PenguinChase_contentView addSubview:self.PenguinTimelb];
    [_PenguinChase_contentView addSubview:self.watchBtn];
    
    [_PenguinChase_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(5), RealWidth(10), RealWidth(5), RealWidth(10)));
    }];
    
    [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.inset(RealWidth(10));
        make.size.mas_equalTo(CGSizeMake(RealWidth(70), RealWidth(90)));
    }];
    

    
    [_PenguinTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(10));
        make.top.mas_equalTo(_PenguinThubImgView.mas_top).offset(RealWidth(5));
        make.right.mas_equalTo(_PenguinChase_contentView.mas_right).offset(-RealWidth(5));
    }];
    [_PenguinChaseMainArtistlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(10));
        make.top.mas_equalTo(_PenguinTopTitle.mas_bottom).offset(RealWidth(5));
        make.right.mas_equalTo(_PenguinChase_contentView.mas_right).offset(-RealWidth(5));
    }];
    [_PenguinChaseWantNumlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(10));
        make.top.mas_equalTo(_PenguinChaseMainArtistlb.mas_bottom).offset(RealWidth(5));
        make.right.mas_equalTo(_watchBtn.mas_left).offset(-RealWidth(10));
    }];
    
    [_PenguinTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinThubImgView.mas_right).offset(RealWidth(10));
        make.top.mas_equalTo(_PenguinChaseWantNumlb.mas_bottom).offset(RealWidth(5));
        make.right.mas_equalTo(_PenguinChase_contentView.mas_right).offset(-RealWidth(5));
    }];
    
    [_watchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.bottom.mas_equalTo(-RealWidth(15));
        make.size.mas_equalTo(CGSizeMake(RealWidth(50), RealWidth(24)));
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self->_PenguinChase_contentView viewShadowPathWithColor:LGDGaryColor shadowOpacity:0.2 shadowRadius:RealWidth(5) shadowPathType:LeShadowPathAround shadowPathWidth:RealWidth(4)];
    });


}
- (UIView *)PenguinChase_contentView{
    if (!_PenguinChase_contentView) {
        _PenguinChase_contentView = [UIView new];
        _PenguinChase_contentView.backgroundColor = [UIColor whiteColor];
        _PenguinChase_contentView.layer.cornerRadius = RealWidth(5);
    }
    return _PenguinChase_contentView;
}
- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView = [UIImageView new];
        _PenguinThubImgView.layer.cornerRadius = RealWidth(5);
        _PenguinThubImgView.layer.masksToBounds = YES;
        _PenguinThubImgView.contentMode =  UIViewContentModeScaleAspectFill;
        [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2F365jia.cn%2Fuploads%2Fnews%2Ffolder_1297539%2Fimages%2F1%28598%29.jpg&refer=http%3A%2F%2F365jia.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627538320&t=ae778af7e41a758b868cba6d5101f259"] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    }
    return _PenguinThubImgView;
}
- (UILabel *)PenguinTopTitle{
    if (!_PenguinTopTitle) {
        _PenguinTopTitle = [UILabel new];
        _PenguinTopTitle.textColor = LGDBLackColor;
        _PenguinTopTitle.font = [UIFont boldSystemFontOfSize:15];
        _PenguinTopTitle.text = @"?????????:????????????";
    }
    return _PenguinTopTitle;
}
- (UILabel *)PenguinChaseMainArtistlb{
    if (!_PenguinChaseMainArtistlb) {
        _PenguinChaseMainArtistlb = [UILabel new];
        _PenguinChaseMainArtistlb.textColor = LGDLightBLackColor;
        _PenguinChaseMainArtistlb.font = [UIFont systemFontOfSize:12];
        _PenguinChaseMainArtistlb.text = @"??????:?????????????????????????????????";
    }
    return _PenguinChaseMainArtistlb;
}
- (UILabel *)PenguinTimelb{
    if (!_PenguinTimelb) {
        _PenguinTimelb = [UILabel new];
        _PenguinTimelb.textColor = LGDLightBLackColor;
        _PenguinTimelb.font = [UIFont systemFontOfSize:12];
        _PenguinTimelb.text = @"2021-11-02????????????";
    }
    return _PenguinTimelb;
}
- (UILabel *)PenguinChaseWantNumlb{
    if (!_PenguinChaseWantNumlb) {
        _PenguinChaseWantNumlb = [UILabel new];
        _PenguinChaseWantNumlb.textColor = LGDLightBLackColor;
        _PenguinChaseWantNumlb.font = [UIFont systemFontOfSize:12];
       
    }
    return _PenguinChaseWantNumlb;
}
- (UIButton *)watchBtn{
    if (!_watchBtn) {
        _watchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_watchBtn setTitle:@"??????" forState:UIControlStateNormal];
        _watchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _watchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_watchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_watchBtn addTarget:self action:@selector(watchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_watchBtn setBackgroundColor:LGDMianColor];
        _watchBtn.layer.cornerRadius = RealWidth(12);
        _watchBtn.layer.masksToBounds = YES;
    }
    return _watchBtn;
}
-(void)watchBtnClick{
    [self.delegate PenguinChaseHomeTableViewCellWithWantbtnAction:self.tag];
}
- (void)setPenguinModel:(PenguinChaseVideoModel *)penguinModel{
    _penguinModel = penguinModel;
    [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:penguinModel.penguinChase_MoviewIocnurl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    _PenguinTopTitle.text =  penguinModel.penguinChase_MoviewTitle;
    NSMutableArray * tempArr = [NSMutableArray array];
    for (NSDictionary * parmtwrDic in penguinModel.penguinChase_MoviewArtistArr) {
        NSString * ArtiText  = [parmtwrDic objectForKey:@"title"];
        [tempArr addObject:ArtiText];
    }
    _PenguinChaseMainArtistlb.text =  [tempArr componentsJoinedByString:@"|"];
    _PenguinTimelb.text = penguinModel.penguinChase_MoviewTime;
    NSString * peopleNums = [NSString stringWithFormat:@"%ld",(long)penguinModel.WantNums];
    NSString * peopleWatch =  @"?????????";
    NSMutableAttributedString * mutableAttbute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",peopleNums,peopleWatch]];
    [mutableAttbute addAttribute:NSForegroundColorAttributeName value:LGDRedColor range:NSMakeRange(0, peopleNums.length)];
    [mutableAttbute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, peopleNums.length)];

    [mutableAttbute addAttribute:NSForegroundColorAttributeName value:LGDLightBLackColor range:NSMakeRange(peopleNums.length, peopleWatch.length)];
    [mutableAttbute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(peopleNums.length, peopleWatch.length)];

    _PenguinChaseWantNumlb.attributedText = mutableAttbute;
    
    if ([FilmFactoryAccountComponent checkLogin:NO]) {
        [_watchBtn setBackgroundColor:penguinModel.penguinChase_isColltecd ? LGDGaryColor : LGDMianColor ];
        [_watchBtn setTitle:penguinModel.penguinChase_isColltecd ? @"??????" :@"??????" forState:UIControlStateNormal];
    }else{
        [_watchBtn setTitle:@"??????" forState:UIControlStateNormal];
        [_watchBtn setBackgroundColor:LGDMianColor];
    }
    
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
