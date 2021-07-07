//
//  PenguinChaseDongtaiCollectionViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/5.
//

#import "PenguinChaseDongtaiCollectionViewCell.h"
@interface PenguinChaseDongtaiCollectionViewCell ()
@end
@implementation PenguinChaseDongtaiCollectionViewCell
-(void)PenguinChaseAddSubViews{
    [self.contentView addSubview:self.penguinPhotoImgView];
    [_penguinPhotoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
- (UIImageView *)penguinPhotoImgView{
    if (!_penguinPhotoImgView) {
        _penguinPhotoImgView = [UIImageView new];
        _penguinPhotoImgView.layer.cornerRadius = RealWidth(5);
        _penguinPhotoImgView.layer.masksToBounds = YES;
        _penguinPhotoImgView.backgroundColor = LGDMianColor;
        _penguinPhotoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _penguinPhotoImgView.layer.masksToBounds = YES;
    }
    return _penguinPhotoImgView;
}
@end
