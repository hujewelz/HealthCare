//
//  AddExeViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "AddExeViewController.h"
#import "AddClickViewController.h"
#import "SecondItemViewController.h"
#import "AddMuscleViewController.h"

@interface AddExeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *itemArray;
}

@end

@implementation AddExeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"project" ofType:@"plist"];
    itemArray = [NSArray arrayWithContentsOfFile:path];
    //设置完成按钮不可编辑
    self.doneButton.enabled = NO;
	
    //设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //接受来自AddClickViewController发送的通知，用于改变完成按钮的可编辑状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonIsEnable:) name:@"ButtonIsEnable"  object:nil];
}

- (void) buttonIsEnable:(NSNotification *)noti
{
    NSNumber *info = [noti.userInfo objectForKey:@"buttonIsEnable"];
    
    //设置完成按钮可编辑，取消按钮不可编辑
    self.doneButton.enabled = info.boolValue;
    self.cancleBtn.enabled = !info.boolValue;
}

- (IBAction)cancleButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss view");
    }];
}

#pragma mark DataSource协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *dict = [itemArray objectAtIndex:indexPath.row];
    tableViewCell.textLabel.text = [dict objectForKey:@"title"];
    tableViewCell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    
    return tableViewCell;
}

#pragma mark UITableViewDelegate方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"添加项目到我的锻炼";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [itemArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 1) {
        UIViewController *addMuscleViewController = [[UINavigationController alloc] initWithRootViewController:[[AddMuscleViewController alloc] init]];
        
        addMuscleViewController.title = [dict objectForKey:@"title"];
        
        [self.navigationController pushViewController:addMuscleViewController animated:YES];
        
    } else {
    
        AddClickViewController *addClickViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddClock"];
        
        addClickViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:addClickViewController animated:YES completion:^{
            
            //将选择行的标题传到下一页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DictFromLast" object:nil userInfo:[NSDictionary dictionaryWithObject:dict[@"title"] forKey:@"lastTitle"]];
            NSLog(@"present model view");
        }];
        
    }
    
    
}



@end
