//
//  AddExeViewController.h
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancleBtn;

- (IBAction)cancleButton:(id)sender;

@end
