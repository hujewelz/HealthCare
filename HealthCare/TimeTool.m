//
//  TimeTool.m
//  HealthCare
//
//  Created by jewelz on 14-10-12.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
static TimeTool *timer;

+ (instancetype)shareTimeTool {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        timer = [TimeTool new];
    });
    return timer;
}
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//         NSDate *dateNow = [NSDate date];
//         _interval = [dateNow timeIntervalSince1970] - [theDate timeIntervalSince1970];
//    }
//    return self;
//}

- (NSString *)intervalSinceNow: (NSDate *) theDate
{
    NSDate *dateNow = [NSDate date];
    _interval = [dateNow timeIntervalSince1970] - [theDate timeIntervalSince1970];

    NSLog(@"interval:%f",_interval);
    NSString *time;
    
    if (_interval >=60 && _interval< 3600) {
        time = [NSString stringWithFormat:@"%.0f分钟",_interval/60];
    } else if (_interval >= 3600) {
        
        int hour = (int)_interval / 3600;
        int min = (int)_interval % 3600 / 60;
        //NSLog(@"%d小时，%d分钟", hour, min);
        time = [NSString stringWithFormat:@"%d小时,%d分钟",hour, min];
    } else
        time = [NSString stringWithFormat:@"%.0f秒",_interval];
    
    return [NSString stringWithFormat:@"已锻炼%@",time];
}

- (NSTimeInterval)dutationSinceNow:(NSDate *)theDate {
    NSDate *dateNow = [NSDate date];
    _interval = [dateNow timeIntervalSince1970] - [theDate timeIntervalSince1970];
    NSLog(@"now: %@, starttime:%@, interval:%f", dateNow, theDate, _interval);
    return _interval / 60;
}


@end
