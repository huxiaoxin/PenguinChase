//
//  MDFAssignPropertyProxy.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//当像一个为空的delegate仍然发送消息时候，就会抛出这个通知
extern NSString *const MDFDelegateProxySendMsgToNilNotification;

@interface MDFAssignPropertyProxy : NSProxy

+ (instancetype)safeProxyWithAssignProperty:(id)delegate;
+ (instancetype)safeProxyWithAssignProperty:(id)delegate orignalObject:(id)object;
+ (instancetype)safeProxyWithAssignProperty:(id)delegate orignalObject:(id)object userInfo:(NSMutableDictionary *)userInfo;

@property (nonatomic, weak) id assignProperty;
@property (nonatomic, strong) NSMutableDictionary *userInfo;

@end

//声明代理对象
#define DEC_IDPASSIGNPROPERTYPROXY(__ClsName)\
@interface __ClsName (_IDPAssignPropertyProxy)\
@property (nonatomic, retain) IDPAssignPropertyProxy *safeProxy;\
@end

//生成代理对象
#define DEF_IDPASSIGNPROPERTYPROXY(__ClsName)\
@implementation __ClsName (_IDPAssignPropertyProxy)\
- (void)setSafeProxy:(IDPAssignPropertyProxy *)safeDelegateProxy\
{\
    objc_setAssociatedObject(self, @selector(safeProxy), safeDelegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}\
- (IDPAssignPropertyProxy *)safeProxy\
{\
    return objc_getAssociatedObject(self, @selector(safeProxy));\
}\
@end

//重载类的assign属性
#define OVERRIDE_READWRITE_ASSIGNPROPERTY(Setter,Getter,AssignPropertyCls)\
- (void)Setter(AssignPropertyCls)delegate\
{\
    if ([super respondsToSelector:@selector(Setter)]) {\
        if (delegate == nil) {\
            [super Setter nil];\
            self.safeProxy.assignProperty = nil;\
            self.safeProxy = nil;\
        }\
    else{\
        if (delegate != self.Getter) {\
            if (!self.safeProxy) {\
                self.safeProxy = [IDPAssignPropertyProxy safeProxyWithAssignProperty:delegate orignalObject:self];\
                [super Setter (AssignPropertyCls)self.safeProxy];\
                return;\
            }\
            self.safeProxy.assignProperty = delegate;\
        }\
    }\
}\
}\
\
- (AssignPropertyCls)Getter\
{\
return self.safeProxy ? (AssignPropertyCls)self.safeProxy.assignProperty : nil;\
}
