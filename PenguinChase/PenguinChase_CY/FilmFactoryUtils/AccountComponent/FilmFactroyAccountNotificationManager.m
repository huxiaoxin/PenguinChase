//
//  FilmFactroyAccountNotificationManager.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/3.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "FilmFactroyAccountNotificationManager.h"

@interface ORAccountInnerObserver : NSObject
@property (nonatomic, weak) NSObject<FilmFactoryAccountObserver> *observer;
@end

@implementation ORAccountInnerObserver
@end

@interface FilmFactroyAccountNotificationManager ()

@property (nonatomic, strong) NSMutableArray *observers;
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation FilmFactroyAccountNotificationManager

+ (void)load
{
    @autoreleasepool {
        [self sharedInstance];
    }
}

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observers = [NSMutableArray array];
        _lock = [[NSRecursiveLock alloc] init];
        
        [self setupNotificationsWhenInit];
    }
    return self;
}

#pragma mark - Notification

- (void)setupNotificationsWhenInit
{
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(loginAccountUserInfoChanged:) name:ORLoginUserInfoChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(accountDidChanged:) name:ORAccountChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(accountDidLogout:) name:ORAccountLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(accountDidLogin:) name:ORAccountLoginSuccessNotification object:nil];
}

- (void)accountDidLogin:(NSNotification *)notification
{
    [self notifyForSelector:@selector(handleAccountLogin:) withObject:nil];
}

- (void)loginAccountUserInfoChanged:(NSNotification *)notification
{
    [self notifyForSelector:@selector(handleLoginUserInfoChanged) withObject:nil];
}

- (void)accountDidLogout:(NSNotification *)notification
{
    [self notifyForSelector:@selector(handleAccountLogout:) withObject:nil];
}

- (void)accountDidChanged:(NSNotification *)notification
{
    [self notifyForSelector:@selector(handleAccountChanged:) withObject:nil];
}

- (void)notifyForSelector:(SEL)sel withObject:(id)object
{
    if (!sel) {
        return;
    }
    
    NSArray *observers = [self.observers mutableCopy];
    
    for (ORAccountInnerObserver *observer in observers) {
        if (observer.observer) {
            BOOL asynNotify = NO;
            if ([observer.observer respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if (!asynNotify) {
                    if ([NSThread isMainThread]) {
                        [observer.observer performSelector:sel withObject:object];
                    } else {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [observer.observer performSelector:sel withObject:object];
                        });
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [observer.observer performSelector:sel withObject:object];
                    });
                }
            }
#pragma clang diagnostic pop
        }
    }
}

#pragma mark - Public Method

- (void)registerObserver:(NSObject<FilmFactoryAccountObserver> *)observer
{
    if (observer && [observer conformsToProtocol:@protocol(FilmFactoryAccountObserver)]) {
        [_lock lock];
        [self cleanUnusedObserver];
        if (![self isObserverExist:observer]) {
            ORAccountInnerObserver *innerObserver = [[ORAccountInnerObserver alloc] init];
            innerObserver.observer = observer;
            [self.observers mdf_safeAddObject:innerObserver];
        }
        [_lock unlock];
    }
}

- (void)cleanUnusedObserver
{
    NSMutableArray *observers = [self.observers mutableCopy];
    NSMutableArray *shouldRemovedObserver = [NSMutableArray array];
    for (ORAccountInnerObserver *innerObserver in observers) {
        if (innerObserver.observer == nil) {
            [shouldRemovedObserver mdf_safeAddObject:innerObserver];
        }
    }
    if (shouldRemovedObserver.count != 0) {
        [self.observers removeObjectsInArray:shouldRemovedObserver];
    }
}

- (BOOL)isObserverExist:(NSObject<FilmFactoryAccountObserver> *)observer
{
    NSMutableArray *observers = [self.observers mutableCopy];
    for (ORAccountInnerObserver *innerObserver in observers) {
        if ([innerObserver.observer isEqual:observer]) {
#ifdef DEBUG
            UIAlertView *alreview = [[UIAlertView alloc] initWithTitle:@"该对象重复注册了" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alreview show];
#endif
            return YES;
        }
    }
    
    return NO;
}

- (void)removeObserver:(NSObject<FilmFactoryAccountObserver> *)observer
{
    [_lock lock];
    NSMutableArray *observers = [self.observers mutableCopy];
    for (ORAccountInnerObserver *innerObserver in observers) {
        if (innerObserver.observer == observer) {
            [self.observers removeObject:innerObserver];
            break;
        }
    }
    [_lock unlock];
}

@end
