//
//  TimeTool.h
//  HealthCare
//
//  Created by jewelz on 14-10-12.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

- (NSString *)intervalSinceNow: (NSDate *) theDate;
- (NSTimeInterval)dutationSinceNow: (NSDate *) theDate;
@property (assign, nonatomic) NSTimeInterval interval;
+ (instancetype)shareTimeTool;

@end
