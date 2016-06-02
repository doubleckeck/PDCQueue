//
//  QoSClass.m
//  PDCQueue
//
//  Created by KH on 16/6/1.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "QoSClass.h"

@implementation QoSClass

-(void )viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 线程优先级 */
    //    *	- QOS_CLASS_USER_INTERACTIVE
    //    *	- QOS_CLASS_USER_INITIATED
    //    *	- QOS_CLASS_DEFAULT
    //    *	- QOS_CLASS_UTILITY
    //    *	- QOS_CLASS_BACKGROUND
    //    *	- QOS_CLASS_UNSPECIFIED
    
    //    NSInteger i = 0;
    dispatch_queue_t queue = dispatch_queue_create("queue", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,QOS_CLASS_DEFAULT,-1));
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,QOS_CLASS_UTILITY,-1));             //中
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,QOS_CLASS_USER_INTERACTIVE,-1));    //很高
    dispatch_queue_t queue3 = dispatch_queue_create("queue3", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,QOS_CLASS_BACKGROUND,-1));          //低
    
    //    dispatch_set_target_queue(queue1, queue);
    //    dispatch_set_target_queue(queue2, queue);
    //    dispatch_set_target_queue(queue3, queue);
    
    dispatch_async(queue1, ^{
        for (NSUInteger i = 0; i < 20; i++)
        {
            NSLog(@"queue - 1 ----------------%@",@(i));    //执行时间片居中
        }
    });
    
    dispatch_async(queue2, ^{
        for (NSUInteger i = 0; i < 20; i++)
        {
            NSLog(@"queue - 2 ----------------%@",@(i));    //执行时间片最多
        }
    });
    
    dispatch_async(queue3, ^{
        for (NSUInteger i = 0; i < 20; i++)
        {
            NSLog(@"queue - 3 ----------------%@",@(i));    //执行时间片最少
        }
    });
}

@end
