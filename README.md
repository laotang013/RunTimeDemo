# RunTimeDemo
一些简单的使用。。
#runTime运行时
1.OC中的一切对象都是类初始化的实例。这个实例是一个对象。实际上一个类本质上也是一个对象。在runTime中用结构体表示。
2.![RunTime运行时](/Users/Start/Downloads/MarkDown/类.png) 
3.类在runtime中的表示
* struct objc_class{
Class isa;指针 表示是一个什么 //实例的isa指向类对象。类对象的isa指向元类
Class super_class; //指向父类
const char*name;//类名
long version; 类名
long info;
long instance_size
struct objc_ivar_list *ivars //成员变量列表
struct objc_method_list **methodLists;//方法列表
struct objc_cache *cache;//缓存 调用过的方法存入缓存列表。下次调用先找缓存。
struct objc_protocol_list *protocols//协议列表
};     



###RunTime的作用:
```
方法调用的本质是让对象发送消息。所有的方法调用在运行时都会转化成运行时语言。
如[person eat ]会被转化成objc_msgSend(person,@selctor(eat));
只有对象才能发送消息所以以objc开头。使用消息机制必须#import<objc/message.h>
```
```
方法的调用流程:
1.调用方法后,会现在对象的cache中查找方法。如果找到就执行。没找到就去对象的方法列表中查找(methodLists)。如果还没找到就会去父类的cache中找。没找到就会父类的方法列表中找。如果一直没找到就转向拦截调用。如果没有重写拦截调用的方法则会报错。    
```
```
获取列表
1.有时候需要知道当前类中的每个属性的名字(比如字典转模型的Key和模型对象的属性名字不匹配)
2.使用runtime的一系列方法获取类的一些信息。(包括属性列表、方法列表、成员变量列表和遵循的协议列表) 需要导入#import <objc/runtime.h>



```
























