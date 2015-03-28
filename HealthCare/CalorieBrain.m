//
//  CalorieBrain.m
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "CalorieBrain.h"

@implementation CalorieBrain
+ (instancetype)calorieBrain {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (CGFloat)calorieWithSpeed:(NSInteger)speed andWeight:(CGFloat)weight timeInterval:(NSTimeInterval)interval {
    CGFloat intenstry;
    if (speed > 2) {
        intenstry = 5;
    } else
        intenstry = 4;
    return intenstry*3.5*weight*interval*0.001*4.924;
}
@end
