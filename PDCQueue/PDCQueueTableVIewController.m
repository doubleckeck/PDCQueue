//
//  PDCQueueTableVIewController.m
//  PDCQueue
//
//  Created by KH on 16/5/27.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "PDCQueueTableVIewController.h"

@interface PDCQueueTableVIewController()
@property (strong, nonatomic) NSArray *datas;
@end

@implementation PDCQueueTableVIewController

-(NSArray *)datas
{
    if (_datas == nil)
    {
        _datas = @[@{@"name":@"diapath_group - GCD 组",
                     @"perform":@"AsynGroup"},
                   
                   @{@"name":@"线程安全 - GCD 栅栏",
                     @"perform":@"SafeThread"},
                   
                    @{@"name":@"异步串行队列 - GCD Serial",
                      @"perform":@"SerialQueue"},
                   
                   @{@"name":@"串行队列以时间、任务数，限制执行任务数",
                     @"perform":@"SerialOperationQueue"}];
    }
    return _datas;
}

-(void )viewDidLoad
{
    self.title = @"线程例子";
    [super viewDidLoad];
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.text = self.datas[indexPath.row][@"name"];
    return cell;
}

-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[NSClassFromString(self.datas[indexPath.row][@"perform"]) alloc] init] animated:YES];
}
@end
