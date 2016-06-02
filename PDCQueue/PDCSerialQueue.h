//
//  PDCSerialQueue.h
//  PDCSerialQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^operationBlock)(dispatch_semaphore_t semap);

@interface PDCSerialQueue : NSOperationQueue
/**
 *  一个操作最大消耗时间，为微秒，默认为1000 * 100微秒
 */
@property (assign, nonatomic) __uint32_t operationTime;

/**
 *  队列中最多几个操作，多余的把先进去但未执行的出队，保证进队是最新的操作，默认为4个
 */
@property (assign, nonatomic) __uint16_t operationNum;

/**
 *  初始化方法,也可用 [[NSOperationQueue alloc] init]初始化，
 *
 *  @param operationTime 一个操作耗时，微秒
 *  @param operationNum  队列中最多几个操作
 *
 *  @return self
 */
-(instancetype )initWithOperationTime:(__uint32_t )operationTime operationNum:(__uint16_t )operationNum;

/**
 *  添加操作到队列中
 *
 *  @param block 操作,block参数需要主动通知队列操作是否完成,否则队列会一直等待完成通知
 */
-(void )addOperationBlock:(operationBlock )block;
@end
