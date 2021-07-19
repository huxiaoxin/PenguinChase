//
//  NSURLRequest+MDF.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSURLRequest+MDF.h"

@implementation NSURLRequest (MDF)

- (NSURL*)mdf_url
{
    return self.URL;
}

- (NSString *)mdf_method
{
    return self.HTTPMethod;
}

- (NSDictionary *)mdf_headers
{
    return self.allHTTPHeaderFields;
}

- (NSData *)mdf_body
{
    if (self.HTTPBodyStream) {
        NSInputStream *stream = self.HTTPBodyStream;
        NSMutableData *data = [NSMutableData data];
        [stream open];
        size_t bufferSize = 4096;
        uint8_t *buffer = malloc(bufferSize);
        if (buffer == NULL) {
            [NSException raise:@"NocillaMallocFailure" format:@"Could not allocate %zu bytes to read HTTPBodyStream", bufferSize];
        }
        while ([stream hasBytesAvailable]) {
            NSInteger bytesRead = [stream read:buffer maxLength:bufferSize];
            if (bytesRead > 0) {
                NSData *readData = [NSData dataWithBytes:buffer length:bytesRead];
                [data appendData:readData];
            } else if (bytesRead < 0) {
                [NSException raise:@"NocillaStreamReadError" format:@"An error occurred while reading HTTPBodyStream (%ld)", (long)bytesRead];
            } else if (bytesRead == 0) {
                break;
            }
        }
        free(buffer);
        [stream close];
        
        return data;
    }
    
    return self.HTTPBody;
}

@end
