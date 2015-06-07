//
//  SecondViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-1.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "SecondViewController.h"
#import "DocumentTool.h"
#import "HistoryCell.h"
#define IDENTIFIER  @"Cell"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *historyData;
   // UITableView *_tableView;
    NSString *path;
}

@end

@implementation SecondViewController

//- (void)loadView {
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
//    self.view = view;
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
//    [self.view addSubview:_tableView];
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.frame = self.view.frame;
   
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [document stringByAppendingPathComponent:@"history.plist"];
   
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView  = [[UIView alloc] init];
    _tableView.rowHeight = 50;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    historyData = [NSMutableArray arrayWithContentsOfFile:path];
    [_tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return historyData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];

    
    cell.data = historyData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!editingStyle == UITableViewCellEditingStyleDelete) return;
    
    //首先删除模型数据
    [historyData removeObjectAtIndex:indexPath.row];
    //同时更新schedule.plist文件中的数据
    [[DocumentTool sharedDocumentTool] remove:indexPath.row fromContentsOfFile:path];
    
    //然后更新tableView中的数据
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
