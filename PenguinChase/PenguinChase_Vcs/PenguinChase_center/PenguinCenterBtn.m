//
//  PenguinCenterBtn.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinCenterBtn.h"

@implementation PenguinCenterBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.PenguinToplb];
        [self addSubview:self.PenguinBtomlb];
        [_PenguinToplb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(RealWidth(12));
        }];
        [_PenguinBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_PenguinToplb.mas_bottom).offset(RealWidth(5));
        }];
    }
    return self;
}
- (UILabel *)PenguinToplb{
    if (!_PenguinToplb) {
        _PenguinToplb  = [UILabel new];
        _PenguinToplb.textColor = LGDBLackColor;
        _PenguinToplb.font = [UIFont boldSystemFontOfSize:15];
    }
    return _PenguinToplb;
}
- (UILabel *)PenguinBtomlb{
    if (!_PenguinBtomlb) {
        _PenguinBtomlb  = [UILabel new];
        _PenguinBtomlb.textColor = LGDGaryColor;
        _PenguinBtomlb.font = [UIFont systemFontOfSize:12];
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
