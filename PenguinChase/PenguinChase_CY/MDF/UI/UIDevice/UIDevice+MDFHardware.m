//
//  UIDevice+Hardware.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/5/16.
//  Copyright © 2017年 GNH. All rights reserved.
//
//

#import "UIDevice+MDFHardware.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (Hardware)

+ (void)load
{
    @autoreleasepool {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
}

#pragma mark sysctlbyname utils
- (NSString *) mdf_getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *) mdf_platform
{
    return [self mdf_getSysInfoByName:"hw.machine"];
}


// Thanks, Tom Harrington (Atomicbird)
- (NSString *) mdf_hwmodel
{
    return [self mdf_getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger) mdf_cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) mdf_busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) mdf_cpuCount
{
    return [self getSysInfo:HW_NCPU];
}

- (NSUInteger) mdf_totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) mdf_userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!

/*
 extern NSString *NSFileSystemSize;
 extern NSString *NSFileSystemFreeSize;
 extern NSString *NSFileSystemNodes;
 extern NSString *NSFileSystemFreeNodes;
 extern NSString *NSFileSystemNumber;
 */

- (NSNumber *) mdf_totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *) mdf_freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark platform type and name utils
- (UIDevicePlatform) mdf_platformType
{
    NSString *platform = [self mdf_platform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([platform hasPrefix:@"iPhone5,1"])          return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone5,2"])          return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone5,3"])          return UIDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone5,4"])          return UIDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone6"])            return UIDevice5SiPhone;
    if ([platform hasPrefix:@"iPhone7,1"])          return UIDevice6PlusiPhone;
    if ([platform hasPrefix:@"iPhone7,2"])          return UIDevice6iPhone;
    if ([platform hasPrefix:@"iPhone8,1"])          return UIDevice6SiPhone;
    if ([platform hasPrefix:@"iPhone8,2"])          return UIDevice6SPlusiPhone;
    if ([platform hasPrefix:@"iPhone8,4"])          return UIDeviceSEiPhone;
    if ([platform hasPrefix:@"iPhone9,1"])          return UIDevice7iPhone;
    if ([platform hasPrefix:@"iPhone9,2"])          return UIDevice7PlusiPhone;
    
    if ([platform hasPrefix:@"iPhone10,1"])         return UIDeviceiPhone_8_China_Japan;
    if ([platform hasPrefix:@"iPhone10,4"])         return UIDeviceiPhone_8_Global;
    if ([platform hasPrefix:@"iPhone10,2"])         return UIDeviceiPhone_8Plus_China_Japan;
    if ([platform hasPrefix:@"iPhone10,5"])         return UIDeviceiPhone_8Plus_Global;
    if ([platform hasPrefix:@"iPhone10,3"])         return UIDeviceiPhone_X_China_Japan;
    if ([platform hasPrefix:@"iPhone10,6"])         return UIDeviceiPhone_X_Global;
    if ([platform hasPrefix:@"iPhone11,8"])         return UIDeviceiPhone_XR_Global;
    if ([platform hasPrefix:@"iPhone11,2"])         return UIDeviceiPhone_XS_Global;
    if ([platform hasPrefix:@"iPhone11,6"])         return UIDeviceiPhone_XSMax_China;
    if ([platform hasPrefix:@"iPhone11,4"])         return UIDeviceiPhone_XSMax_Global;
    if ([platform hasPrefix:@"iPhone12,1"])         return UIDeviceiPhone_11_Global;
    if ([platform hasPrefix:@"iPhone12,3"])         return UIDeviceiPhone_11Pro_China;
    if ([platform hasPrefix:@"iPhone12,5"])         return UIDeviceiPhone_11ProMax_Global;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    if ([platform hasPrefix:@"iPod5"])              return UIDevice5GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad3"])              return UIDevice3GiPad;
    if ([platform hasPrefix:@"iPad4"])              return UIDevice4GiPad;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

