//
//  SafeThread.m
//  PDCQueue
//
//  Created by KH on 16/5/27.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "SafeThread.h"

typedef void(^num)(NSInteger num);
@interface SafeThread()
@property (nonatomic, assign) NSInteger count;
@property (strong, nonatomic) dispatch_queue_t queue;
@end

@implementation SafeThread

-(void )viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [self pr_demo1];
        
        [self pr_demo2];
    });
}

-(void )pr_demo1
{
    self.queue = dispatch_queue_create("doublecheck.pdc", DISPATCH_QUEUE_CONCURRENT);
    
    [PDCQueue gcd_safeQueue:self.queue setBlock:^{  //首先执行这个block
        //------------1---------------
        dispatch_async(self.queue, ^{
            for (NSUInteger i = 0; i < 100; ++i)
            {
                /* 这里必能保证修改完才能访问，可能同时进行，所以这里输出是无序的 */
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    self.count++;
                });
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSLog(@"for --1-- : %@",@(self.count));
                });
            }
        });
        //------------1---------------
    } getBlock:^{   //上面一个block执行完才会执行这段，这里从101开始
        //------------2---------------
        dispatch_async(self.queue, ^{
            for (NSUInteger i = 0; i < 100; ++i)
            {
                /* 这里能保证修改完才能访问，所以这里是按顺序输出的 */
                [PDCQueue gcd_safeQueue:self.queue setBlock:^{
                    self.count++;
                } getBlock:^{
                    NSLog(@"for --2-- : %@",@(self.count));
                }];
            }
        });
        //------------2--------------
    }];
}

-(void )pr_demo2
{
    dispatch_semaphore_t semp = dispatch_semaphore_create(1);
    dispatch_queue_t global_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (NSUInteger i = 0; i < 200; ++i)
    {
        [PDCQueue gcd_safeQueue:global_queue semaphore:semp setBlock:^{
            self.count++;
        } getBlock:^{
            NSLog(@"%@",@(self.count));
        }];
        
    }
}
@end
