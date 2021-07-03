//
//  PenguinChaseVideodetailCollectionViewCell.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseVideodetailCollectionViewCell.h"
@interface PenguinChaseVideodetailCollectionViewCell ()
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) UILabel     * PenguinBtomlb;
@end
@implementation PenguinChaseVideodetailCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self addSubview:self.PenguinThubImgView];
        [self addSubview:self.PenguinBtomlb];
        [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(RealWidth(70), RealWidth(100)));
            make.centerX.top.mas_equalTo(self.contentView);
        }];
        [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://img9.doubanio.com/view/celebrity/raw/public/p31956.jpg"]];
        [_PenguinBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(_PenguinThubImgView.mas_bottom).offset(RealWidth(5));
        }];
    }
    return self;
}
- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView = [UIImageView new];
        _PenguinThubImgView.backgroundColor = LGDMianColor;
    }
    return _PenguinThubImgView;
}
- (UILabel *)PenguinBtomlb{
    if (!_PenguinBtomlb) {
        _PenguinBtomlb =[UILabel new];
        _PenguinBtomlb.textAlignment = NSTextAlignmentCenter;
        _PenguinBtomlb.textColor =  LGDLightBLackColor;
        _PenguinBtomlb.font = [UIFont boldSystemFontOfSize:12];
        _PenguinBtomlb.text  =@"范迪塞尔";
    }
    return _PenguinBtomlb;
}
@end
