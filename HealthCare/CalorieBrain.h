//
//  CalorieBrain.h
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalorieBrain : NSObject
+ (instancetype)calorieBrain;
- (CGFloat)calorieWithSpeed:(NSInteger)speed andWeight:(CGFloat)weight timeInterval:(NSTimeInterval)interval;
@end
