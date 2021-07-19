//
//  UIDevice+Hardware.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/5/16.
//  Copyright © 2017年 GNH. All rights reserved.
//


#import <UIKit/UIKit.h>

#define IFPGA_NAMESTRING                @"iFPGA"

#define IPHONE_1G_NAMESTRING            @"iPhone 1G (A1203)"
#define IPHONE_3G_NAMESTRING            @"iPhone 3G (A1241/A1324)"
#define IPHONE_3GS_NAMESTRING           @"iPhone 3GS (A1303/A1325)"
#define IPHONE_4_NAMESTRING             @"iPhone 4 (A1332/A1349)"
#define IPHONE_4S_NAMESTRING            @"iPhone 4S (A1387/A1431)"
#define IPHONE_5_NAMESTRING             @"iPhone 5 (A1428/A1429/A1442)"
#define IPHONE_5S_NAMESTRING            @"iPhone 5S (A1453/A1533A1457/A1518/A1528/A1530)"
#define IPHONE_5C_NAMESTRING            @"iPhone 5C (A1456/A1532A1507/A1516/A1526/A1529)"
#define IPHONE_6_NAMESTRING             @"iPhone 6 (A1549/A1586)"
#define IPHONE_6_PLUS_NAMESTRING        @"iPhone 6 Plus (A1522/A1524)"
#define IPHONE_6S_NAMESTRING            @"iPhone 6S (A1700/A1633/A1688)"
#define IPHONE_6S_PLUS_NAMESTRING       @"iPhone 6S Plus (A1699/A1634/A1687)"
#define IPHONE_SE_NAMESTRING            @"iPhone SE (A1723/A1724)"
#define IPHONE_7_NAMESTRING             @"iPhone 7 (Sonora)"
#define IPHONE_7_PLUS_NAMESTRING        @"iPhone 7 Plus (Dos Palos)"

#define IPHONE_8_NAMESTRING             @"iPhone 8 (A1863/A1906)"
#define IPHONE_8_Global_NAMESTRING      @"iPhone 8 (A1905)"
#define IPHONE_8PLUS_NAMESTRING         @"iPhone 8 Plus (A1864/A1898)"
#define IPHONE_8PLUS_GLOBAL_NAMESTRING  @"iPhone 8 Plus (A1897)"
#define IPHONE_X_NAMESTRING             @"iPhone X (A1865/A1902)"
#define IPHONE_X_GLOBAL_NAMESTRING      @"iPhone X (A1901)"
#define IPHONE_XR_GLOBAL_NAMESTRING     @"iPhone XR (A2106/A2108/A1984/A2105)"
#define IPHONE_XS_GLOBAL_NAMESTRING     @"iPhone XS (A1920/A2097/A2098/A2100)"
#define IPHONE_XSMax_NAMESTRING         @"iPhone XS Max (A2104)"
#define IPHONE_XSMax_GLOBAL_NAMESTRING  @"iPhone XS Max (A2102/A1921/A2101)"
#define IPHONE_11_GLOBAL_NAMESTRING     @"iPhone 11"
#define IPHONE_11PRO_NAMESTRING         @"iPhone 11 Pro"
#define IPHONE_11PROMAX_NAMESTRING      @"iPhone 11 Pro Max"

#define IPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define IPOD_1G_NAMESTRING              @"iPod touch 1G"
#define IPOD_2G_NAMESTRING              @"iPod touch 2G"
#define IPOD_3G_NAMESTRING              @"iPod touch 3G"
#define IPOD_4G_NAMESTRING              @"iPod touch 4G"
#define IPOD_5G_NAMESTRING              @"iPod touch 5G"
#define IPOD_UNKNOWN_NAMESTRING         @"Unknown iPod"

#define IPAD_1G_NAMESTRING              @"iPad 1G"
#define IPAD_2G_NAMESTRING              @"iPad 2G"
#define IPAD_3G_NAMESTRING              @"iPad 3G"
#define IPAD_4G_NAMESTRING              @"iPad 4G"
#define IPAD_UNKNOWN_NAMESTRING         @"Unknown iPad"

