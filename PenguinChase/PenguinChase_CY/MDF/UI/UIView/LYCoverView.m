//
//  LYCoverView.m
//  GeiNiHua
//
//  Created by ChenYuan on 16/6/7.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import "LYCoverView.h"
#import "UIView+LYExt.h"
#import "UIColor+LYString.h"
#import <Masonry/Masonry.h>

@interface LYCoverView ()
@property (nonatomic, weak) UIView *contentView;
@end

@implementation LYCoverView

#pragma mark - Class Method

+ (instancetype)showView:(UIView *)view inView:(UIView *)inView {
    
    if (inView) {
        LYCoverView *coverView = [self ly_ViewWithColor:[UIColor clearColor]];
        [inView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(inView);
            make.size.equalTo(inView);
        }];
        
        if (view) {
            [coverView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(coverView);
            }];
        }
        
        return coverView;
    } else {
        NSAssert(inView, @"inView is nil");
        return nil;
    }
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _touchDisMiss = YES;
        
        UIView *contentView = [UIView ly_ViewWithColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [contentView addGestureRecognizer:tap];
        [self addSubview:contentView];
        _contentView = contentView;
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setCoverColor:(UIColor *)coverColor {
    _coverColor = coverColor;
    self.contentView.backgroundColor = _coverColor;
}

- (void)tapAction {
    if (self.touchDisMiss) {
        [self disMiss];
        if (self.touchDidDisMiss) {
            self.touchDidDisMiss();
        }
    }
}

- (void)disMiss {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
