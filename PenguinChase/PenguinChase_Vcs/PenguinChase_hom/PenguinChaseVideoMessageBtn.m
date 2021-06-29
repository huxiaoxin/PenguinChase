
#import "PenguinChaseVideoMessageBtn.h"
@interface PenguinChaseVideoMessageBtn  ()

@end
@implementation PenguinChaseVideoMessageBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.PenguinChase_ContentView];
        [_PenguinChase_ContentView addSubview:self.PenguinChase_ImgView];
        [self addSubview:self.PenguinChaseBtomlb];

        [_PenguinChase_ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(RealWidth(40), RealWidth(40)));
        }];
        [_PenguinChase_ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(8), RealWidth(8), RealWidth(8), RealWidth(8)));
        }];
        [_PenguinChaseBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_PenguinChase_ContentView.mas_bottom).offset(RealWidth(5));
        }];
        
    }
    return self;
}
- (UIView *)PenguinChase_ContentView{
    if (!_PenguinChase_ContentView) {
        _PenguinChase_ContentView = [UIView new];
        _PenguinChase_ContentView.backgroundColor = [UIColor redColor];
        _PenguinChase_ContentView.layer.cornerRadius = RealWidth(20);
        _PenguinChase_ContentView.layer.masksToBounds = YES;
        _PenguinChase_ContentView.userInteractionEnabled = NO;
    }
    return _PenguinChase_ContentView;
}
- (UIImageView *)PenguinChase_ImgView{
    if (!_PenguinChase_ImgView) {
        _PenguinChase_ImgView = [UIImageView new];
        _PenguinChase_ImgView.userInteractionEnabled = YES;
    }
    return _PenguinChase_ImgView;
}
- (UILabel *)PenguinChaseBtomlb{
    if (!_PenguinChaseBtomlb) {
        _PenguinChaseBtomlb = [UILabel new];
        _PenguinChaseBtomlb.textAlignment = NSTextAlignmentCenter;
        _PenguinChaseBtomlb.textColor = LGDBLackColor;
        _PenguinChaseBtomlb.font = [UIFont systemFontOfSize:12];
    }
    return _PenguinChaseBtomlb;
}
@end
