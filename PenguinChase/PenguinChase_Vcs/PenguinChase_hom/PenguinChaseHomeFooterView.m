//
//  PenguinChaseHomeFooterView.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import "PenguinChaseHomeFooterView.h"
#import "JRWaterFallLayout.h"
#import "PenguinChaseHomeCollectionViewCell.h"
@interface PenguinChaseHomeFooterView ()<UICollectionViewDelegate,UICollectionViewDataSource,JRWaterFallLayoutDelegate>
@property(nonatomic,strong) UILabel * PenguinChaseBtomlb;
@property(nonatomic,strong) UICollectionView * PenguinCollectionView;
@property(nonatomic,strong) JRWaterFallLayout * penguinLayout;
@end
@implementation PenguinChaseHomeFooterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.PenguinChaseBtomlb];
        [self addSubview:self.PenguinCollectionView];
        [_PenguinChaseBtomlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.inset(RealWidth(15));
            make.top.mas_equalTo(RealWidth(10));
        }];
        
        [_PenguinCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_PenguinChaseBtomlb.mas_bottom);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(RealWidth(10));
        }];
 
        
        
    }
    return self;
}
- (void)setPenguinFooterDataArr:(NSArray *)PenguinFooterDataArr{
    _PenguinFooterDataArr = PenguinFooterDataArr;
    [_PenguinCollectionView reloadData];
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.PenguinCollectionView reloadData];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [weakSelf.PenguinCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self->_penguinLayout.collectionViewContentSize.height);
        }];

        if (weakSelf.FooterBlock) {
            weakSelf.FooterBlock(weakSelf.penguinLayout.collectionViewContentSize.height+RealWidth(35));
        }
    });
}
- (UICollectionView *)PenguinCollectionView{
    if (!_PenguinCollectionView) {
        JRWaterFallLayout * penguinLayout  = [[JRWaterFallLayout alloc]init];
        penguinLayout.delegate = self;
        _penguinLayout = penguinLayout;
        _PenguinCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:penguinLayout];
        _PenguinCollectionView.backgroundColor = [UIColor clearColor];
        _PenguinCollectionView.showsVerticalScrollIndicator = NO;
        _PenguinCollectionView.showsHorizontalScrollIndicator = NO;
        _PenguinCollectionView.delegate = self;
        _PenguinCollectionView.dataSource = self;
        _PenguinCollectionView.scrollEnabled  =NO;
    }
    return _PenguinCollectionView;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseHomeCollectionViewCell * PenginCHsaesaCell = [PenguinChaseHomeCollectionViewCell PenguinChasecreatTheCollectView:collectionView AndTheIndexPath:indexPath];
    PenginCHsaesaCell.penguinModel = self.PenguinFooterDataArr[indexPath.row];
    return PenginCHsaesaCell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _PenguinFooterDataArr.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate PenguinChaseHomeFooterViewWithColltecDidSeltecd:_PenguinFooterDataArr[indexPath.row]];
}
#pragma mark--JRWaterFallLayoutDelegate
- (CGFloat)waterFallLayout:(JRWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
{
return RealWidth(160);
}
- (CGFloat)columnMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return RealWidth(10);
}
- (CGFloat)rowMarginOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return  RealWidth(10);
}

- (NSUInteger)columnCountOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{
    return 2;
}
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(JRWaterFallLayout *)waterFallLayout{

    return UIEdgeInsetsMake(0, RealWidth(13), 0, RealWidth(13));
}
- (UILabel *)PenguinChaseBtomlb{
    if (!_PenguinChaseBtomlb) {
        _PenguinChaseBtomlb = [UILabel new];
        _PenguinChaseBtomlb.textColor  = LGDBLackColor;
        _PenguinChaseBtomlb.font = [UIFont boldSystemFontOfSize:18];
        _PenguinChaseBtomlb.text = @"今日热议";
    }
    return _PenguinChaseBtomlb;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
