//
//  HistoryCell.h
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *intervalLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) NSDictionary *data;

+ (id)nib;

@end
