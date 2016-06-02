//
//  DispathApply.m
//  PDCQueue
//
//  Created by KH on 16/6/1.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "DispathApply.h"
#import "NSArray+PDCKit.h"

@interface DispathApply ()
@property (strong, nonatomic) NSMutableArray *arr;
@end

@implementation DispathApply

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /* 遍历 */
    self.arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; ++i)
    {
        [self.arr addObject:@(i)];
    }
    
    [self.arr asynParallelEnumerateObjectsUsingBlock:^(NSInteger index, id obj) {
        NSLog(@"%@",obj);
    }];
}

@end
