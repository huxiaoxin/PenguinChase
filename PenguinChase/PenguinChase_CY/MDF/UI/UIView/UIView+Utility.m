//
//  UIView+Utility.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/6/15.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "UIView+Utility.h"

#import <objc/runtime.h>

@implementation UIView (Utility)

- (void)mdf_whenSingleTapped:(MDFGestureRecognizerActionBlock)block
{
    [self mdf_whenSingleTapped:block gestureConfigBlock:nil];
}

- (void)mdf_whenSingleTapped:(MDFGestureRecognizerActionBlock)block gestureConfigBlock:(MDFGestureRecognizerConfigBlock)configBlock
{
    UITapGestureRecognizer *tapGesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped:)];
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delaysTouchesBegan = NO;
    tapGesture.delaysTouchesEnded = NO;
    if (configBlock) {
        configBlock(tapGesture);
    }
    [self addRequiredToDoubleTapsRecognizer:tapGesture];
    [self setupBlock:block forKey:@selector(setupBlock:forKey:)];
}

#pragma mark - Helper

- (UITapGestureRecognizer *)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGesture];
    
    return tapGesture;
}

- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in [self gestureRecognizers]) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gesture;
            if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
                [recognizer requireGestureRecognizerToFail:tapGesture];
            }
        }
    }
}

- (void)viewWasTapped:(UITapGestureRecognizer *)gesture
{
    MDFGestureRecognizerActionBlock block = objc_getAssociatedObject(self, @selector(setupBlock:forKey:));
    if (block) block(gesture);
}

- (void)setupBlock:(MDFGestureRecognizerActionBlock)block forKey:(void *)blockKey
{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
