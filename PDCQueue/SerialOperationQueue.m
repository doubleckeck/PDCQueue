//
//  SerialOperationQueue.m
//  PDCQueue
//
//  Created by KH on 16/5/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "SerialOperationQueue.h"
#import "PDCSerialQueue.h"

#import "PDCQueueFunction.h"

typedef void queue_action;

@interface SerialOperationQueue ()
@property (strong, nonatomic) UIButton *goOnBtn;
@property (strong, nonatomic) UIButton *cancelBtn;


@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) PDCSerialQueue *queue_pdc;
@end

@implementation SerialOperationQueue

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self pr_setSubView];
    
    [self pr_setOprationQueue_pdc];
}

-(void )pr_setOprationQueue_pdc
{
    //创建队列
    self.queue_pdc = [[PDCSerialQueue alloc] initWithOperationTime:1000*10 operationNum:4];
}

-(void )touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    self.goOnBtn.center = point;
    
    __block typeof(self) weakself = self;
    [self.queue_pdc addOperationBlock:^(dispatch_semaphore_t semap){    //添加任务
        NSLog(@"%@",NSStringFromCGPoint(point));
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.cancelBtn.titleLabel.text = NSStringFromCGPoint(point);
            [weakself.cancelBtn setTitle:NSStringFromCGPoint(point) forState:UIControlStateNormal];
            
            /* 操作完成通知队列，不然队列一直等待 */
            dispatch_semaphore_signal(semap);
        });
    }];
    
}

/* 创建两个按钮 */
-(void )pr_setSubView
{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.goOnBtn    = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.view addSubview:self.goOnBtn];
    [self.view addSubview:self.cancelBtn];
    
    self.goOnBtn.frame      = CGRectMake(0, 0, 200, 40);
    self.cancelBtn.frame    = CGRectMake(0, 0, 200, 40);
    
    self.goOnBtn.center      = CGPointMake(width * 0.25, 200);
    self.cancelBtn.center    = CGPointMake(width * 0.75, 200);
    
    [self.goOnBtn setTitle:@"tap and move" forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"this is location" forState:UIControlStateNormal];
    
}
@end
