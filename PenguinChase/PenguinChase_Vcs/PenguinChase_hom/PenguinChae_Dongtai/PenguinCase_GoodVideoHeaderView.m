//
//  PenguinCase_GoodVideoHeaderView.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinCase_GoodVideoHeaderView.h"
@interface PenguinCase_GoodVideoHeaderView ()
@property(nonatomic,strong) UIImageView * penguinBackImgView;
@property(nonatomic,strong) UILabel     * PenguinWendulb;
@property(nonatomic,strong) UILabel     * PenguinLocationlb;
@property(nonatomic,strong) UILabel     * PenguinRililb;
@property(nonatomic,strong) UIView      * PenguinBtomView;
@property(nonatomic,strong) UILabel     * PenguinHotlb;

@end
@implementation PenguinCase_GoodVideoHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.penguinBackImgView];
        [_penguinBackImgView addSubview:self.PenguinWendulb];
        [_penguinBackImgView addSubview:self.PenguinLocationlb];
        [_penguinBackImgView addSubview:self.PenguinRililb];
        [self addSubview:self.PenguinBtomView];
        [_PenguinBtomView addSubview:self.PenguinHotlb];
        [_penguinBackImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, RealWidth(30), 0));
        }];
        [_PenguinWendulb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(RealWidth(30));
            make.top.mas_equalTo(RealWidth(85));
            make.size.mas_equalTo(CGSizeMake(RealWidth(70), RealWidth(40)));
        }];
        
        [_PenguinLocationlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_PenguinWendulb.mas_right).offset(RealWidth(30));
            make.top.mas_equalTo(_PenguinWendulb.mas_top).offset(RealWidth(4));
        }];
        [_PenguinRililb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_PenguinWendulb.mas_right).offset(RealWidth(30));
            make.top.mas_equalTo(_PenguinLocationlb.mas_top).offset(RealWidth(20));
            
        }];
        
        [_PenguinBtomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_penguinBackImgView.mas_bottom);
            make.left.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(GK_SCREEN_WIDTH, RealWidth(30)));
        }];
        
        [_PenguinHotlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(RealWidth(5), RealWidth(15), RealWidth(5), RealWidth(15)));
        }];
        
    }
    return self;
}
- (UIView *)PenguinBtomView{
    if (!_PenguinBtomView) {
        _PenguinBtomView = [UIView new];
        _PenguinBtomView.backgroundColor = [UIColor whiteColor];
        [_PenguinBtomView acs_radiusWithRadius:RealWidth(15) corner:UIRectCornerTopLeft | UIRectCornerTopRight];
    }
    return _PenguinBtomView;
}
- (UILabel *)PenguinWendulb{
    if (!_PenguinWendulb) {
        _PenguinWendulb = [UILabel new];
        _PenguinWendulb.textColor = [UIColor whiteColor];
        _PenguinWendulb.font = [UIFont boldSystemFontOfSize:40];
        _PenguinWendulb.text = @"24";
        _PenguinWendulb.textAlignment = NSTextAlignmentRight;
//        _PenguinWendulb.backgroundColor = LGDMianColor;
    }
    return _PenguinWendulb;
}
- (UILabel *)PenguinLocationlb{
    if (!_PenguinLocationlb) {
        _PenguinLocationlb = [UILabel new];
        _PenguinLocationlb.textColor = [UIColor whiteColor];
        _PenguinLocationlb.font = [UIFont boldSystemFontOfSize:12];
        _PenguinLocationlb.text = @"24";
//        _PenguinLocationlb.textAlignment = NSTextAlignmentRight;
        //
        
        
        NSTextAttachment * texteMent = [[NSTextAttachment alloc]init];
        texteMent.image =[UIImage imageNamed:@"weizhi"];
        texteMent.bounds = CGRectMake(0, -RealWidth(2), RealWidth(10), RealWidth(10));
        NSAttributedString * attbute = [NSAttributedString attributedStringWithAttachment:texteMent];
        NSMutableAttributedString * PenguinAttbute =[[NSMutableAttributedString alloc]initWithString:@"合肥市 "];
        [PenguinAttbute insertAttributedString:attbute atIndex:3];
        _PenguinLocationlb.attributedText = PenguinAttbute;
        
    }
    
    
    return _PenguinLocationlb;
}
- (UIImageView *)penguinBackImgView{
    if (!_penguinBackImgView) {
        _penguinBackImgView = [UIImageView new];
        _penguinBackImgView.image = [UIImage imageNamed:@"sunday"];
    }
    return _penguinBackImgView;
}
- (UILabel *)PenguinRililb{
    if (!_PenguinRililb) {
        _PenguinRililb = [UILabel new];
        _PenguinRililb.textColor = [UIColor whiteColor];
        _PenguinRililb.font = [UIFont systemFontOfSize:14];
        _PenguinRililb.text = @"11/20 ℃ 晴天";
        _PenguinRililb.textAlignment = NSTextAlignmentRight;
    }
    return _PenguinRililb;
}
- (UILabel *)PenguinHotlb{
    if (!_PenguinHotlb) {
        _PenguinHotlb = [UILabel new];
        _PenguinHotlb.textColor = [UIColor blackColor];
        _PenguinHotlb.font = [UIFont  boldSystemFontOfSize:15];
        NSString * PenguinFirstText = @"每日推荐 ";
        NSString * PenguinSecondText = @"每日一帖，记录美好瞬间";
        NSMutableAttributedString * PenguinAttbute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",PenguinFirstText,PenguinSecondText]];
        [PenguinAttbute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, PenguinFirstText.length)];
        [PenguinAttbute addAttribute:NSForegroundColorAttributeName value:LGDBLackColor range:NSMakeRange(0, PenguinFirstText.length)];

        [PenguinAttbute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(PenguinFirstText.length, PenguinSecondText.length)];
        [PenguinAttbute addAttribute:NSForegroundColorAttributeName value:LGDGaryColor range:NSMakeRange(PenguinFirstText.length, PenguinSecondText.length)];

        _PenguinHotlb.attributedText = PenguinAttbute;
        
    }
    return _PenguinHotlb;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
