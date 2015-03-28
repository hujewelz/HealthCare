//
//  FViewController.m
//  HealthCare
//
//  Created by jewelz on 15/3/28.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "FViewController.h"
#import "MaskView.h"

@interface FViewController () {
    MaskView *maskView;
    UIButton *startBtn;
}

@end

@implementation FViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    maskView = [MaskView maskView];
    [self.view addSubview:maskView];
    startBtn = (UIButton *)[maskView viewWithTag:2];
    [self startExercise:startBtn];
    NSLog(@"%@", startBtn);
    [startBtn addTarget:self action:@selector(startExercise:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startExercise:(UIButton *)sender {
    NSLog(@"btn.....");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
