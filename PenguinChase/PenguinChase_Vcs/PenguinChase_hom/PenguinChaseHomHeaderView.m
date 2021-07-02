//
//  PenguinChaseHomHeaderView.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseHomHeaderView.h"
#import <SDCycleScrollView.h>
#import "PenguinChaseVideoMessageBtn.h"
@interface PenguinChaseHomHeaderView ()
@property(nonatomic,strong) PenguinClanderView * pengClandeView;
@property(nonatomic,strong) UIView             * PenguinSearchingView;
@property(nonatomic,strong) UIImageView        * PenguinSeachiIocnImgView;
@property(nonatomic,strong) SDCycleScrollView  * PenguinSDCView;
@property(nonatomic,strong) PenguinChaseVideoMessageBtn * PenguinBtn;
@end

@interface PenguinClanderView ()

@end

@implementation PenguinClanderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.PenguinThubImgView];
        [_PenguinThubImgView addSubview:self.PenguinGaryView];
        [_PenguinThubImgView addSubview:self.PenguinToplb];
        [_PenguinThubImgView addSubview:self.PenguinBtomlb];
        [_PenguinThubImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_PenguinGaryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_PenguinThubImgView);
        }];
        [_PenguinToplb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_PenguinThubImgView);
            make.top.mas_equalTo(RealWidth(12));
        }];
        [_PenguinBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_PenguinThubImgView);
            make.centerY.mas_equalTo(_PenguinThubImgView.mas_centerY).offset(RealWidth(10));
        }];
    }
    return self;
}
- (UIImageView *)PenguinThubImgView{
    if (!_PenguinThubImgView) {
        _PenguinThubImgView  =[UIImageView new];
        _PenguinThubImgView.userInteractionEnabled = YES;
        _PenguinThubImgView.layer.cornerRadius =RealWidth(5);
        _PenguinThubImgView.layer.masksToBounds = YES;
        _PenguinThubImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_PenguinThubImgView sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201602%2F04%2F20160204211607_4hnsj.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627522742&t=41829591a1b657af9c89fda069131105"]];
    }
    return _PenguinThubImgView;
}
- (UIView *)PenguinGaryView{
    if (!_PenguinGaryView) {
        _PenguinGaryView = [UIView new];
        _PenguinGaryView.backgroundColor = [UIColor colorWithHexString:@"2c2c2c" Alpha:0.7];
    }
    return _PenguinGaryView;
}
- (UILabel *)PenguinToplb{
    if (!_PenguinToplb) {
        _PenguinToplb = [UILabel new];
        _PenguinToplb.font = [UIFont systemFontOfSize:16];
        _PenguinToplb.textColor = [UIColor whiteColor];
        _PenguinToplb.text = @"Today";
        _PenguinToplb.textAlignment = NSTextAlignmentCenter;
    }
    return _PenguinToplb;
}
- (UILabel *)PenguinBtomlb{
    if (!_PenguinBtomlb) {
        _PenguinBtomlb = [UILabel new];
        _PenguinBtomlb.font = [UIFont boldSystemFontOfSize:40];
        _PenguinBtomlb.textColor = [UIColor whiteColor];
        _PenguinBtomlb.text = @"25";
        _PenguinBtomlb.textAlignment = NSTextAlignmentCenter;
    }
    return _PenguinBtomlb;
}
@end
@implementation PenguinChaseHomHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pengClandeView];
        [self addSubview:self.PenguinSearchingView];
        [_PenguinSearchingView addSubview:self.PenguinSeachiIocnImgView];
        [self addSubview:self.PenguinSDCView];
        [_pengClandeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.inset(RealWidth(15));
            make.size.mas_equalTo(CGSizeMake(RealWidth(80), RealWidth(100)));
        }];
        [_PenguinSearchingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.inset(RealWidth(15));
            make.top.mas_equalTo(_pengClandeView.mas_bottom).offset(RealWidth(10));
            make.size.mas_equalTo(CGSizeMake(RealWidth(80), RealWidth(30)));
        }];
        [_PenguinSeachiIocnImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_PenguinSearchingView);
            make.size.mas_equalTo(CGSizeMake(RealWidth(14), RealWidth(14)));
        }];
        [_PenguinSDCView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_pengClandeView.mas_right).offset(RealWidth(15));
            make.right.mas_equalTo(-RealWidth(15));
            make.top.mas_equalTo(RealWidth(15));
            make.bottom.mas_equalTo(_PenguinSearchingView.mas_bottom);
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        NSArray * PenguinTitleArr = @[@"热门榜单",@"甄选好片",@"影视资讯",@"在线客服"];
        NSArray * PenguinColorArr = @[@"",@"",@"",@""];
        for (int index = 0; index < PenguinTitleArr.count; index++) {
            PenguinChaseVideoMessageBtn * PenguinBtn = [[PenguinChaseVideoMessageBtn alloc]initWithFrame:CGRectMake(GK_SCREEN_WIDTH/PenguinTitleArr.count*index, CGRectGetMaxY(_PenguinSDCView.frame)+RealWidth(15), GK_SCREEN_WIDTH/PenguinTitleArr.count, RealWidth(60))];
            PenguinBtn.tag = index;
            PenguinBtn.PenguinChase_ImgView.backgroundColor = LGDMianColor;
            [PenguinBtn addTarget:self action:@selector(PenguinChaseVideoMessageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            PenguinBtn.PenguinChaseBtomlb.text = PenguinTitleArr[index];
            PenguinBtn.PenguinChase_ContentView.backgroundColor = [UIColor colorWithHexString:PenguinColorArr[index]];
            PenguinBtn.PenguinChase_ImgView.image = [UIImage imageNamed:PenguinTitleArr[index]];
            [self addSubview:PenguinBtn];
            self.PenguinBtn = PenguinBtn;
        }
        
        UIView * PenguinGaryView = [UIView new];
        PenguinGaryView.backgroundColor = LGDLightGaryColor;
        [self addSubview:PenguinGaryView];
        [PenguinGaryView setFrame:CGRectMake(0, CGRectGetMaxY(_PenguinBtn.frame)+RealWidth(10), GK_SCREEN_WIDTH, RealWidth(10))];
        
        
        UILabel * PenguinSectionlb = [[UILabel alloc]initWithFrame:CGRectMake(RealWidth(15), CGRectGetMaxY(PenguinGaryView.frame)+RealWidth(10), RealWidth(200), RealWidth(20))];
        PenguinSectionlb.textColor = LGDBLackColor;
        PenguinSectionlb.font = [UIFont boldSystemFontOfSize:18];
        PenguinSectionlb.text = @"精选推荐";
        [self addSubview:PenguinSectionlb];
        
        MJWeakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf setNeedsLayout];
            [weakSelf layoutIfNeeded];
            if (weakSelf.headerBlock) {
                weakSelf.headerBlock(CGRectGetMaxY(PenguinSectionlb.frame)+RealWidth(5));
            }
        });
    }
    return self;
}
- (PenguinClanderView *)pengClandeView{
    if (!_pengClandeView) {
        _pengClandeView = [[PenguinClanderView alloc]init];
        UITapGestureRecognizer * PenguinSeachTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pengClandeViewClicks)];
        [_pengClandeView addGestureRecognizer:PenguinSeachTap];
    }
    return _pengClandeView;
}
- (UIView *)PenguinSearchingView{
    if (!_PenguinSearchingView) {
        _PenguinSearchingView = [UIView new];
        _PenguinSearchingView.backgroundColor = LGDLightGaryColor;
        _PenguinSearchingView.layer.cornerRadius = RealWidth(5);
        _PenguinSearchingView.layer.masksToBounds = YES;
        UITapGestureRecognizer * PenguinSeachTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PenguinSearchTapClicks)];
        [_PenguinSearchingView addGestureRecognizer:PenguinSeachTap];
    }
    return _PenguinSearchingView;
}
- (UIImageView *)PenguinSeachiIocnImgView{
    if (!_PenguinSeachiIocnImgView) {
        _PenguinSeachiIocnImgView = [UIImageView new];
        _PenguinSeachiIocnImgView.image = [UIImage imageNamed:@"sousuo"];
    }
    return _PenguinSeachiIocnImgView;
}
- (SDCycleScrollView *)PenguinSDCView{
    if (!_PenguinSDCView) {
        _PenguinSDCView = [[SDCycleScrollView alloc]init];
        _PenguinSDCView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _PenguinSDCView.layer.cornerRadius = RealWidth(5);
        _PenguinSDCView.layer.masksToBounds = YES;
    }
    return _PenguinSDCView;
}
#pragma mark--消息
-(void)PenguinChaseVideoMessageBtnClick:(PenguinChaseVideoMessageBtn *)btn{
    [self.delegate PenguinChaseHomHeaderViewBtnsAction:btn.tag];
}
#pragma mark--搜索
-(void)PenguinSearchTapClicks{
    NSLog(@"%s",__func__);
}
#pragma mark--日历
-(void)pengClandeViewClicks{
    NSLog(@"%s",__func__);
    [self.delegate PenguinChaseHomHeaderViewWithClanderActions];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
