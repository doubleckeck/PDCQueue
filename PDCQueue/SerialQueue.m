//
//  SerialQueue.m
//  PDCQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "SerialQueue.h"

@implementation SerialQueue

-(void )viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __block NSInteger count = 0;
    for (NSUInteger i = 0; i < 200; ++i)
    {
        [PDCQueue gcd_SerialQueueBlock1:^{
            count++;
        } block2:^{
            NSLog(@"%@",@(count));
        }];
    
    }
    
}

@end
