//
//  UIImage+Str.m
//  99fenqi
//
//  Created by ChenYuan on 16/5/6.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import "UIImage+Str.h"

@implementation UIImage (Str)
+ (instancetype)imageWithBase64:(NSString *)imageStr {
    UIImage *image;
    if (imageStr.length > 0) {
        NSData *decodeImageData = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (decodeImageData) {
            image = [self imageWithData:decodeImageData];
        }
    }else {
        NSLog(@"base64字符串为''");
    }
    return image;
}

+ (void)imageWithBase64:(NSString *)imageStr completion:(void (^)(UIImage *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self imageWithBase64:imageStr];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    });
}

- (NSString *)base64 {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodeImageStr = [data base64EncodedStringWithOptions:0];
    return encodeImageStr;
}
@end
