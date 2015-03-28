//
//  ThirdViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-1.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "ThirdViewController.h"
#import "DocumentTool.h"
#import "FirstItemViewController.h"
#import "ShowMuscleExeViewController.h"
#import "ThirdItemViewController.h"

@interface ThirdViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    NSString *path;
    NSArray *dataList;
}

@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [document stringByAppendingPathComponent:@"schedule.plist"];
    
    dataList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"muscle" ofType:@"plist"]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
    dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    [self.tableView reloadData];
}


- (IBAction)AddBarbutton:(id)sender {
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *addExeViewController = [mainSb instantiateViewControllerWithIdentifier:@"AddExercise"];
    addExeViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:addExeViewController animated:YES completion:^{
        NSLog(@"present model view");
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    NSString *datailText = [NSString stringWithFormat:@"%@   %@", dict[@"lastTitle"],dict[@"date"]];
    cell.detailTextLabel.text = datailText;

    //设置图片
    if ([dict[@"lastTitle"] isEqualToString:@"跑步"]) {
        
        cell.imageView.image = [UIImage imageNamed:@"run.png"];
    } else if ([dict[@"lastTitle"] isEqualToString:@"瑜伽"]) {
        
       cell.imageView.image = [UIImage imageNamed:@"yoga.png"];
        
    } else {
        
       cell.imageView.image = [UIImage imageNamed:@"sit-ups.png"];
    }
    
    
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!editingStyle == UITableViewCellEditingStyleDelete) return;
    
    //首先删除模型数据
    [dataArray removeObjectAtIndex:indexPath.row];
    //同时更新schedule.plist文件中的数据
    [[DocumentTool sharedDocumentTool] remove:indexPath.row fromContentsOfFile:path];
    
    //然后更新tableView中的数据
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];

    if ([dict[@"lastTitle"] isEqualToString:@"跑步"]) {
        
        UIViewController *firstItemViewController = [[FirstItemViewController alloc] initWithNibName:@"FirstItemViewController" bundle:nil];
        
        firstItemViewController.title = dict[@"lastTitle"];
        
        [self.navigationController pushViewController:firstItemViewController animated:YES];
        
        
    } else if ([dict[@"lastTitle"] isEqualToString:@"瑜伽"]) {
        
        UIViewController *thirdItemViewController = [[ThirdItemViewController alloc]initWithNibName:@"ThirdItemViewController" bundle:nil];
        
        thirdItemViewController.title = dict[@"lastTitle"];
        
        [self.navigationController pushViewController:thirdItemViewController animated:YES];
        
       
    } else {
        
        ShowMuscleExeViewController *showMuscleExeViewController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowMuscleExe"];
        
        //从dataList中拿到与dict[@"lastTitle"]相对应的数据，拿出的是一个字典
        for (NSDictionary *dic in dataList) {
            if ([dic[@"title"] isEqualToString:dict[@"lastTitle"]]) {
                showMuscleExeViewController.dict = dic;
                break;
            }
        }
        
        showMuscleExeViewController.title = dict[@"lastTitle"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showMuscleExeViewController animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }


    
}

@end
