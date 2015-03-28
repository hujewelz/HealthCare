//
//  AddClickViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "AddClickViewController.h"
#import "DocumentTool.h"

@interface AddClickViewController () <UITextFieldDelegate>
{
    UIApplication *app;
    BOOL buttonIsSelected;
    NSMutableArray *array;
    NSString *dictFromLastTitle;
}

@end

@implementation AddClickViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [NSMutableArray array];
    
    app = [UIApplication sharedApplication];
    
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dictFromLast:) name:@"DictFromLast" object:nil];
    
}

- (void)dictFromLast:(NSNotification *)noti
{
    dictFromLastTitle = [noti userInfo][@"lastTitle"];
}


- (IBAction)sava:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSDate *date = self.datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        //创建一个本地通知
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //设置通知触发的时间
        localNotification.fireDate = date;
        //设置通知的时区
        //localNotification.timeZone = [NSTimeZone defaultTimeZone];
        //设置通知的声音
        localNotification.soundName = @"/System/Library/Audio/UISounds/begin_video_record.caf";
        //设置通知内容
        localNotification.alertBody = @"您预定的运动项目开始了";
        //设置显示在应用图标上的小徽标
        localNotification.applicationIconBadgeNumber = 1;
        
        //设置通知携带的附加信息
        NSDictionary *info = @{@"hujewlz": @"key"};
        localNotification.userInfo = info;
        
        //调用通知
        [app scheduleLocalNotification:localNotification];
        
        NSString *itemTitle = self.textField.text;
        
        if (itemTitle.length == 0) {
            itemTitle = @"未命名项";
        }
        //将信息加到字典中
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              itemTitle,@"title",
                              dictFromLastTitle,@"lastTitle",
                              dateString,@"date",nil];

        //将字典写入到沙盒目录中
        [[DocumentTool sharedDocumentTool] write:dict ToFileWithFileName:@"schedule"];
        
        //发送通知给AddExeViewController 用于改变完成按钮的可编辑状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ButtonIsEnable" object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"buttonIsEnable"]];
        
        
    }];
}

- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
        buttonIsSelected = NO;
        
        //如果点击了取消按钮，则设置提醒按钮为不选中状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ButtonIsSelected" object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:buttonIsSelected] forKey:@"buttonIsSelected"]];
        
    }];

}


#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
