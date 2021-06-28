#import "UIViewController+IOS13.h"
@implementation UIViewController (IOS13)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = @selector(modalPresentationStyle);
        SEL swizzSel = @selector(swiz_modalPresentationStyle);
        Method method = class_getInstanceMethod([self class], sel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, sel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(method), method_getTypeEncoding(method));
        }else{
            method_exchangeImplementations(method, swizzMethod);
        }
    });
}

- (UIModalPresentationStyle)swiz_modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

@end
