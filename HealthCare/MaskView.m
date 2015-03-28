//
//  MaskView.m
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (id)init {
    self = [super init];
    if (self) {
        //self = [[[NSBundle mainBundle]loadNibNamed:@"MaskView" owner:nil options:nil] lastObject];
    }
    return self;
}
+ (id)maskView {
    return [[[NSBundle mainBundle]loadNibNamed:@"MaskView" owner:nil options:nil] lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
