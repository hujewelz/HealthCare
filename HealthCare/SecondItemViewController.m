//
//  SecondItemViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "SecondItemViewController.h"
#import "ShowMuscleExeViewController.h"

@interface SecondItemViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *dataList;
    UITableView *_tableView;
}

@end

@implementation SecondItemViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
    self.view = view;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //self.tableView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width + 80);

    dataList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"muscle" ofType:@"plist"]];
}

#pragma mark UITableViewDataSource

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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    cell.detailTextLabel.text = [dict objectForKey:@"content"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ShowMuscleExeViewController *showMuscleExeViewController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowMuscleExe"];
    
    [self.navigationController pushViewController:showMuscleExeViewController animated:YES];
    
    showMuscleExeViewController.dict = [dataList objectAtIndex:indexPath.row];
    showMuscleExeViewController.title = [[dataList objectAtIndex:indexPath.row] objectForKey:@"title"];
}

#pragma mark UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

@end
