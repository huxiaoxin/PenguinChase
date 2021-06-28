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

#import "KJBannerHeader.h"
#import "KJBannerTimingClearManager.h"
#import "KJBannerViewCacheManager.h"
#import "KJBannerViewDownloader.h"
#import "KJBannerViewLoadManager.h"
#import "KJBannerWebImageHandle.h"
#import "UIView+KJWebImage.h"
#import "KJBannerView.h"
#import "KJBannerViewCell.h"
#import "KJBannerViewFlowLayout.h"
#import "KJBannerViewProtocol.h"
#import "KJBannerViewType.h"
#import "KJPageView.h"
#import "NSObject+KJGCDTimer.h"

FOUNDATION_EXPORT double KJBannerViewVersionNumber;
FOUNDATION_EXPORT const unsigned char KJBannerViewVersionString[];

