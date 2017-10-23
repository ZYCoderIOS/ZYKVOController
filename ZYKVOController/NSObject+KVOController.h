//
//  NSObject+KVOController.h
//  ZYKVO
//
//  Created by 钱志义 on 2017/10/22.
//  Copyright © 2017年 QIngFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVOController.h"

#define KVOClassKeyPath(CLASS, KEYPATH) \
@((((CLASS *)(nil)).KEYPATH, #KEYPATH))

@interface NSObject (KVOController)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block;

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath usingBlock:(kvoBriefCallBack)block;

- (void)addObserver:(NSObject *)observer forKeyPathSet:(NSSet <NSString *>*)keyPathSet options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block;
@end
