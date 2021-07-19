//
//  GNHBaseScrollView.m
//  GeiNiHua
//
//  Created by ChenYuan on 2018/2/28.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHBaseScrollView.h"

@interface GNHBaseScrollView ()
@property (nonatomic, weak) UIView *contentView;
@end

@implementation GNHBaseScrollView

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [UIView ly_ViewWithColor:[UIColor clearColor]];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.width.equalTo(self);
        }];
        self.contentView = contentView;
        
    }
    return _contentView;
}

#pragma mark - UIGestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}

@end
