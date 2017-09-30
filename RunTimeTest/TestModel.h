//
//  TestModel.h
//  RunTimeTest
//
//  Created by Start on 2017/9/30.
//  Copyright © 2017年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TestModelProtocol<NSObject>
@required
@optional
-(void)getTestModelStr:(NSString *)str;
@end
@interface TestModel : NSObject<TestModelProtocol>
/**name*/
@property(nonatomic,copy)NSString *name;
@end
