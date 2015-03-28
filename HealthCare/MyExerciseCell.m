//
//  MyExerciseCell.m
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "MyExerciseCell.h"

@implementation MyExerciseCell

- (void)awakeFromNib {
    // Initialization code
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.titleLab.text = _data[@"title"];
    self.timeLab.text = _data[@"date"];
    self.descLabel.text = _data[@"lastTitle"];
    self.image.image = [UIImage imageNamed:_data[@"image"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
