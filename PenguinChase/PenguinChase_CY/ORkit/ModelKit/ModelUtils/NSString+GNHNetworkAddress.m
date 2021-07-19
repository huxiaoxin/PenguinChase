//
//  NSString+GNHNetworkAddress.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/13.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSString+GNHNetworkAddress.h"

@implementation NSString (GNHNetworkAddress)

#pragma mark - appClient HttpSever

+ (NSString *)gnh_httpServerHost:(GNHBaseURLType)urlType
{
    // 是否使用https, 自己指定http或者https，https不需要填写端口号
    NSString *hostProtocal = @"https";
    
    BOOL isOnline = YES;
    BOOL isDevServer = NO;
    BOOL isPreServer = NO;

    NSString *address = nil;
    if (isOnline) {
        switch (urlType) {
            case GNHBaseURLTypeClient:
            default:
                address = [NSString stringWithFormat:@"%@://%@", hostProtocal, @"api.iorange99.com/"];
                break;
        }
    } else if (isDevServer) {
        switch (urlType) {
            case GNHBaseURLTypeClient:
            default:
                address = [NSString stringWithFormat:@"%@://%@", hostProtocal, @"api-dev.iorange99.com/"];
//                address = [NSString stringWithFormat:@"%@://%@", hostProtocal, @"152.136.208.103:9000/"];
//                address = [NSString stringWithFormat:@"%@://%@", hostProtocal, @"180.76.58.226:9001/"];
                
                break;
        }
    } else if (isPreServer) {
        switch (urlType) {
            case GNHBaseURLTypeClient:
            default:
                address = [NSString stringWithFormat:@"%@://%@", hostProtocal, @"180.76.58.226:9001/"];
                break;
        }
    }
    
    return address;
}

#pragma mark - H5 HttpSever

+ (NSString *)gnh_httpAppHost:(GNHBaseURLType)urlType
{
    NSString *hostProtocal = @"http";
    BOOL isOnline = YES;
    BOOL isH5PreServer = NO;
    BOOL isH5DevServer = NO;

    if (isOnline) {
        return [NSString stringWithFormat:@"%@://%@", hostProtocal, @"api.iorange99.com/"];
    } else if (isH5PreServer) {
        return [NSString stringWithFormat:@"%@://%@", hostProtocal, @"api.iorange99.com/"];
    } else if (isH5DevServer) {
        return [NSString stringWithFormat:@"%@://%@", hostProtocal, @"api.iorange99.com/"];
    }
    
    return nil;
}

+ (NSString *)gnh_serverBaseURL:(GNHBaseAPIType)type
{
    return nil;
}

+ (NSString *)gnh_addressWithString:(NSString *)address
{
    return [self gnh_addressWithString:address baseURLType:GNHBaseAPITypeUnknow];
}

+ (NSString *)gnh_addressWithString:(NSString *)address baseURLType:(GNHBaseAPIType)apiTpye
{
    return apiTpye ? [NSString stringWithFormat:@"%@%@", [self gnh_serverBaseURL:apiTpye], address] : address;
}

+ (NSString *)gnh_h5AddressWithString:(NSString *)address baseURLType:(GNHBaseURLType)apiTpye
{    
    return [NSString stringWithFormat:@"%@%@", [self gnh_httpAppHost:apiTpye], address];
}

@end
