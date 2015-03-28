//
//  AddClickViewController.h
//  HealthCare
//
//  Created by jewelz on 14-10-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClickViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)sava:(id)sender;

- (IBAction)cancle:(id)sender;
@end
