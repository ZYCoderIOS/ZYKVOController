# ZYKVOController
优雅实现KVO
```
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
```
结果
```
2017-10-23 16:40:19.536083+0800 ZYKVO[71614:5306175]
keyPath:name
object:<ZYObject: 0x10040d6e0>
change:{
kind = 1;
new = value2;
old = value1;
}
2017-10-23 16:40:19.536391+0800 ZYKVO[71614:5306175]
newValue:value2
oldValue:value1
2017-10-23 16:40:19.536552+0800 ZYKVO[71614:5306175]
keyPath:name
object:<ZYObject: 0x10040d6e0>
change:{
kind = 1;
new = value2;
old = value1;
}
2017-10-23 16:40:19.536670+0800 ZYKVO[71614:5306175]
keyPath:age
object:<ZYObject: 0x10040d6e0>
change:{
kind = 1;
new = 27;
old = 26;
}
2017-10-23 16:40:19.536721+0800 ZYKVO[71614:5306175] ZYObserver对象被释放
2017-10-23 16:40:19.536874+0800 ZYKVO[71614:5306175] ZYObject 被释放
```
支持pod
>pod  ZYKVOController
