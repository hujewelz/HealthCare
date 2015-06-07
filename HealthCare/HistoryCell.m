//
//  HistoryCell.m
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell
+ (id)nib {
    return [[[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    //NSLog(@"awakeFromNib");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.titleLab.text = _data[@"title"];
    self.intervalLab.text = _data[@"interval"];
    self.timeLab.text = _data[@"date"];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
