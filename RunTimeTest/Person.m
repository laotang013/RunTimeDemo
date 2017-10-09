//
//  Person.m
//  RunTimeTest
//
//  Created by Start on 2017/10/9.
//  Copyright © 2017年 Start. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person
// 默认方法都有两个隐式参数，
void eat(id self,SEL sel)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}
//当一个对象调用未实现的方法,会调用这个方法处理。并且会把对应的方法列表传过来
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), (IMP)eat,"v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}


@end
