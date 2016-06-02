//
//  NSArray+PDCKit.h
//  PDCQueue
//
//  Created by KH on 16/6/1.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^block_array)(NSInteger index,id obj);

@interface NSArray (PDCKit)
/**
 *  异步队列遍历数组，遍历结果是无序的
 *
 *  @param block 结果
 */
-(void )asynParallelEnumerateObjectsUsingBlock:(block_array )block;

/**
 *  同步队列遍历数组，遍历结果是有序的
 *
 *  @param block 结果
 */
-(void )asynSerialEnumerateObjectsUsingBlock:(block_array )block;
@end
