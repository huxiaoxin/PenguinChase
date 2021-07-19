//
//  UIButton+GNHDelay.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/3/17.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "UIButton+GNHDelay.h"

#import <objc/runtime.h>

static NSTimeInterval const DefaultDurationTime = 0.3; /** 按钮默认点击时间间隔 */
static NSString *const MY_ClickDurationTime = @"my_clickDurationTime";
static NSString *const MY_IsIgnoreEvent = @"my_isIgnoreEvent";
@implementation UIButton (GNHDelay)
- (void)setClickDurationTime:(NSTimeInterval)clickDurationTime {
    objc_setAssociatedObject(self, (__bridge const void *)(MY_ClickDurationTime), @(clickDurationTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)clickDurationTime {
    NSTimeInterval durationTime = [objc_getAssociatedObject(self, (__bridge const void *)(MY_ClickDurationTime)) doubleValue];
    return durationTime > 0?: DefaultDurationTime;
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, (__bridge const void *)(MY_IsIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, (__bridge const void *)(MY_IsIgnoreEvent)) boolValue];
}

- (void)my_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:[UIButton class]] && ![self filtrationFailureButton:self]) {
        if (self.isIgnoreEvent) {
            return;
        } else {
            self.isIgnoreEvent = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isIgnoreEvent = NO;
            });
            [self my_sendAction:action to:target forEvent:event];
        }
    } else {
        [self my_sendAction:action to:target forEvent:event];
    }
}

- (BOOL)filtrationFailureButton:(UIButton *)btn {
    NSArray<NSString *> *filterButtons = @[@"CAMFlipButton", @"CUShutterButton", @"UISwipeActionStandardButton"];
    __block BOOL isFiltration = NO;
    [filterButtons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(btn.class) isEqualToString:obj]) {
            isFiltration = YES;
            *stop = YES;
        }
    }];
    return isFiltration;
}

+ (void)load {
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(my_sendAction:to:forEvent:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL addMyMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (addMyMethod) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
