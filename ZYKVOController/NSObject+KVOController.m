//
//  NSObject+KVOController.m
//  ZYKVO
//
//  Created by 钱志义 on 2017/10/22.
//  Copyright © 2017年 QIngFeng. All rights reserved.
//

#import "NSObject+KVOController.h"
#import "KVOController.h"
#import <objc/runtime.h>

@implementation NSObject (KVOController)

- (KVOController *)kvoController{
    KVOController *obj = objc_getAssociatedObject(self, @selector(kvoController));
    if (!obj) {
        obj = [[KVOController alloc]init];
        objc_setAssociatedObject(self, @selector(kvoController), obj, OBJC_ASSOCIATION_RETAIN);
    }
    return obj;
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block{
    [observer.kvoController observe:self forKeyPath:keyPath options:options usingBlock:block];
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath usingBlock:(kvoBriefCallBack)block{
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld usingBlock:^(NSString *keyPath, id object, NSDictionary<NSKeyValueChangeKey,id> *change) {
        
        id newValue = change[NSKeyValueChangeNewKey];
        id oldValue = change[NSKeyValueChangeOldKey];
        
        if ([newValue isKindOfClass:[NSNull class]]) {
            newValue = nil;
        }
        
        if ([oldValue isKindOfClass:[NSNull class]]) {
            oldValue = nil;
        }
        block(newValue,oldValue);
    }];
}

- (void)addObserver:(NSObject *)observer forKeyPathSet:(NSSet <NSString *>*)keyPathSet options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block{
    for (NSString *keyPath in keyPathSet) {
        [self addObserver:observer forKeyPath:keyPath options:options usingBlock:block];
    }
}
@end
