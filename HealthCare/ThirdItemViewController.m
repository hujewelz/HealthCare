//
//  ThirdItemViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-8.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "ThirdItemViewController.h"
#import "DocumentTool.h"
#import "TimeTool.h"

@interface ThirdItemViewController ()
{
    NSDate *startTime;
}

@end

@implementation ThirdItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    startTime = [NSDate date];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    
    TimeTool *timeTool = [[TimeTool alloc] init];
    NSString *interval =  [timeTool intervalSinceNow:startTime];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.title, @"title",
                          interval, @"interval",nil];
    [[DocumentTool sharedDocumentTool] write:dict ToFileWithFileName:@"history"];
    

}


@end