- (NSString *) mdf_platformString
{
    switch ([self mdf_platformType])
    {
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone: return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
        case UIDevice5CiPhone: return IPHONE_5C_NAMESTRING;
        case UIDevice5SiPhone: return IPHONE_5S_NAMESTRING;
        case UIDevice6iPhone: return IPHONE_6_NAMESTRING;
        case UIDevice6PlusiPhone: return IPHONE_6_PLUS_NAMESTRING;
        case UIDevice6SiPhone: return IPHONE_6S_NAMESTRING;
        case UIDevice6SPlusiPhone: return IPHONE_6S_PLUS_NAMESTRING;
        case UIDeviceSEiPhone: return IPHONE_SE_NAMESTRING;
        case UIDevice7iPhone: return IPHONE_7_NAMESTRING;
        case UIDevice7PlusiPhone: return IPHONE_7_PLUS_NAMESTRING;
        case UIDeviceiPhone_8_China_Japan: return IPHONE_8_NAMESTRING;
        case UIDeviceiPhone_8_Global: return IPHONE_8_Global_NAMESTRING;
        case UIDeviceiPhone_8Plus_China_Japan: return IPHONE_8PLUS_NAMESTRING;
        case UIDeviceiPhone_8Plus_Global: return IPHONE_8PLUS_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_X_China_Japan: return IPHONE_X_NAMESTRING;
        case UIDeviceiPhone_X_Global: return IPHONE_X_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_XR_Global: return IPHONE_XR_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_XS_Global: return IPHONE_XS_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_XSMax_China: return IPHONE_XSMax_NAMESTRING;
        case UIDeviceiPhone_XSMax_Global: return IPHONE_XSMax_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_11_Global: return IPHONE_11_GLOBAL_NAMESTRING;
        case UIDeviceiPhone_11Pro_China: return IPHONE_11PRO_NAMESTRING;
        case UIDeviceiPhone_11ProMax_Global: return IPHONE_11PROMAX_NAMESTRING;
            
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod: return IPOD_5G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

- (BOOL) mdf_hasRetinaDisplay
{
    return ([UIScreen mainScreen].scale >= 2.0f);
}

- (UIDeviceFamily) mdf_deviceFamily
{
    NSString *platform = [self mdf_platform];
    if ([platform hasPrefix:@"iPhone"]) return UIDeviceFamilyiPhone;
    if ([platform hasPrefix:@"iPod"]) return UIDeviceFamilyiPod;
    if ([platform hasPrefix:@"iPad"]) return UIDeviceFamilyiPad;
    if ([platform hasPrefix:@"AppleTV"]) return UIDeviceFamilyAppleTV;
    
    return UIDeviceFamilyUnknown;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
- (NSString *) mdf_macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return outstring;
}

- (UIDeviceNetworkType)mdf_networkType
{
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        return UIDeviceNetworkTypeUnReachable;
    }
    else if ([[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi]){
        return UIDeviceNetworkTypeWifi;
    }
    else if ([[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN]){
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        if ([networkInfo respondsToSelector:@selector(currentRadioAccessTechnology)]) {
            NSString *currRadioAccessTech = networkInfo.currentRadioAccessTechnology;
            if ([currRadioAccessTech isEqualToString:CTRadioAccessTechnologyGPRS] ||
                [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyEdge]) {
                return UIDeviceNetworkType2G;
            }else if ([currRadioAccessTech isEqualToString:CTRadioAccessTechnologyWCDMA] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyHSDPA] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyHSUPA] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyCDMA1x] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
                      [currRadioAccessTech isEqualToString:CTRadioAccessTechnologyeHRPD]) {
                return UIDeviceNetworkType3G;
            }else if ([currRadioAccessTech isEqualToString:CTRadioAccessTechnologyLTE]){
                return UIDeviceNetworkType4G;
            }else{
                return UIDeviceNetworkType4G;
            }
        }
        return UIDeviceNetworkTypeOther;
    }
    
    return UIDeviceNetworkTypeOther;
}

+ (BOOL)mdf_isIphoneX {
    return [self ly_hasFringeScreen];
}

+ (BOOL)ly_hasFringeScreen {
    BOOL isFringeScreen = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return isFringeScreen;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        if (window.safeAreaInsets.bottom > 0.0) {
            isFringeScreen = YES;
        }
    }
    return isFringeScreen;
}

- (BOOL)mdf_support3DTouch
{
    BOOL isPhone3DTouch = [self.mdf_platformString isEqualToString:IPHONE_6S_PLUS_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_6S_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_7_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_7_PLUS_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_8_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_8_Global_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_8PLUS_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_8PLUS_GLOBAL_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_X_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_X_GLOBAL_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_XR_GLOBAL_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_XS_GLOBAL_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_XSMax_NAMESTRING] ||
    [self.mdf_platformString isEqualToString:IPHONE_XSMax_GLOBAL_NAMESTRING];
    BOOL isSimulator3DTouch;
    
    if ([self.mdf_platformString isEqualToString:SIMULATOR_NAMESTRING] || [self.mdf_platformString isEqualToString:SIMULATOR_IPHONE_NAMESTRING]) {
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            isSimulator3DTouch = YES;
        } else {
            isSimulator3DTouch = NO;
        }
#endif
    } else {
        isSimulator3DTouch = NO;
    }
    
    return isPhone3DTouch || isSimulator3DTouch;
}

+ (NSString *)ly_bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (id)kSecClassGenericPassword, kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound) {
        status = SecItemAdd((CFDictionaryRef)query, (CFTypeRef *)&result);
    }
    if (status != errSecSuccess) {
        return nil;
    }
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(id)kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

@end
