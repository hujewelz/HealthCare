//
//  FirstItemViewController.h
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface FirstItemViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *showSpeed;
@property (weak, nonatomic) IBOutlet UILabel *showAvgSpeed;
@property (weak, nonatomic) IBOutlet UILabel *showDistance;
@property (weak, nonatomic) IBOutlet UILabel *showCalorie;




@end
