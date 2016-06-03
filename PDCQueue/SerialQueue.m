//
//  SerialQueue.m
//  PDCQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "SerialQueue.h"
#import "PDCQueueFunction.h"

@implementation SerialQueue

-(void )viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self demo2];
}

-(void )demo1
{
    __block NSInteger count = 0;
    for (NSUInteger i = 0; i < 200; ++i)
    {
        [PDCQueue gcd_serialQueueBlock1:^{
            count++;
        } block2:^{
            NSLog(@"%@",@(count));
        }];
        
    }
}

-(void )demo2
{
    __block NSUInteger i = 0;
    gcd_asynSerialQueue(1.0, ^(BOOL *finish){
        i++;
        if (i == 10)
        {
            *finish = YES;
        }
        
        NSLog(@"print %@",@(i));
    });
}
@end
