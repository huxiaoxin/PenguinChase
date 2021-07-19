//
//  GNHBaseButton.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/4/26.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseButton.h"

@interface GNHBaseButton ()
@property (nonatomic, copy) GNHBaseButtonDidClickBlock didClickBlock;
@end
@implementation GNHBaseButton

+ (instancetype)buttonWithTitle:(NSString *)title didClickBlock:(GNHBaseButtonDidClickBlock)didClickBlock {
    GNHBaseButton *btn = [self ly_ButtonWithTitle:title titleColor:nil font:nil target:nil selector:nil];
    [btn baseButtonConfig];
    btn.didClickBlock = [didClickBlock copy];
    return btn;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)baseButtonConfig {
    [self addTarget:self.class action:@selector(baseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

+ (void)baseBtnClick:(GNHBaseButton *)btn {
    if (btn.didClickBlock) {
        btn.didClickBlock(btn);
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
