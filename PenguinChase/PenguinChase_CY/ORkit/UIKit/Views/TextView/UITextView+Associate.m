//
//  UITextView+Associate.m
//  AFNetworking
//
//  Created by 蔡儒楠 on 2017/10/30.
//

#import "UITextView+Associate.h"
#import <objc/runtime.h>

char* const ASSOCIATION_STRING_UITEXTVIEW_USER_INFO  = "ASSOCIATION_STRING_UITEXTVIEW_USER_INFO";
char* const ASSOCIATION_STRING_UITEXTVIEW_NAME = "ASSOCIATION_STRING_UITEXTVIEW_NAME";
char* const ASSOCIATION_STRING_UITEXTVIEW_PASTEBOARD = "ASSOCIATION_STRING_UITEXTVIEW_PASTEBOARD";

@implementation UITextView (Associate)

- (void)setUserInfo:(NSArray *)userInfo
{
    objc_setAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_USER_INFO, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)getUserInfo
{
    return objc_getAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_USER_INFO);
}

- (NSString *)textFieldName
{
    return objc_getAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_NAME);
}

- (void)setTextFieldName:(NSString *)textFieldName
{
    objc_setAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_NAME, textFieldName, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark UIPasteboard
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    return (action == @selector(copy:) || action == @selector(paste:)  || action == @selector(cut:));
//}

//- (void)copy:(id)sender { }
//- (void)cut:(id)sender { }

- (void)paste:(id)sender
{
    self.mdf_Pasted = YES;
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text = board.string;
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
}

#pragma mark - Properties

- (BOOL)mdf_Pasted
{
    return [objc_getAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_PASTEBOARD) boolValue];
}

- (void)setMdf_Pasted:(BOOL)mdf_Pasted
{
    objc_setAssociatedObject(self, &ASSOCIATION_STRING_UITEXTVIEW_PASTEBOARD, @(mdf_Pasted), OBJC_ASSOCIATION_ASSIGN);
}

@end
