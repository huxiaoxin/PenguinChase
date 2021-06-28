#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "QRCameraSwitchButton.h"
#import "QRCodeReader.h"
#import "QRCodeReaderDelegate.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReaderAanimationLineView.h"
#import "QRCodeReaderMaskView.h"
#import "QRCodeReaderView.h"

FOUNDATION_EXPORT double QRCodeReaderViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char QRCodeReaderViewControllerVersionString[];

