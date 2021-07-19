//
//  MDFSingletonSerialProxy.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSingletonSerialProxy.h"

@interface MDFSingletonSerialProxy ()

@property (nonatomic, strong) id proxied;
@property (nonatomic,strong) dispatch_queue_t queue;

@end

@implementation MDFSingletonSerialProxy

+ (instancetype)singletonSerialProxy:(id)proxied
{
    MDFSingletonSerialProxy *proxy =  [MDFSingletonSerialProxy alloc];
    proxy.proxied = proxied;
    return proxy;
}

- (dispatch_queue_t)queue
{
    @synchronized (self) {
        if (!_queue) {
            _queue = dispatch_queue_create([[NSString stringWithFormat:@"com.mdf.singletonserialproxy.%@",NSStringFromClass([self.proxied class])] UTF8String], DISPATCH_QUEUE_SERIAL);
            dispatch_queue_set_specific(_queue,"currentQueue",(__bridge void *)(_queue),NULL);
        }
    }
    return _queue;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.proxied methodSignatureForSelector:sel];
}

//TODO: 禁止单例互相调用 互相调用的用回调 异步执行回调
//目前采用顺序队列的方式 实现线程安全会有以下问题
//已知问题 1.如果两个单例互相访问 并且同时有两个线程 分别执行这两个单例中的方法 会死锁
//已知问题 2.如果两个单例互相访问 同一线程中 A:A->B:B->A:C 会死锁 虽然是同线程 但是不是同队列
//如果改为递归锁 问题2可以解决 但是会无法保证函数执行顺序 也就是A还未执行完毕 C却先执行完了 这样的话 如果A有一个for循环 C里做了数组的删除 一样会崩溃
- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *currentContext = dispatch_get_specific("currentQueue");
    if (currentContext != NULL && (__bridge dispatch_queue_t)currentContext == self.queue) {
        [invocation invokeWithTarget:self.proxied];
    } else {
        dispatch_sync(self.queue, ^{
            [invocation invokeWithTarget:self.proxied];
        });
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.proxied respondsToSelector:aSelector];
}

@end
