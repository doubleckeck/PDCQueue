//
//  PDCSerialQueue.m
//  PDCSerialQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "PDCSerialQueue.h"
@interface PDCSerialQueue()
@property (strong, nonatomic) NSMutableArray<operationBlock > *blocks;
@property (strong, nonatomic) dispatch_semaphore_t semap;
@end

@implementation PDCSerialQueue
-(NSMutableArray<operationBlock > *)blocks
{
    if (_blocks == nil)
    {
        _blocks = [NSMutableArray<operationBlock > array];
    }
    return _blocks;
}

-(instancetype )init
{
    self = [super init];
    if (self)
    {
        /* 这里必须设置为1，不为1为并行队列,1相当于串行队列 */
        self.maxConcurrentOperationCount = 1;
        
        self.operationTime = 1000 * 100;
        self.operationNum = 4;
        
        self.semap = dispatch_semaphore_create(1);
    }
    return self;
}

-(instancetype )initWithOperationTime:(__uint32_t )operationTime operationNum:(__uint16_t )operationNum
{
    self = [[[self class] alloc] init];
    if (self)
    {
        self.operationTime = operationTime;
        self.operationNum = operationNum;
    }
    return self;
}

-(void )addOperationBlock:(operationBlock )block
{
    __block typeof(self) weakself = self;
    [self.blocks addObject:block];
    if (self.blocks.count > self.operationNum)
    {
        /* 这里虽然移除了，但是可能最老的那个block还在执行中,停不掉 */
        [self.blocks removeObjectAtIndex:0];
        return;
    }

    [self addOperationWithBlock:^{
        dispatch_semaphore_wait(self.semap, DISPATCH_TIME_FOREVER);
        block(weakself.semap);
        if (weakself.blocks.count > 0)
        {
            [weakself.blocks removeObjectAtIndex:0];
        }
        usleep(weakself.operationTime);
    }];
    
}
@end
