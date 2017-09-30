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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self test];
    //[self test1];
    //[self test2];
    [self test4];
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
@end
