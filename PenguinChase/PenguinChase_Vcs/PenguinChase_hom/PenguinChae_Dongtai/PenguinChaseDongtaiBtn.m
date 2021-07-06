//
//  PenguinChaseDongtaiBtn.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseDongtaiBtn.h"

@implementation PenguinChaseDongtaiBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self addSubview:self.penguinLeftImgView];
        [self addSubview:self.penguinRightlb];
        [_penguinLeftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(RealWidth(18), RealWidth(18)));
        }];
        [_penguinRightlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_penguinLeftImgView.mas_right).offset(RealWidth(0));
            make.centerY.mas_equalTo(_penguinLeftImgView.mas_centerY).offset(RealWidth(1));
            make.right.mas_equalTo(self.mas_right);
        }];
    }
    return self;
}
- (UIImageView *)penguinLeftImgView{
    if (!_penguinLeftImgView) {
        _penguinLeftImgView = [UIImageView new];
    }
    return _penguinLeftImgView;
}
-(UILabel *)penguinRightlb{
    if (!_penguinRightlb) {
        _penguinRightlb = [UILabel new];
        _penguinRightlb.textColor = [UIColor colorWithHexString:@"cdcdcd"];
        _penguinRightlb.font = [UIFont boldSystemFontOfSize:12];
        _penguinRightlb.text = @"举报";
    }
    return _penguinRightlb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
