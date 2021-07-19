//
//  MDFObserverManger.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/10/27.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFObserverManger.h"

#pragma mark MDFSubscriberModel
@interface MDFSubscriberModel : NSObject
@property (nonatomic, weak) NSObject *object;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) MDFComponet componet;
- (instancetype)initWithObjc:(NSObject *)object keyPath:(NSString *)keyPath componet:(MDFComponet)componet;
@end

@implementation MDFSubscriberModel

- (instancetype)initWithObjc:(NSObject *)object keyPath:(NSString *)keyPath componet:(MDFComponet)componet {
    if (self = [super init]) {
        self.object = object;
        self.keyPath = keyPath;
        self.componet = componet;
    }
    return self;
}

@end

#pragma mark MDFObserverManger
@interface MDFObserverManger ()
@property (nonatomic, strong) NSMutableArray<MDFSubscriberModel *> *array;
@end
@implementation MDFObserverManger
+ (void)subscribeToObjc:(NSObject *)objc serveOfKeyPath:(NSString *)keyPath componet:(MDFComponet)componet {
    MDFObserverManger *objserver = [self sharedInstance];
    [objc addObserver:objserver forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    MDFSubscriberModel *subscriber = [[MDFSubscriberModel alloc] initWithObjc:objc keyPath:keyPath componet:componet];
    [objserver.array addObject:subscriber];
}

+ (void)unsbscribeToObjc:(NSObject *)objc serveOfKeyPath:(NSString *)keyPath {
    MDFObserverManger *objserver = [self sharedInstance];
    __block BOOL isExistSbscriber = NO;
    __block NSUInteger index;
    [objserver checkSubscriber:objc keyPath:keyPath result:^(BOOL isExist, NSUInteger idx, MDFSubscriberModel *subscriber) {
        isExistSbscriber = isExist;
        index = idx;
    }];
    if (isExistSbscriber) {
        [objserver.array removeObjectAtIndex:index];
        [objc removeObserver:objserver forKeyPath:keyPath context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self checkSubscriber:object keyPath:keyPath result:^(BOOL isExist, NSUInteger idx, MDFSubscriberModel *subscriber) {
        if (isExist && subscriber.componet) {
            subscriber.componet(change);
        }
    }];
}

- (void)checkSubscriber:(NSObject *)objc keyPath:(NSString *)keyPath result:(void(^)(BOOL isExist, NSUInteger idx, MDFSubscriberModel *subscriber))result {
    __block BOOL isExist = NO;
    __block NSUInteger index = NSNotFound;
    __block MDFSubscriberModel *subscriber = nil;
    if (!objc || !keyPath || keyPath.length == 0) {
        isExist = NO;
        index = NSNotFound;
        subscriber = nil;
    } else {
        NSMutableArray *subscriberModels = [self.array mutableCopy];
        [subscriberModels enumerateObjectsUsingBlock:^(MDFSubscriberModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.object isEqual:objc] && [obj.keyPath isEqualToString:keyPath]) {
                isExist = YES;
                index = idx;
                subscriber = obj;
                *stop = YES;
            }
        }];
    }
    if (result) {
        result(isExist, index, subscriber);
    }
}

- (NSMutableArray<MDFSubscriberModel *> *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
