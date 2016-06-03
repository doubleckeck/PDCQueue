//
//  PDCQueueFuntion.h
//  PDCQueue
//
//  Created by KH on 16/6/3.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PDC_FUNTION_EXTERN extern

typedef void(^block_bool)(BOOL *finish);

/**
 *  线程安全方法1
 *
 *  @param queue 必须是dispath_queue_create()创建的队列，并且是并行队列
 *  @param set   设置
 *  @param get   获取，设置调用之后（不是里面的任务执行完成）才会调用获取
 */
PDC_FUNTION_EXTERN
void gcd_safeQueue1(dispatch_queue_t queue,block set,block get);

/**
 *  线程安全方法2
 *
 *  @param queue     并行队列
 *  @param semaphore 信号
 *  @param set       设置
 *  @param get       获取，设置调用之后（不是里面的任务执行完成）才会调用获取
 */
PDC_FUNTION_EXTERN
void gcd_safeQueue2(dispatch_queue_t queue,dispatch_semaphore_t semaphore,block set,block get);

/**
 *  异步串行队列，按顺序执行,两个回调间隔添加到队列执行
 *
 *  @param block1 先执行
 *  @param block2 后执行
 */
PDC_FUNTION_EXTERN
void gcd_asynSerialQueueBlocks(block block1, block block2);

/**
 *  异步串行队列
 *
 *  @param block           执行的任务
 *  @param block_next_time 下次任务间隔时间
 */
PDC_FUNTION_EXTERN
void gcd_asynSerialQueue(NSTimeInterval block_next_time, block_bool block);