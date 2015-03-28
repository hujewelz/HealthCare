//
//  TimeTool.m
//  HealthCare
//
//  Created by jewelz on 14-10-12.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "TimeTool.h"
@interface TimeTool () {
    NSString *_time;
    NSString *hour, *minu, *second;
}
@end

@implementation TimeTool

- (NSString *)intervalSinceNow: (NSDate *) theDate
{
    NSDate *dateNow = [NSDate date];
    NSTimeInterval interval = [dateNow timeIntervalSince1970] - [theDate timeIntervalSince1970];
    NSLog(@"interval:%f",interval);
    [self getTimeFromTimeInterval:interval];
    return [NSString stringWithFormat:@"%@",_time];
}

- (void)getTimeFromTimeInterval:(NSTimeInterval)interval {
    if (interval < 60) {
        second = [NSString stringWithFormat:@"%02d",(int)interval];
        if (!hour) {
            hour = @"00";
        }
        if (!minu) {
            minu = @"00";
        }
    } else if (interval >=60 && interval< 3600) {
        if (!hour) {
            hour = @"00";
        }
        NSInteger _min = (NSInteger)interval / 60;
        [self getTimeFromTimeInterval:(int)interval % 60];
        minu = [NSString stringWithFormat:@"%02d",_min];

    } else {
        NSInteger _hour = (NSInteger)interval / 3600;
        [self getTimeFromTimeInterval:(NSInteger)interval % 3600];
        hour = [NSString stringWithFormat:@"%02d",_hour];
    }
    _time = [NSString stringWithFormat:@"%@:%@:%@", hour, minu, second];
}




@end
