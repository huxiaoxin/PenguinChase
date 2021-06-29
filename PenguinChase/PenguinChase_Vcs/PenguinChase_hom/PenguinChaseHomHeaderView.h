//
//  PenguinChaseHomHeaderView.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinClanderView : UIView
@property(nonatomic,strong) UIImageView * PenguinThubImgView;
@property(nonatomic,strong) UIView      * PenguinGaryView;
@property(nonatomic,strong) UILabel     * PenguinToplb;
@property(nonatomic,strong) UILabel     * PenguinBtomlb;
@end

typedef void(^PenguinChaseHomHeaderHeightBlock)(CGFloat headerHeight);
@interface PenguinChaseHomHeaderView : UIView
@property(nonatomic,copy) PenguinChaseHomHeaderHeightBlock headerBlock;
@end

NS_ASSUME_NONNULL_END