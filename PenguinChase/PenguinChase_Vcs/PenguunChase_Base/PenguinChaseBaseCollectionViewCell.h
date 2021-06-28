//
//  PenguinChaseBaseCollectionViewCell.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseBaseCollectionViewCell : UICollectionViewCell
+(id)PenguinChasecreatTheCollectView:(UICollectionView *)collectView AndTheIndexPath:(NSIndexPath *)indexpath;
-(void)PenguinChaseAddSubViews;
@end

NS_ASSUME_NONNULL_END
