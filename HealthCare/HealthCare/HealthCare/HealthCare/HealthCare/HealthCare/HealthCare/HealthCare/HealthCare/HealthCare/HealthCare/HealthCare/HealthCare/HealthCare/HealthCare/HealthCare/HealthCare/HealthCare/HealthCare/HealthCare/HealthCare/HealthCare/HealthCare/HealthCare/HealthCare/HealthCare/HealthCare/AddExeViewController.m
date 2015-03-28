//
//  AddExeViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "AddExeViewController.h"

@interface AddExeViewController ()

@end

@implementation AddExeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (IBAction)cancleButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss view");
    }];
}

- (IBAction)doneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss view");
        NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
        [dateDict setObject:@"huhuh" forKey:@"name"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddExeNotification" object:nil userInfo:dateDict];
    }];
}
@end
