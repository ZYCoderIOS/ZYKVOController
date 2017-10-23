//
//  KVOController.h
//  ZYKVO
//
//  Created by 钱志义 on 2017/10/22.
//  Copyright © 2017年 QIngFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^kvoCallBack)(NSString * keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> * change);

typedef void (^kvoBriefCallBack)(id newValue,id oldValue);

@interface KVOController : NSObject
- (void)observe:(NSObject *)beObserved forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block;

- (void)observe:(NSObject *)beObserved forKeyPathSet:(NSMutableSet <NSString *>*)keyPathSet options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block;
@end
