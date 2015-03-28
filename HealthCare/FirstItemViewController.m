//
//  FirstItemViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "FirstItemViewController.h"
#import "DocumentTool.h"
#import "TimeTool.h"
#import "MaskView.h"
#import "CalorieBrain.h"

@interface FirstItemViewController () <CLLocationManagerDelegate>
{
    NSMutableDictionary *dictionary;
    NSMutableArray *images;
    SystemSoundID sound;    //系统声音的Id 1000-2000
    NSDate *startTime;
    NSString *dateString;
   
    
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *prevLocation;
@property (assign, nonatomic) CGFloat sumTime;
@property (assign, nonatomic) CGFloat sumDistance;
@property (strong, nonatomic)  MaskView *maskView;
@end

@implementation FirstItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 50;
    self.locationManager.delegate = self;
    
    dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"animation" ofType:@"plist"]];
    
    //获取系统声音路径
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_video_record.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &sound);
    
    _maskView = [MaskView maskView];
    [self.tableView addSubview:_maskView];
    UIButton *startBtn = (UIButton *)[_maskView viewWithTag:2];
    [self startExercise:startBtn];
   // NSLog(@"%@, %@", startBtn, maskView);
    //[startBtn addTarget:self action:@selector(startExercise:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.contentOffset = CGPointMake(0, 35);
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    //[self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.locationManager stopUpdatingLocation];
    if (!startTime) return;
    
    //如果显示的数据不为空，则将锻炼写入到历史记录中
    NSString *interval =  [[TimeTool shareTimeTool] intervalSinceNow:startTime];
    NSLog(@"锻炼时间:%@",interval);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.title, @"title",
                          interval, @"interval",
                          dateString, @"date",nil];
    [[DocumentTool sharedDocumentTool] write:dict ToFileWithFileName:@"history"];

   
   
    
}

#pragma mark 播放动画的fangf
- (void) animation:(int)count imageView:(UIImageView *)imageView withDuration:(CGFloat)duration AndImageNamed:(NSString *)imageName
{
    images = [NSMutableArray array];
    
    for (int i=1; i<=count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@_%02d.png",imageName,i];
        
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        
        [images addObject:img];
    }
    imageView.animationImages = images;
    imageView.animationRepeatCount = HUGE_VALF;
    imageView.animationDuration = duration * count;
    
    [imageView startAnimating];
    
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *newLocatin = [locations lastObject];
    if (newLocatin.horizontalAccuracy < kCLLocationAccuracyHundredMeters) {
        if (self.prevLocation) {
            NSLog(@"loacation succeed");
            
            NSTimeInterval dTime = [newLocatin.timestamp timeIntervalSinceDate:self.prevLocation.timestamp];
            self.sumTime += dTime;
            
            CGFloat distance = [newLocatin distanceFromLocation:self.prevLocation];
            
            //if (distance < 1.0f) return;
            
            self.sumDistance += distance;
            CGFloat speed = distance / dTime;
            CGFloat avgSpeed = self.sumDistance / self.sumTime;
            
            //按钮消失，同时播放动画
            [self buttonFade];
            NSTimeInterval interval = [[TimeTool shareTimeTool] dutationSinceNow:startTime];
            CGFloat calorie = [[CalorieBrain calorieBrain] calorieWithSpeed:avgSpeed andWeight:60 timeInterval:interval];
            NSLog(@"运动%f分钟，小号了%.2f卡路里", interval, calorie);
            
            NSString *speedLabel = [NSString stringWithFormat:@" %.2f 米/秒",speed];
            NSString *avgSpeedLabel = [NSString stringWithFormat:@" %.2f 米/秒",avgSpeed];
            NSString *distanceLabel = [NSString stringWithFormat:@" %.2f 米", self.sumDistance];
            NSString *calorieLab = [NSString stringWithFormat:@" %.2f kcal", calorie];
            [UIView animateWithDuration:1.0f animations:^{
                self.showSpeed.text = speedLabel;
                self.showAvgSpeed.text = avgSpeedLabel;
                self.showDistance.text = distanceLabel;
                self.showCalorie.text = calorieLab;
            }];
            
           
        }
        
        self.prevLocation = newLocatin;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"定位失败,请打开定位服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

#pragma mark 页面开始显示数据时调用，移除按钮及其动画
- (void) buttonFade
{
    NSLog(@"btn fade.....");
    if (!startTime) {
        startTime = [NSDate date];
        NSLog(@"startTime: %@", startTime);
    }
    
    [UIView animateWithDuration:1.0f animations:^{
        
        _maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        int count = [[dictionary objectForKey:@"run"] intValue];
        
        //移除按钮maskView
        [_maskView removeFromSuperview];
        _maskView = nil;
        
        //清空动画数组
        [images removeAllObjects];
        
       //运行运动动画
        [self animation:count imageView:self.imageView withDuration:0.07 AndImageNamed:@"run"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
        dateString = [dateFormatter stringFromDate:startTime];
        

    }];
}

#pragma mark 点击按钮调用
- (void)startExercise:(UIButton *)sender {
   // [sender setEnabled:NO];
    
    //播放音效
    AudioServicesPlaySystemSound(sound);
    
    int count = [[dictionary objectForKey:@"ring"] intValue];
    UIImageView *imageV = (UIImageView *)[_maskView viewWithTag:1];
    [self animation:count imageView:imageV withDuration:0.2 AndImageNamed:@"ring"];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark 写进历史记录
- (void) wrireToHistory
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.title,@"title", nil];
    [[DocumentTool sharedDocumentTool] write:dict ToFileWithFileName:@"history"];
   
}
@end
