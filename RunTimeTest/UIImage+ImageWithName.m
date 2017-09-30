//
//  UIImage+ImageWithName.m
//  RunTimeTest
//
//  Created by Start on 2017/9/30.
//  Copyright © 2017年 Start. All rights reserved.
//

#import "UIImage+ImageWithName.h"
#import <objc/runtime.h>
@implementation UIImage (ImageWithName)
//加载分类到内存的时候调用
+(void)load
{
    //交换方法
    //获取imageWithName方法地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    //获取imageName方法地址
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    //交换方法地址 相当于交换实现方式
    method_exchangeImplementations(imageName,imageWithName);
    
}
+(instancetype)imageWithName:(NSString *)imageStr
{
    UIImage *image = [self imageWithName:imageStr];
    if (image == nil) {
        NSLog(@"加载图片 %@",imageStr);
    }else
    {
        return image;
    }
    return image;
}
@end
