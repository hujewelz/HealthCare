//
//  ShowMuscleExeViewController.m
//  HealthCare
//
//  Created by jewelz on 14-10-8.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "ShowMuscleExeViewController.h"
#import "AddClickViewController.h"
#import "SecondItemViewController.h"
#import "DocumentTool.h"
#import "TimeTool.h"
#import <AVFoundation/AVFoundation.h>

@interface ShowMuscleExeViewController () <AVSpeechSynthesizerDelegate>
{
    AVSpeechSynthesizer *synth;
    AVSpeechUtterance *utterance;
    DocumentTool *tool;
    NSDate *startTime;
    NSString *dateString;
}

@end

@implementation ShowMuscleExeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    synth = [[AVSpeechSynthesizer alloc] init];

    self.btn.selected = NO;
    self.readBtn.enabled = NO;
    
    synth.delegate = self;
    
    self.contentText.text = [_dict objectForKey:@"content"];
    self.imageView.image = [UIImage imageNamed:[_dict objectForKey:@"image"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonIsSelected:) name:@"ButtonIsSelected"  object:nil];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    synth = nil;
    
    if (startTime != nil) {
        TimeTool *timeTool = [[TimeTool alloc] init];
        NSString *interval =  [timeTool intervalSinceNow:startTime];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.title, @"title",
                          interval, @"interval",
                        dateString, @"date",nil];
        [[DocumentTool sharedDocumentTool] write:dict ToFileWithFileName:@"history"];
        
    }
    
        
}

//接收通知时调用
- (void) buttonIsSelected:(NSNotification *)noti
{
    NSNumber *info = [noti.userInfo objectForKey:@"buttonIsSelected"];
    
    self.btn.selected = info.boolValue;
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (!sender.selected) {
        sender.selected = YES;

        AddClickViewController *addClickViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddClock"];
        addClickViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:addClickViewController animated:YES completion:^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DictFromLast" object:nil userInfo:[NSDictionary dictionaryWithObject:self.title forKey:@"lastTitle"]];

            //NSLog(@"present addClickViewController model view");
        }];
        
    } else
        sender.selected = NO;
    
    
    
}

- (IBAction)readAction:(id)sender {
    
    [self startToSpeech];
    startTime = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    dateString = [dateFormatter stringFromDate:startTime];
    
}

- (void) startToSpeech
{
    NSString *speechContent = [NSString stringWithFormat:@"%@  ，动作要领 ，%@",self.title, self.contentText.text];
    //实例化发声对象 AVSpeechUtterance，指定要朗读的内容
    utterance = [AVSpeechUtterance speechUtteranceWithString:speechContent];
    
    //定义语音对象 AVSpeechSynthesisVoice，指定说话的语言
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];    //中文zh-CN
    
    //设置发音
    utterance.voice = voice;
    //设置速率 中文发音设置为0.1比较合适
    utterance.rate = 0.2;
    
    [synth speakUtterance:utterance];
}

- (IBAction)readAgain:(id)sender {
    
    [self startToSpeech];
}

#pragma mark AVSpeechSynthesizerDelegate
//- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
//{
//    NSLog(@"didStartSpeechUtterance%d",synth.isSpeaking);
//}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{

    NSLog(@"didFinishSpeechUtterance");
    self.readBtn.enabled = YES;
}

@end
