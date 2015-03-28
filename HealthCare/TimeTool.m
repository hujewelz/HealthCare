//
//  TimeTool.m
//  HealthCare
//
//  Created by jewelz on 14-10-12.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

- (NSString *)intervalSinceNow: (NSDate *) theDate
{
    NSDate *dateNow = [NSDate date];
    NSTimeInterval interval = [dateNow timeIntervalSince1970] - [theDate timeIntervalSince1970];
    NSLog(@"interval:%f",interval);
    NSString *time;
    
    if (interval >=60 && interval< 3600) {
        time = [NSString stringWithFormat:@"%.0f分钟",interval/60];
    } else if (interval >= 3600) {
        
        int hour = (int)interval / 3600;
        int min = (int)interval % 3600 / 60;
        //NSLog(@"%d小时，%d分钟", hour, min);
        time = [NSString stringWithFormat:@"%d小时,%d分钟",hour, min];
    } else
        time = [NSString stringWithFormat:@"%.0f秒",interval];
    
    return [NSString stringWithFormat:@"已锻炼%@",time];
}

@end
