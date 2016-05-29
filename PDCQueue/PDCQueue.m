//
//  PDCQueue.m
//  PDCQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "PDCQueue.h"

dispatch_queue_t queue_serial = NULL;   //创建串行队列

@implementation PDCQueue
+(void )gcd_safeQueue:(dispatch_queue_t )queue setBlock:(block )set getBlock:(block )get
{
    dispatch_async(queue, ^{
        set();
    });
    
    /* 等待queue里面的block执行才会执行这里 */
    dispatch_barrier_async(queue, ^{
        get();
    });
}

+(void )gcd_safeQueue:(dispatch_queue_t )queue semaphore:(dispatch_semaphore_t )semaphore setBlock:(block )set getBlock:(block )get
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待下次信号
    dispatch_async(queue, ^{
        set();
        dispatch_semaphore_signal(semaphore);   //发送信号，取消等待
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);   //等待下次信号
    dispatch_async(queue, ^{
        get();
        dispatch_semaphore_signal(semaphore);   //发送信号，取消等待
    });
}

+(void )gcd_SerialQueueBlock1:(block )block1 block2:(block )block2
{
    if (!queue_serial)
    {
        @autoreleasepool {
            queue_serial = dispatch_queue_create("doublecheck.pdc.serial.queue", DISPATCH_QUEUE_SERIAL);
        }
    }
    
    /* 串行队列按顺序执行 */
    dispatch_async(queue_serial, ^{
        block1();
    });
    
    dispatch_async(queue_serial, ^{
        block2();
    });
}
@end
