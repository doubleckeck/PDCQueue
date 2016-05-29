//
//  PDCQueue.h
//  PDCQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDCOperation.h"

typedef void(^block)();

@interface PDCQueue : NSObject
/**
 *  线程安全方法1
 *
 *  @param queue 必须是dispath_queue_create()创建的队列，并且是并行队列
 *  @param set   设置
 *  @param get   获取，设置调用之后（不是里面的任务执行完成）才会调用获取
 */
+(void )gcd_safeQueue:(dispatch_queue_t )queue setBlock:(block )set getBlock:(block )get;

/**
 *  线程安全方法2
 *
 *  @param queue     并行队列
 *  @param semaphore 信号
 *  @param set       设置
 *  @param get       获取，设置调用之后（不是里面的任务执行完成）才会调用获取
 */
+(void )gcd_safeQueue:(dispatch_queue_t )queue semaphore:(dispatch_semaphore_t )semaphore setBlock:(block )set getBlock:(block )get;

/**
 *  异步串行队列，按顺序执行,两个回调间隔添加到队列执行
 *
 *  @param block1 先执行
 *  @param block2 后执行
 */
+(void )gcd_SerialQueueBlock1:(block )block1 block2:(block )block2;
@end
