//
//  PenguinChaseBaseCollectionViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseBaseCollectionViewCell.h"

@implementation PenguinChaseBaseCollectionViewCell
+(id)PenguinChasecreatTheCollectView:(UICollectionView *)collectView AndTheIndexPath:(NSIndexPath *)indexpath{
    NSString  *idenfier = NSStringFromClass([self classForCoder]);
    [collectView registerClass:[self classForCoder] forCellWithReuseIdentifier:idenfier];
    PenguinChaseBaseCollectionViewCell  *cell = [collectView dequeueReusableCellWithReuseIdentifier:idenfier forIndexPath:indexpath];
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self PenguinChaseAddSubViews];
    }
    return  self;
}
-(void)PenguinChaseAddSubViews{
    
}
@end
