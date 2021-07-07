//
//  PenguinChaseDongtaiTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseDongtaiTableViewCell.h"
#import "PenguinChaseDongtaiCollectionViewCell.h"
#import "PenguinChaseDongtaiBtn.h"
#import <GKPhotoBrowser.h>
@interface PenguinChaseDongtaiTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UIImageView * PenguinChaseThubimgView;
@property(nonatomic,strong) UILabel     * PenguinChaseNamelb;
@property(nonatomic,strong) UILabel     * PenguinChaseTaglb;
@property(nonatomic,strong) UILabel     * PenguinTimelb;
@property(nonatomic,strong) UILabel     * PenguinContentlb;
@property(nonatomic,strong) UICollectionView * PenguinCollectionView;
@property(nonatomic,strong) PenguinChaseDongtaiBtn    * PenguinJubaoBtn;
@property(nonatomic,strong) PenguinChaseDongtaiBtn    * PenguinAddComentBtn;
@property(nonatomic,strong) PenguinChaseDongtaiBtn    * PenguinZanBtn;
@property(nonatomic,strong) UIView                    * PenguinBtomline;

@end
@implementation PenguinChaseDongtaiTableViewCell
-(void)PenguinChaseAddSubViews{
    
    
    [self.contentView addSubview:self.PenguinChaseThubimgView];
    [self.contentView addSubview:self.PenguinChaseNamelb];
    [self.contentView addSubview:self.PenguinChaseTaglb];
    [self.contentView addSubview:self.PenguinTimelb];
    [self.contentView addSubview:self.PenguinContentlb];
    [self.contentView addSubview:self.PenguinCollectionView];
    
    [self.contentView addSubview:self.PenguinJubaoBtn];
    [self.contentView addSubview:self.PenguinAddComentBtn];
    [self.contentView addSubview:self.PenguinZanBtn];
    [self.contentView addSubview:self.PenguinBtomline];
    [_PenguinChaseThubimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.inset(RealWidth(15));
        make.top.mas_equalTo(RealWidth(0));
        make.size.mas_equalTo(CGSizeMake(RealWidth(40), RealWidth(40)));
    }];
    [_PenguinChaseNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_PenguinChaseThubimgView.mas_centerY).offset(-RealWidth(3));
        make.left.mas_equalTo(_PenguinChaseThubimgView.mas_right).offset(RealWidth(10));
    }];
    [_PenguinChaseTaglb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinChaseNamelb.mas_right).offset(RealWidth(10));
        make.centerY.mas_equalTo(_PenguinChaseNamelb.mas_centerY);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(RealWidth(40), RealWidth(12)));

    }];
    [_PenguinTimelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RealWidth(15));
        make.centerY.mas_equalTo(_PenguinChaseThubimgView.mas_centerY);
    }];
    [_PenguinContentlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinChaseThubimgView.mas_right).offset(RealWidth(10));
        make.right.mas_equalTo(-RealWidth(10));
        make.top.mas_equalTo(_PenguinChaseNamelb.mas_bottom).offset(RealWidth(10));
    }];
    
    [_PenguinCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinChaseThubimgView.mas_right).offset(RealWidth(10));
        make.top.mas_equalTo(_PenguinContentlb.mas_bottom).offset(RealWidth(5));
        make.right.mas_equalTo(-RealWidth(10));
        make.height.mas_equalTo(RealWidth(80));
    }];
    
    [_PenguinJubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinCollectionView);
        make.top.mas_equalTo(_PenguinCollectionView.mas_bottom).offset(RealWidth(8));
        make.right.mas_equalTo(_PenguinJubaoBtn.penguinRightlb.mas_right);
    }];
    
    [_PenguinAddComentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(_PenguinCollectionView.mas_centerX);
        make.top.mas_equalTo(_PenguinCollectionView.mas_bottom).offset(RealWidth(8));
        make.right.mas_equalTo(_PenguinJubaoBtn.penguinRightlb.mas_right);
    }];
    
    [_PenguinZanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PenguinCollectionView.mas_bottom).offset(RealWidth(8));
        make.right.mas_equalTo(_PenguinZanBtn.penguinRightlb.mas_right);
        make.right.mas_equalTo(_PenguinCollectionView.mas_right);
    }];
    [_PenguinBtomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_PenguinCollectionView);
        make.right.mas_equalTo(-RealWidth(15));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(_PenguinZanBtn.mas_bottom).offset(RealWidth(0));
    }];
    
}
- (UIImageView *)PenguinChaseThubimgView{
    if (!_PenguinChaseThubimgView) {
        _PenguinChaseThubimgView = [UIImageView new];
        _PenguinChaseThubimgView.layer.cornerRadius = RealWidth(20);
        _PenguinChaseThubimgView.layer.masksToBounds = YES;
        _PenguinChaseThubimgView.backgroundColor = LGDMianColor;
        _PenguinChaseThubimgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * PenguinInfoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PenguinChaseThubimgViewClick)];
        [_PenguinChaseThubimgView addGestureRecognizer:PenguinInfoTap];
        
    }
    return _PenguinChaseThubimgView;
}
- (UILabel *)PenguinChaseNamelb{
    if (!_PenguinChaseNamelb) {
        _PenguinChaseNamelb = [UILabel new];
        _PenguinChaseNamelb.textColor = [UIColor blackColor];
        _PenguinChaseNamelb.font = [UIFont boldSystemFontOfSize:13];
        _PenguinChaseNamelb.text = @"我是大人物";
    }
    return _PenguinChaseNamelb;
}
- (UILabel *)PenguinTimelb{
    if (!_PenguinTimelb) {
        _PenguinTimelb = [UILabel new];
        _PenguinTimelb.textColor = LGDGaryColor;
        _PenguinTimelb.font = [UIFont systemFontOfSize:11];
        _PenguinTimelb.text = @"昨天 12:30";
    }
    return _PenguinTimelb;
}
- (UILabel *)PenguinChaseTaglb{
    if (!_PenguinChaseTaglb) {
        _PenguinChaseTaglb = [UILabel new];
        _PenguinChaseTaglb.textColor = [UIColor whiteColor];
        _PenguinChaseTaglb.backgroundColor = LGDBlueColor;
        _PenguinChaseTaglb.layer.cornerRadius = RealWidth(5);
        _PenguinChaseTaglb.layer.masksToBounds = YES;
        _PenguinChaseTaglb.font = [UIFont systemFontOfSize:9];
        _PenguinChaseTaglb.text = @"新手用户";
        _PenguinChaseTaglb.textAlignment = NSTextAlignmentCenter;
    }
    return _PenguinChaseTaglb;
}
- (UILabel *)PenguinContentlb{
    if (!_PenguinContentlb) {
        _PenguinContentlb = [UILabel new];
        _PenguinContentlb.textColor = LGDLightBLackColor;
        _PenguinContentlb.font = [UIFont systemFontOfSize:14];
        _PenguinContentlb.numberOfLines = 0;
        [_PenguinContentlb setText:@"新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户新手用户" lineSpacing:1.5];
    }
    return _PenguinContentlb;
}
- (UICollectionView *)PenguinCollectionView{
    if (!_PenguinCollectionView) {
        UICollectionViewFlowLayout * pengUinLayout  = [[UICollectionViewFlowLayout alloc]init];
        pengUinLayout.itemSize = CGSizeMake(RealWidth(80), RealWidth(80));
        _PenguinCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:pengUinLayout];
        _PenguinCollectionView.delegate = self;
        _PenguinCollectionView.dataSource = self;
        _PenguinCollectionView.showsVerticalScrollIndicator = NO;
        _PenguinCollectionView.showsHorizontalScrollIndicator = NO;
        _PenguinCollectionView.backgroundColor  =[UIColor whiteColor];
    }
    return _PenguinCollectionView;
}
- (UIView *)PenguinBtomline{
    if (!_PenguinBtomline) {
        _PenguinBtomline = [UIView new];
        _PenguinBtomline.backgroundColor = LGDLightGaryColor;
    }
    return _PenguinBtomline;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pengModel.imgArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseDongtaiCollectionViewCell * PenguinPhotoCell = [PenguinChaseDongtaiCollectionViewCell PenguinChasecreatTheCollectView:collectionView AndTheIndexPath:indexPath];
    [PenguinPhotoCell.penguinPhotoImgView sd_setImageWithURL:[NSURL URLWithString:_pengModel.imgArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    return PenguinPhotoCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *photos = [NSMutableArray new];
    [_pengModel.imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       GKPhoto *photo = [GKPhoto new];
       photo.url = [NSURL URLWithString:obj];
       [photos addObject:photo];
    }];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.row];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:[AppDelegate shareDelegate].window.rootViewController.gk_visibleViewControllerIfExist];

}
- (PenguinChaseDongtaiBtn *)PenguinJubaoBtn{
    if (!_PenguinJubaoBtn) {
        _PenguinJubaoBtn = [[PenguinChaseDongtaiBtn alloc]init];
        _PenguinJubaoBtn.tag =  0;
        _PenguinJubaoBtn.penguinLeftImgView.image = [UIImage imageNamed:@"jubao"];
        _PenguinJubaoBtn.penguinRightlb.text = @"更多";
        [_PenguinJubaoBtn addTarget:self action:@selector(PenguinJubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinJubaoBtn;
}
- (PenguinChaseDongtaiBtn *)PenguinAddComentBtn{
    if (!_PenguinAddComentBtn) {
        _PenguinAddComentBtn = [[PenguinChaseDongtaiBtn alloc]init];
        _PenguinAddComentBtn.tag =  1;
        _PenguinAddComentBtn.penguinRightlb.text = @"评论";
        _PenguinAddComentBtn.penguinLeftImgView.image = [UIImage imageNamed:@"comment"];
        [_PenguinAddComentBtn addTarget:self action:@selector(PenguinJubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinAddComentBtn;
}
- (PenguinChaseDongtaiBtn *)PenguinZanBtn{
    if (!_PenguinZanBtn) {
        _PenguinZanBtn = [[PenguinChaseDongtaiBtn alloc]init];
        _PenguinZanBtn.tag =  2;
        _PenguinZanBtn.penguinRightlb.text = @"点赞";
        _PenguinZanBtn.penguinLeftImgView.image = [UIImage imageNamed:@"dianzan-sel"];
        //dianzan-sel
        //dianzan

        [_PenguinZanBtn addTarget:self action:@selector(PenguinJubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinZanBtn;
}

-(void)PenguinJubaoBtnClick:(PenguinChaseDongtaiBtn * )dongtaiBtn{
    [self.delegate PenguinChaseDongtaiTableViewCellWithBtnActionIndex:dongtaiBtn.tag CellIndex:self.tag];
}
- (void)setPengModel:(PenguinChaseDongtaiModel *)pengModel{
    _pengModel = pengModel;
    [_PenguinChaseThubimgView sd_setImageWithURL:[NSURL URLWithString:pengModel.headerImgurl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    _PenguinChaseNamelb.text = pengModel.userName;
    _PenguinTimelb.text =  pengModel.time;
    
    if (pengModel.userLevel == 0) {
        _PenguinChaseTaglb.hidden = YES;
    }else if (pengModel.userLevel == 1){
        _PenguinChaseTaglb.hidden = NO;
        _PenguinChaseTaglb.text = @"新手用户";
        _PenguinChaseTaglb.backgroundColor = LGDBlueColor;

    }else{
        _PenguinChaseTaglb.hidden = NO;
        _PenguinChaseTaglb.text = @"老司机";
        _PenguinChaseTaglb.backgroundColor = LGDMianColor;

    }
    [_PenguinContentlb setText:pengModel.content lineSpacing:1.5];
    
    [_PenguinCollectionView reloadData];
//    if (pengModel.CellHeight == 0) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        pengModel.CellHeight = CGRectGetMaxY(_PenguinBtomline.frame);
//    }
    
    
}
-(void)PenguinChaseThubimgViewClick{
    [self.delegate PenguinChaseDongtaiTableViewCellWithChatCellIndex:self.tag];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
