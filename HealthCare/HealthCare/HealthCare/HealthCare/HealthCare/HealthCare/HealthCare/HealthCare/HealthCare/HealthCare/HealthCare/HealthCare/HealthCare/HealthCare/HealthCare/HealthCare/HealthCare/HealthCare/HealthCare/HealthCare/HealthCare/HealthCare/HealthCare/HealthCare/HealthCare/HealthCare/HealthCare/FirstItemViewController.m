//
//  FirstItemViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-7.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "FirstItemViewController.h"

@interface FirstItemViewController () <CLLocationManagerDelegate>
{
    NSMutableDictionary *dictionary;
    NSMutableArray *images;
    SystemSoundID sound;    //系统声音的Id 1000-2000
    
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *prevLocation;
@property (assign, nonatomic) CGFloat sumTime;
@property (assign, nonatomic) CGFloat sumDistance;
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
    
    self.speedLabel.alpha = 0;
    self.avgSpeedlabel.alpha = 0;
    self.sumDistancelabel.alpha = 0;
    
    //获取系统声音路径
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_video_record.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &sound);
    
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
            
            NSTimeInterval dTime = [newLocatin.timestamp timeIntervalSinceDate:self.prevLocation.timestamp];
            self.sumTime += dTime;
            
            CGFloat distance = [newLocatin distanceFromLocation:self.prevLocation];
            
            if (distance < 1.0f) return;
            
            self.sumDistance += distance;
            CGFloat speed = distance / dTime;
            CGFloat avgSpeed = self.sumDistance / self.sumTime;
            
            //按钮消失，同时播放动画
            [self buttonFade];
            
            NSString *speedLabel = [NSString stringWithFormat:@" %.2f米/秒",speed];
            NSString *avgSpeedLabel = [NSString stringWithFormat:@" %.2f米/秒",avgSpeed];
            NSString *distanceLabel = [NSString stringWithFormat:@" %.2f米", self.sumDistance];
            
            
            [UIView animateWithDuration:1.0f animations:^{
                self.speedLabel.alpha = 1;
                self.avgSpeedlabel.alpha = 1;
                self.sumDistancelabel.alpha = 1;
                
                self.showSpeed.text = speedLabel;
                self.showAvgSpeed.text = avgSpeedLabel;
                self.showDistance.text = distanceLabel;
                
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
    [UIView animateWithDuration:1.0f animations:^{
        
        self.button.alpha = 0;
        self.alertlabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        int count = [[dictionary objectForKey:@"run"] intValue];
        
        //移除按钮
        [self.button removeFromSuperview];
        //移除label
        [self.alertlabel removeFromSuperview];
        //移除环形
        [self.ringIImageView removeFromSuperview];
        //清空动画数组
        [images removeAllObjects];
        
       //运行运动动画
        [self animation:count imageView:self.imageView withDuration:0.07 AndImageNamed:@"run"];

    }];
}

#pragma mark 点击按钮调用
- (IBAction)buttonClick:(id)sender {
    
    //播放音效
    
    AudioServicesPlaySystemSound(sound);
    
    int count = [[dictionary objectForKey:@"ring"] intValue];
    [self animation:count imageView:self.ringIImageView withDuration:0.2 AndImageNamed:@"ring"];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
    
}
@end
