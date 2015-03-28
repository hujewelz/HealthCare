//
//  ShowMuscleExeViewController.h
//  HealthCare
//
//  Created by jewelz on 14-10-8.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMuscleExeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (strong, nonatomic) NSDictionary *dict;
- (IBAction)buttonClick:(UIButton *)sender;
- (IBAction)readAction:(id)sender;
- (IBAction)readAgain:(id)sender;

@end