#define APPLETV_2G_NAMESTRING           @"Apple TV 2G"
#define APPLETV_3G_NAMESTRING           @"Apple TV 3G"
#define APPLETV_4G_NAMESTRING           @"Apple TV 4G"
#define APPLETV_UNKNOWN_NAMESTRING      @"Unknown Apple TV"

#define IOS_FAMILY_UNKNOWN_DEVICE       @"Unknown iOS device"

#define SIMULATOR_NAMESTRING            @"iPhone Simulator"
#define SIMULATOR_IPHONE_NAMESTRING     @"iPhone Simulator"
#define SIMULATOR_IPAD_NAMESTRING       @"iPad Simulator"
#define SIMULATOR_APPLETV_NAMESTRING    @"Apple TV Simulator" // :)

typedef NS_ENUM(NSUInteger, UIDevicePlatform) {
    UIDeviceUnknown,
    
    UIDeviceSimulator,
    UIDeviceSimulatoriPhone,
    UIDeviceSimulatoriPad,
    UIDeviceSimulatorAppleTV,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice5SiPhone,
    UIDevice5CiPhone,
    UIDevice6iPhone,
    UIDevice6PlusiPhone,
    UIDevice6SiPhone,
    UIDevice6SPlusiPhone,
    UIDeviceSEiPhone,
    UIDevice7iPhone,
    UIDevice7PlusiPhone,
    UIDeviceiPhone_8_China_Japan,
    UIDeviceiPhone_8_Global,
    UIDeviceiPhone_8Plus_China_Japan,
    UIDeviceiPhone_8Plus_Global,
    UIDeviceiPhone_X_China_Japan,
    UIDeviceiPhone_X_Global,
    UIDeviceiPhone_XR_Global,
    UIDeviceiPhone_XS_Global,
    UIDeviceiPhone_XSMax_China,
    UIDeviceiPhone_XSMax_Global,
    UIDeviceiPhone_11_Global,
    UIDeviceiPhone_11Pro_China,
    UIDeviceiPhone_11ProMax_Global,
    
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    UIDevice5GiPod,
    
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceUnknownAppleTV,
    UIDeviceIFPGA,
    
};

typedef NS_ENUM(NSUInteger, UIDeviceNetworkType) {
    UIDeviceNetworkTypeUnReachable,
    UIDeviceNetworkTypeWifi,
    UIDeviceNetworkTypeOther, //iOS7以下获取不到具体类型,移动网络统一归为'other'
    UIDeviceNetworkType2G,
    UIDeviceNetworkType3G,
    UIDeviceNetworkType4G,
};

typedef enum {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
    
} UIDeviceFamily;

@interface UIDevice (Hardware)

- (NSString *) mdf_platform;
- (NSString *) mdf_hwmodel;
- (UIDevicePlatform) mdf_platformType;
- (NSString *) mdf_platformString;
+ (BOOL)mdf_isIphoneX __deprecated_msg("废弃，用'ly_hasFringeScreen'替换");
+ (BOOL)ly_hasFringeScreen;

- (NSUInteger) mdf_cpuFrequency;
- (NSUInteger) mdf_busFrequency;
- (NSUInteger) mdf_cpuCount;
- (NSUInteger) mdf_totalMemory;
- (NSUInteger) mdf_userMemory;

- (NSNumber *) mdf_totalDiskSpace;
- (NSNumber *) mdf_freeDiskSpace;

- (NSString *) mdf_macaddress;

- (BOOL) mdf_hasRetinaDisplay;
- (UIDeviceFamily) mdf_deviceFamily;

- (UIDeviceNetworkType )mdf_networkType;

- (BOOL)mdf_support3DTouch;

+ (NSString *)ly_bundleSeedID;

@end
