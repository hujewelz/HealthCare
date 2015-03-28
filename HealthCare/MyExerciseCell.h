//
//  MyExerciseCell.h
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyExerciseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) NSDictionary *data;
@end
