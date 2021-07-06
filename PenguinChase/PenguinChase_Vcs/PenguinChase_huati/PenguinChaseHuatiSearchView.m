//
//  PenguinChaseHuatiSearchView.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseHuatiSearchView.h"
@interface PenguinChaseHuatiSearchView ()
@property(nonatomic,copy)PenguinSeachTapBlock  searchBlock;
@end
@implementation PenguinChaseHuatiSearchView
-(instancetype)initWithFrame:(CGRect)frame  SearchTapAction:(PenguinSeachTapBlock)searchBlock{
    if (self = [super initWithFrame:frame]) {
        self.searchBlock = searchBlock;
        self.backgroundColor = LGDLightGaryColor;
        self.layer.cornerRadius = RealWidth(5);
        self.layer.masksToBounds = YES;
        
        UILabel * PenguinSeachlb = [UILabel new];
        PenguinSeachlb.text = @"请输入您感兴趣的电影";
        PenguinSeachlb.font = [UIFont systemFontOfSize:12];
        PenguinSeachlb.textColor = LGDGaryColor;
        [self addSubview:PenguinSeachlb];
        [PenguinSeachlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(RealWidth(1));
            make.centerX.mas_equalTo(RealWidth(6));
        }];
        
        UIImageView * penguinSeachIocnImgView = [UIImageView new];
        penguinSeachIocnImgView.image = [UIImage imageNamed:@"sousuo-gary"];
        [self addSubview:penguinSeachIocnImgView];
        [penguinSeachIocnImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(PenguinSeachlb.mas_left).offset(RealWidth(-3));
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(RealWidth(12), RealWidth(12)));
        }];
        
        UITapGestureRecognizer * PenguinSearchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SearcgTapClicks)];
        [self addGestureRecognizer:PenguinSearchTap];
    }
    return self;
}
-(void)SearcgTapClicks{
    if (self.searchBlock) {
        self.searchBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
