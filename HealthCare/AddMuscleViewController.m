//
//  AddMuscleViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-10.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "AddMuscleViewController.h"
#import "AddClickViewController.h"

@interface AddMuscleViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *dataList;
}

@end

@implementation AddMuscleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    dataList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"muscle" ofType:@"plist"]];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSDictionary *dict = [dataList objectAtIndex:indexPath.row];
    
    //设置row选中时的类型
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    cell.detailTextLabel.text = [dict objectForKey:@"content"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddClickViewController *addClickViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddClock"];
    
    addClickViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    NSString *lastTitle = [dataList objectAtIndex:indexPath.row][@"title"];
    //NSLog(@"%@",lastTitle);
    
    [self presentViewController:addClickViewController animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DictFromLast" object:nil userInfo:[NSDictionary dictionaryWithObject:lastTitle forKey:@"lastTitle"]];
    }];
    
    
}

#pragma mark UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}




@end
