//
//  ViewController.m
//  PDCQueue
//
//  Created by KH on 16/5/27.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "AsynGroup.h"

@interface AsynGroup ()
@property (nonatomic, assign) NSInteger number;

@end

@implementation AsynGroup

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"GCD group";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue1 = dispatch_queue_create("doublecheck.pdc", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSUInteger i = 0; i < 50; ++i)
    {
        dispatch_async(queue1, ^{   //当执行完这里的block，group_notify就会被调用，里面的线程不影响group_notify
            NSLog(@"queue : %@",@(self.number));
            
            dispatch_async(queue1, ^{
//                usleep(1000 * 1000);
                
                dispatch_async(queue1, ^{
                    NSLog(@"最里面的队列 : %@",@(self.number));
                });
                
                NSLog(@"里面的队列 : %@",@(self.number));
            });
            
            self.number++;
        });
    }
    /* 第一个异步操作 */
    dispatch_group_async(group, queue1, ^{
        NSLog(@"ground1: %@",@(self.number));
        self.number++;
    });
    
    /* 第二异步操作 */
    dispatch_group_async(group, queue1, ^{
        NSLog(@"ground2: %@",@(self.number));
        self.number++;
    });

    /* 提交的组dispatch_group_async完成后才会调用，如果前面组未提交队列，则跟异步线程效果一样 */
    dispatch_group_notify(group, queue1, ^{
        /* 这个输出总是在ground1 ground2 两者后面 */
        NSLog(@"ground notify: %@",@(self.number));
        self.number++;
    });
}

@end
