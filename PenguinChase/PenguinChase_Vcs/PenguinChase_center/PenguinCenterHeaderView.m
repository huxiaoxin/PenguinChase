//
//  PenguinCenterHeaderView.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinCenterHeaderView.h"
#import "PenguinCenterBtn.h"
@interface PenguinCenterHeaderView ()
@property(nonatomic,strong) UIImageView * penguinBackImgView;
@property(nonatomic,strong) UIImageView * PenguinuserimgView;
@property(nonatomic,strong) UILabel     * PenguinNamelb;
@property(nonatomic,strong) UIView      * PenguinContentView;
@property(nonatomic,strong)PenguinCenterBtn  * MyFolwwbtn;
@property(nonatomic,strong)PenguinCenterBtn  * MyWatchBtn;
@property(nonatomic,strong)PenguinCenterBtn  * MySendbtn;
@property(nonatomic,strong)PenguinCenterBtn  * MyColltecdbtn;

@end
@implementation PenguinCenterHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.penguinBackImgView];
        [_penguinBackImgView addSubview:self.PenguinuserimgView];
        [_penguinBackImgView addSubview:self.PenguinNamelb];
        [_penguinBackImgView addSubview:self.PenguinContentView];
        
        [_PenguinContentView addSubview:self.MyFolwwbtn];
        [_PenguinContentView addSubview:self.MyWatchBtn];
        [_PenguinContentView addSubview:self.MySendbtn];
        [_PenguinContentView addSubview:self.MyColltecdbtn];

        
        [_penguinBackImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(GK_STATUSBAR_HEIGHT + RealWidth(150));
        }];
        [_PenguinuserimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_penguinBackImgView);
            make.centerY.mas_equalTo(_penguinBackImgView);
            make.size.mas_equalTo(CGSizeMake( RealWidth(50), RealWidth(50)));
        }];
        
        [_PenguinNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_PenguinuserimgView);
            make.top.mas_equalTo(_PenguinuserimgView.mas_bottom).offset(RealWidth(8));
        }];
        
        [_PenguinContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_penguinBackImgView.mas_bottom);
            make.left.right.inset(RealWidth(20));
            make.height.mas_equalTo(RealWidth(60));
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedsLayout];
            [self layoutIfNeeded];
            [self->_PenguinContentView viewShadowPathWithColor:LGDGaryColor shadowOpacity:0.5 shadowRadius:RealWidth(5) shadowPathType:LeShadowPathAround shadowPathWidth:RealWidth(5)];
            //我的关注 我的浏览 我的发布 我的收藏
            
            [_MyFolwwbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(_PenguinContentView);
                make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(_PenguinContentView.frame)/4, CGRectGetHeight(_PenguinContentView.frame)));
                  
            }];
            
            [_MyWatchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_PenguinContentView);
                make.left.mas_equalTo(_MyFolwwbtn.mas_right);
                make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(_PenguinContentView.frame)/4, CGRectGetHeight(_PenguinContentView.frame)));
                  
            }];
            
            [_MySendbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_PenguinContentView);
                make.left.mas_equalTo(_MyWatchBtn.mas_right);
                make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(_PenguinContentView.frame)/4, CGRectGetHeight(_PenguinContentView.frame)));
                  
            }];
            
            [_MyColltecdbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_PenguinContentView);
                make.left.mas_equalTo(_MySendbtn.mas_right);
                make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(_PenguinContentView.frame)/4, CGRectGetHeight(_PenguinContentView.frame)));
                  
            }];

        });
    
        
        
        
 
        
    }
    return self;
}
- (PenguinCenterBtn *)MyFolwwbtn{
    if (!_MyFolwwbtn) {
        _MyFolwwbtn = [PenguinCenterBtn new];
        _MyFolwwbtn.PenguinToplb.text = @"12";
        _MyFolwwbtn.PenguinBtomlb.text  =@"我的关注";
        _MyFolwwbtn.tag = 0;
        [_MyFolwwbtn addTarget:self action:@selector(PenguinCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MyFolwwbtn;
}
- (PenguinCenterBtn *)MyWatchBtn{
    if (!_MyWatchBtn) {
        _MyWatchBtn = [PenguinCenterBtn new];
        _MyWatchBtn.PenguinToplb.text = @"12";
        _MyWatchBtn.PenguinBtomlb.text  =@"我的浏览";
        _MyWatchBtn.tag = 1;
        [_MyWatchBtn addTarget:self action:@selector(PenguinCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MyWatchBtn;
}

- (PenguinCenterBtn *)MySendbtn{
    if (!_MySendbtn) {
        _MySendbtn = [PenguinCenterBtn new];
        _MySendbtn.PenguinToplb.text = @"0";
        _MySendbtn.PenguinBtomlb.text  =@"我的发布";
        _MySendbtn.tag = 2;
        [_MySendbtn addTarget:self action:@selector(PenguinCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MySendbtn;
}
- (PenguinCenterBtn *)MyColltecdbtn{
    if (!_MyColltecdbtn) {
        _MyColltecdbtn = [PenguinCenterBtn new];
        _MyColltecdbtn.PenguinToplb.text = @"0";
        _MyColltecdbtn.PenguinBtomlb.text  =@"我的收藏";
        _MyColltecdbtn.tag = 3;
        [_MyColltecdbtn addTarget:self action:@selector(PenguinCenterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MyColltecdbtn;
}
-(void)PenguinCenterBtnClick:(PenguinCenterBtn* )centerBtn{
    [self.delegate PenguinCenterHeaderViewWithBtnClickIndex:centerBtn.tag];
}
- (UIImageView *)PenguinuserimgView{
    if (!_PenguinuserimgView) {
        _PenguinuserimgView = [UIImageView new];
        _PenguinuserimgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _PenguinuserimgView.layer.borderWidth = RealWidth(2);
        _PenguinuserimgView.layer.cornerRadius = RealWidth(25);
        _PenguinuserimgView.layer.masksToBounds = YES;
        _PenguinuserimgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * PenguinTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PenguinuserimgViewInfoTap)];
        [_PenguinuserimgView addGestureRecognizer:PenguinTap];
    }
    return _PenguinuserimgView;
}
- (UIImageView *)penguinBackImgView{
    if (!_penguinBackImgView) {
        _penguinBackImgView = [UIImageView new];
        _penguinBackImgView.image = [UIImage imageNamed:@"centerback"];
    }
    return _penguinBackImgView;
}
- (UILabel *)PenguinNamelb{
    if (!_PenguinNamelb) {
        _PenguinNamelb = [UILabel new];
        _PenguinNamelb.textAlignment = NSTextAlignmentCenter;
        _PenguinNamelb.textColor = [UIColor whiteColor];
        _PenguinNamelb.font = [UIFont boldSystemFontOfSize:15];
        _PenguinNamelb.text = @"阿三的小蝴蝶";
    }
    return _PenguinNamelb;
}
- (UIView *)PenguinContentView{
    if (!_PenguinContentView) {
        _PenguinContentView = [UIView new];
        _PenguinContentView.layer.cornerRadius = RealWidth(5);
//        _PenguinContentView.layer.masksToBounds = YES;
        [_PenguinContentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _PenguinContentView;
}
-(void)PenguinuserimgViewInfoTap{
    [self.delegate PenguinCenterHeaderViewWithInfoAcion];
}
//beijingtuda
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
