//
//  ViewController.m
//  RunTimeTest
//
//  Created by Start on 2017/9/30.
//  Copyright © 2017年 Start. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "TestModel.h"
#import "UIImage+ImageWithName.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self test];
    //[self test1];
    //[self test2];
    [self test6];
}


/**获取属性列表*/
-(void)test
{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([TestModel class], &count);
    
    for(unsigned int  i=0; i<count;i++){
        
        const char*propertyName = property_getName(propertyList[i]);
        
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
}

/**获取方法列表*/
-(void)test1
{
    unsigned int count;
    Method *methodList = class_copyMethodList([TestModel class], &count);
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method-->%@",NSStringFromSelector(method_getName(method)));
    }
}
/**获取成员变量列表*/
-(void)test2
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([TestModel class], &count);
    for (int i=0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar--->%@",[NSString stringWithUTF8String:ivarName]);
   
    }
}
/**获取协议列表*/
-(void)test3
{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([TestModel class], &count);
    for (int i=0; i<count; i++) {
        Protocol *myProtocol = protocolList[i];
        const char *protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol--->%@",[NSString stringWithUTF8String:protocolName]);
    }
}
/**交换方法*/
//1.系统自带的方法功能不够，给系统的自带的方法扩展一些功能。2.继承系统的类。重写方法 使用runtime交换方法
-(void)test4
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(50, 100, 100, 100);
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"moreWhite2"];
}
/**动态添加方法*/
//1.动态添加方法
-(void)test5
{
    Person *p = [[Person alloc]init];
    //默认person没有实现eat方法可以通过performSelector调用，但会报错。 动态添加方法就不会报错了。
    [p performSelector:@selector(eat)];
}
/**动态增加一个类*/
-(void)test6
{
    //添加一个类
    Class classStudent = objc_allocateClassPair([self class], "Student", 0);
    //添加一个NSString的变量
    if (class_addIvar(classStudent, "schoolName", sizeof(NSString *), 0, "@")) {
        NSLog(@"添加成员变量schoolName成功");
    }
    //添加一个方法
    if (class_addMethod(classStudent, @selector(printSchool), (IMP)(printSchool), "v@:")) {
        NSLog(@"添加方法printSchool成功");
    }
    //注册这个类到runtime系统中
    objc_registerClassPair(classStudent);
    //创建类
    id student = [[classStudent alloc]init];
    NSString *schoolName = @"福建师范大学";
    [student setValue:schoolName forKey:@"schoolName"];
    [student performSelector:@selector(printSchool) withObject:nil];
}
void printSchool(id self, SEL _cmd)
{
    NSLog(@"学校名字是%@",[self valueForKey:@"schoolName"]);
}
@end
