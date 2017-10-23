//
//  KVOController.m
//  ZYKVO
//
//  Created by 钱志义 on 2017/10/22.
//  Copyright © 2017年 QIngFeng. All rights reserved.
//

#import "KVOController.h"

@interface KVOUnitInfo : NSObject
@property (nonatomic,copy) NSString *keyPath;
@property (nonatomic,strong) NSObject *beObserved;
@property (nonatomic,copy,readonly) kvoCallBack block;
- (instancetype)initWithBlock:(kvoCallBack)block;
@end

@implementation KVOUnitInfo
- (instancetype)initWithBlock:(kvoCallBack)block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if (_block) {
        _block(keyPath,object,change);
    }
}
@end

@interface KVOController ()
@property (nonatomic,strong) NSMutableDictionary *keyPathObserversDic;
@end

@implementation KVOController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _keyPathObserversDic = self.keyPathObserversDic;
    }
    return self;
}

- (NSMutableDictionary *)keyPathObserversDic{
    if (!_keyPathObserversDic) {
        _keyPathObserversDic = [NSMutableDictionary dictionary];
    }
    return _keyPathObserversDic;
}

- (void)observe:(NSObject *)beObserved forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block{
    NSAssert(keyPath, @"keyPath shoule not be nil");
    
    KVOUnitInfo *unit = [[KVOUnitInfo alloc]initWithBlock:block];
    unit.keyPath = keyPath;
    unit.beObserved = beObserved;
    
    @synchronized(self.keyPathObserversDic) {
        NSMutableArray *keyPathObservers = self.keyPathObserversDic[keyPath];
        if (!keyPathObservers) {
            keyPathObservers = [NSMutableArray array];
            self.keyPathObserversDic[keyPath] = keyPathObservers;
        }
        [keyPathObservers addObject:unit];
    }
    
    [beObserved addObserver:unit forKeyPath:keyPath options:options context:NULL];
}

- (void)observe:(NSObject *)beObserved forKeyPathSet:(NSMutableSet <NSString *>*)keyPathSet options:(NSKeyValueObservingOptions)options usingBlock:(kvoCallBack)block{
    for (NSString *keyPath in keyPathSet) {
        [self observe:beObserved forKeyPath:keyPath options:options usingBlock:block];
    }
}

- (void)_uninstallObserver{
    for (NSString *keyPath in self.keyPathObserversDic.allKeys) {
        NSArray *observers = self.keyPathObserversDic[keyPath];
        for (KVOUnitInfo *unit in observers) {
            [unit.beObserved removeObserver:unit forKeyPath:unit.keyPath];
        }
    }
}

- (void)dealloc{
    [self _uninstallObserver];
}
@end
