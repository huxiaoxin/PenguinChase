//
//  MDFNetworkModelProtocol.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MDFBaseModelState) {
    MDFBaseModelStateUnset,
    MDFBaseModelStateLoading,
    MDFBaseModelStateFail,
    MDFBaseModelStateSuccess,
    MDFBaseModelStateCancel,
    MDFBaseModelStatePause
};

@protocol MDFNetworkModelProtocol;
@class AFHTTPRequestOperation;

typedef void(^MDFBaseNetworkModelCompletionBlock)(id<MDFNetworkModelProtocol>);

@protocol MDFNetworkModelProtocol <NSObject>

//request
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSDictionary *params;

//state
@property (nonatomic, assign) MDFBaseModelState state;

//response
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) MDFBaseNetworkModelCompletionBlock completionBlock;

//method
- (BOOL)load;
- (void)cancel;
- (void)pause;
- (void)resume;
- (BOOL)isLoading;

@end
