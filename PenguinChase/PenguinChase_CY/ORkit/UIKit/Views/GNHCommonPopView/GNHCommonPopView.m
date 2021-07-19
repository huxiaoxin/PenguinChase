//
//  GNHCommonPopView.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/27.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHCommonPopView.h"

#define kTopDistanceToScrollView 130
#define kBottomDistanceToScrollView (self.frame.size.height - 20 - 100)

static const CGFloat labelSpaceWidth = 10;

@interface GNHCommonPopView() <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGRect sourceRect;
@property (nonatomic, strong) UIView *tmpMaskView;
@property (nonatomic, copy) NSDictionary *propertiesOfItem;

@property (nonatomic, strong) UITextView *popUpTextView;

@end

@implementation GNHCommonPopView

- (void)commonPopViewWithSourceView:(UITableViewCell *)sourceView tableView:(UITableView *)tableView item:(MDFBaseItem *)item
{
    NSIndexPath *indexPath = [tableView indexPathForCell:sourceView];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [tableView convertRect:rectInTableView toView:[tableView superview]];
    [self commonInitWithRect:rectInSuperview];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopView)];
    [self addGestureRecognizer:gesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPressGesture.delegate = self;
    [self addGestureRecognizer:longPressGesture];
    
    [self setupUIWithItem:item];
}

- (instancetype)commonInitWithRect:(CGRect)sourceRect
{
    _sourceRect = sourceRect;
    self.frame = kScreenBounds;
    self.height = self.frame.size.height - 20;
    self.backgroundColor = [UIColor clearColor];
    
    _tmpMaskView = [[UIView alloc] init];
    self.tmpMaskView.frame = self.frame;
    self.tmpMaskView.backgroundColor = [UIColor lightGrayColor];
    self.tmpMaskView.alpha = 0.5;
    [self addSubview:self.tmpMaskView];
    
    self.popUpTextView.frame = sourceRect;
    self.popUpTextView.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)setupUIWithItem:(MDFBaseItem *)item
{
    _propertiesOfItem = [item propertyToDictionary];
    for (NSString *key in [_propertiesOfItem allKeys]) {
        id value = [self.propertiesOfItem valueForKey:key];
        if (value && ![value isKindOfClass:[NSNumber class]]) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.popUpTextView.attributedText];
            NSAttributedString *propertyAttrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\r\n\r\n", key] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:26.0], NSForegroundColorAttributeName: [UIColor redColor]}];
            [attrStr appendAttributedString:propertyAttrStr];
            self.popUpTextView.attributedText = attrStr;
        }
        
        if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSString class]]) {
            NSString *strM = [NSString stringWithFormat:@"%@", value];
            if ([value isKindOfClass:[NSDictionary class]]) {
                strM = [NSString stringWithCString:[strM cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] ? : strM;
            }
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.popUpTextView.attributedText];
            NSAttributedString *propertyAttrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\r\n\r\n", strM] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName: [UIColor blackColor]}];
            [attrStr appendAttributedString:propertyAttrStr];
            self.popUpTextView.attributedText = attrStr;
        }
    }
}

- (void)showDetailView
{
    CGFloat destTopLocation = kTopDistanceToScrollView;
    CGFloat destBottomLocation = kBottomDistanceToScrollView;
    if(self.popUpTextView.top < kTopDistanceToScrollView){
        destTopLocation = self.popUpTextView.top;
    }
    if (self.popUpTextView.bottom > kBottomDistanceToScrollView) {
        destBottomLocation = self.popUpTextView.bottom;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.popUpTextView.frame = CGRectMake(labelSpaceWidth, (destTopLocation + destBottomLocation) / 2, self.width - 2 * labelSpaceWidth, 0);
    self.popUpTextView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.popUpTextView.frame = CGRectMake(labelSpaceWidth, destTopLocation, self.width - 2 * labelSpaceWidth, destBottomLocation - destTopLocation);
    } completion:nil];
}

#pragma mark - UIGestureRecognizer Action

- (void)dismissPopView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.popUpTextView.frame = CGRectMake(self.sourceRect.size.width * 0.075, self.height / 2, self.sourceRect.size.width * 0.85, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.tmpMaskView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [SVProgressHUD showInfoWithStatus:@"复制成功"];
        [UIPasteboard generalPasteboard].string = self.popUpTextView.text;
        
        // 弹出分享框
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showSystemShareVC:self.popUpTextView.text];
        });
    }
}

- (void)showSystemShareVC:(NSString *)pasteText
{
    if (!pasteText.length) {
        return;
    }
    
    NSArray *pasteArray = @[pasteText];
    
    if (pasteText.length >= 512) {
        NSString *folder = NSTemporaryDirectory();
        NSString *shakeFolder = [folder stringByAppendingPathComponent:@"Shake"];
        NSString *shakeTxtPath = [shakeFolder stringByAppendingPathComponent:@"shakeAndShake.txt"];
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager createDirectoryAtPath:shakeFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
            if ([fileManager fileExistsAtPath:shakeTxtPath]) {
                [fileManager removeItemAtPath:shakeTxtPath error:&error];
            }
            NSData *fileData = [pasteText dataUsingEncoding:NSUTF8StringEncoding];
            if ([fileManager createFileAtPath:shakeTxtPath contents:fileData attributes:nil]) {
                NSURL *txtUrl = [NSURL fileURLWithPath:shakeTxtPath];
                if (txtUrl) {
                    pasteArray = @[txtUrl];
                }
            }
        }
    }
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:pasteArray
                                                                                        applicationActivities:nil];
    
    NSMutableArray *excludedTypes = [NSMutableArray arrayWithObjects:
                                     UIActivityTypePostToFacebook,
                                     UIActivityTypePostToTwitter,
                                     UIActivityTypeCopyToPasteboard,
                                     UIActivityTypeAssignToContact,
                                     UIActivityTypeSaveToCameraRoll,
                                     UIActivityTypeAddToReadingList,
                                     UIActivityTypePostToFlickr,
                                     UIActivityTypePostToVimeo,
                                     UIActivityTypePostToTencentWeibo,
                                     nil];
    if (SYSTEM_VERSION_GREATER_THAN(@"9.0")) {
        [excludedTypes addObject:UIActivityTypeOpenInIBooks];
    }
    activityViewController.excludedActivityTypes = [excludedTypes copy];
    
    if (activityViewController) {
        [[UIViewController mdf_toppestViewController] presentViewController:activityViewController animated:TRUE completion:nil];
    }
}

#pragma mark - Properties

- (UITextView *)popUpTextView
{
    if (!_popUpTextView) {
        _popUpTextView = [[UITextView alloc] init];
        [self addSubview:_popUpTextView];
        
        _popUpTextView.layer.cornerRadius = 10;
        _popUpTextView.layer.masksToBounds = YES;
        _popUpTextView.selectable = NO;
        _popUpTextView.editable = NO;
    }
    
    return _popUpTextView;
}

@end
