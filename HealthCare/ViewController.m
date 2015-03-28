//
//  ViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-1.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "ViewController.h"
#import "FirstItemViewController.h"
#import "SecondItemViewController.h"
#import "ThirdItemViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *itemArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"project" ofType:@"plist"];
    itemArray = [NSArray arrayWithContentsOfFile:path];
	
    //设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    tableViewCell.detailTextLabel.text = [dict objectForKey:@"detail"];
    tableViewCell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    
    return tableViewCell;
}

#pragma mark UITableViewDelegate方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [itemArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        UIViewController *firstItemViewController = [[FirstItemViewController alloc] initWithNibName:@"FirstItemViewController" bundle:nil];
        
        firstItemViewController.title = [dict objectForKey:@"title"];
        
        [self.navigationController pushViewController:firstItemViewController animated:YES];
    } else if (indexPath.row == 1) {
        UIViewController *secondItemViewController = [[SecondItemViewController alloc] initWithNibName:@"SecondItemViewController" bundle:nil];
        
        secondItemViewController.title = [dict objectForKey:@"title"];
        
        [self.navigationController pushViewController:secondItemViewController animated:YES];
    } else {
        
        UIViewController *thirdItemViewController = [[ThirdItemViewController alloc]initWithNibName:@"ThirdItemViewController" bundle:nil];
        
        thirdItemViewController.title = [dict objectForKey:@"title"];
        
        [self.navigationController pushViewController:thirdItemViewController animated:YES];
    }
        
    
}

//选择表视图行时触发
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"Third"]) {
//        ThirdItemViewController *firstItemViewController = segue.destinationViewController;
//        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
//        firstItemViewController.title = [NSString stringWithFormat:@"选中了%d行",selectedIndex];
//        NSLog(@"选中了%d行",selectedIndex);
//    }
//}
@end
