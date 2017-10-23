//
//  main.m
//  ZYKVO
//
//  Created by 钱志义 on 2017/10/22.
//  Copyright © 2017年 QIngFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYObject.h"
#import "ZYObserver.h"
#import "NSObject+KVOController.h"

void testFBKVOController(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ZYObject *obj = [[ZYObject alloc]init];
        ZYObserver *observer = [[ZYObserver alloc]init];
        
        obj.name = @"value1";
        obj.age = 26;
        
        [obj addObserver:observer forKeyPath:KVOClassKeyPath(ZYObject,name) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld usingBlock:^(NSString *keyPath, id object, NSDictionary<NSKeyValueChangeKey,id> *change) {
            NSLog(@"\nkeyPath:%@\nobject:%@\nchange:%@",keyPath,object,change);
        }];

        [obj addObserver:observer forKeyPath:KVOClassKeyPath(ZYObject,name) usingBlock:^(id newValue, id oldValue) {
            NSLog(@"\nnewValue:%@\noldValue:%@\n",newValue,oldValue);
        }];
        
        NSSet *set = [NSSet setWithArray:@[KVOClassKeyPath(ZYObject,name),KVOClassKeyPath(ZYObject,age)]];
        [obj addObserver:observer forKeyPathSet:set options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld usingBlock:^(NSString *keyPath, id object, NSDictionary<NSKeyValueChangeKey,id> *change) {
            NSLog(@"\nkeyPath:%@\nobject:%@\nchange:%@",keyPath,object,change);
        }];
        
        obj.name = @"value2";
        observer.name = @"value3";
        obj.age = 27;
    }
    return 0;
}

