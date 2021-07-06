#import "PenguinChaseAdviceCollectionCell.h"
@interface PenguinChaseAdviceCollectionCell ()
{
    UIButton * _PenguinDelteBtn;
}
@end
@implementation PenguinChaseAdviceCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
        UIImageView * keqiangboyImgViews = [[UIImageView alloc]initWithFrame:CGRectMake(0, K(7.5), K(150/2), K(150/2))];
        keqiangboyImgViews.layer.cornerRadius  =K(5);
        keqiangboyImgViews.layer.masksToBounds = YES;
        keqiangboyImgViews.backgroundColor = LGDLightGaryColor;
        [self.contentView addSubview:keqiangboyImgViews];
        _pengiinImgViews = keqiangboyImgViews;
        
        
        UIButton * PenguinDelteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(keqiangboyImgViews.frame)-K(7.5), K(0), K(15), K(15.5))];
        [PenguinDelteBtn addTarget:self action:@selector(PenguinDelteBtnnCliks) forControlEvents:UIControlEventTouchUpInside];
        [PenguinDelteBtn setBackgroundImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        [self addSubview:PenguinDelteBtn];
        _PenguinDelteBtn  =PenguinDelteBtn;
        
        
        
    }
    return self;
}
-(void)PenguinDelteBtnnCliks{
    [self.Delegate  PenguinChaseCollectionCellDelegateWithBtnCliocks:self.tag];
}
-(void)setPenguinimmgs:(UIImage *)penguinimmgs{
    _penguinimmgs = penguinimmgs;
    UIImage * keqiangbof = [UIImage imageNamed:@"add"];
    if (keqiangbof  == penguinimmgs) {
        _PenguinDelteBtn.hidden = YES;
    }else{
        _PenguinDelteBtn.hidden = NO;
    }
        _pengiinImgViews.image = penguinimmgs;
}
@end
