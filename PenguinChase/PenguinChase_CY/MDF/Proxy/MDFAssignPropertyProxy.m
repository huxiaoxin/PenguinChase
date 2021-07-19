//
//  MDFAssignPropertyProxy.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFAssignPropertyProxy.h"

NSString *const MDFDelegateProxySendMsgToNilNotification = @"MDFDelegateProxySendMsgToNilNotification";

@interface MDFAssignPropertyProxy()

@property (nonatomic, copy) NSString *delegateClsString;
@property (nonatomic, copy) NSString *orignalClassString;

@end

@implementation MDFAssignPropertyProxy

+ (instancetype)safeProxyWithAssignProperty:(id)delegate
{
    return [self safeProxyWithAssignProperty:delegate orignalObject:nil];
}

+ (instancetype)safeProxyWithAssignProperty:(id)delegate orignalObject:(id)object
{
    return [self safeProxyWithAssignProperty:delegate orignalObject:object userInfo:nil];
}

+ (instancetype)safeProxyWithAssignProperty:(id)delegate orignalObject:(id)object userInfo:(NSMutableDictionary *)userInfo
{
    MDFAssignPropertyProxy *proxy = [MDFAssignPropertyProxy alloc];
    proxy.assignProperty = delegate;
    proxy.orignalClassString = NSStringFromClass([object class]);
    proxy.userInfo = userInfo;
    return proxy;
}

- (void)setAssignProperty:(id)delegate
{
    _assignProperty = delegate;
    if (_assignProperty) {
        self.delegateClsString = NSStringFromClass([_assignProperty class]);
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *sig = [self.assignProperty methodSignatureForSelector:sel];
    if (!sig) {
        sig = [NSObject methodSignatureForSelector:@selector(init)];
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //保证不为空了
    if (self.assignProperty){
        [invocation setTarget:self.assignProperty];
        [invocation invoke];
    } else {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
        if (self.delegateClsString) {
            [userInfo setObject:self.delegateClsString forKey:@"DelegateClass"];
        }
        if (self.orignalClassString) {
            [userInfo setObject:self.orignalClassString forKey:@"OrignalClass"];
        }
        if (userInfo.count == 0) {
            userInfo = nil;
        }
        if (self.userInfo) {
            [userInfo addEntriesFromDictionary:self.userInfo];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MDFDelegateProxySendMsgToNilNotification object:nil userInfo:userInfo];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.assignProperty respondsToSelector:aSelector];
}


- (BOOL)isKindOfClass:(Class)aClass {
    BOOL isKind = NO;
    Class tempClass = [self class];
    do {
        if (tempClass == aClass) {
            isKind = YES;
            break;
        }
    } while ((tempClass = class_getSuperclass(tempClass)));
    return isKind;
}

- (void)dealloc
{
    
}

@end
