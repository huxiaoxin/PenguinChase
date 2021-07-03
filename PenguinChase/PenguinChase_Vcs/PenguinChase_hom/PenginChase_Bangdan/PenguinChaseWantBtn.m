//
//  PenguinChaseWantBtn.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseWantBtn.h"
@interface PenguinChaseWantBtn ()
@end
@implementation PenguinChaseWantBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self  =[super initWithFrame:frame]) {
        [self  addSubview:self.penguinTopimgView];
        [self addSubview:self.PenguinBtomlb];
        
        [_penguinTopimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(RealWidth(20), RealWidth(20)));
        }];
        [_PenguinBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_penguinTopimgView.mas_bottom).offset(RealWidth(2));
        }];
    }
    return self;
}
- (UIImageView *)penguinTopimgView{
    if (!_penguinTopimgView) {
        _penguinTopimgView = [UIImageView new];
//        _penguinTopimgView.backgroundColor = LGDMianColor;
    }
    return _penguinTopimgView;
}
- (UILabel *)PenguinBtomlb{
    if (!_PenguinBtomlb) {
        _PenguinBtomlb = [UILabel new];
        _PenguinBtomlb.textColor = LGDMianColor;
        _PenguinBtomlb.font  =[UIFont boldSystemFontOfSize:13];
        _PenguinBtomlb.text = @"想看";
    }
    return _PenguinBtomlb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
