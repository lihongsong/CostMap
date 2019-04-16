//
//  VoicePermissionManager.m
//  YosKeepAccounts
//
//  Created by shenz on 2019/4/16.
//  Copyright © 2019年 yoser. All rights reserved.
//

#import "VoicePermissionManager.h"

@implementation VoicePermissionManager

+ (instancetype)sharedInstance {
    static VoicePermissionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[VoicePermissionManager alloc] init];
    });
    return sharedManager;
}

//发送语音认证请求(首先要判断设备是否支持语音识别功能)
- (void)speechPermission{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        bool isButtonEnabled = false;
        switch(status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isButtonEnabled = true;
            NSLog(@"可以语音识别");
            break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                isButtonEnabled = false;
                NSLog(@"用户未授权使用语音识别");
            break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                isButtonEnabled =false;
            NSLog(@"语音识别在这台设备上受到限制");
            break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isButtonEnabled =false;
            NSLog(@"语音识别未授权");
            break;
            default:
            break;
                
        }}];
}

- (void)speechRecognizer:(SFSpeechRecognizer*)speechRecognizer availabilityDidChange:(BOOL)available{
    if(available) {
//        self.swicthBut.enabled=YES;
//        [self.swicthBut setTitle:@"开始录音" forState:UIControlStateNormal];}else{self.swicthBut.enabled=NO;[self.swicthBut setTitle:@"语音识别不可用" forState:UIControlStateNormal];
    }
}

#pragma mark----语音识别
- (SFSpeechRecognizer*)speechRecognizer{
    
     if (!_speechRecognizer) {
           NSLocale *cale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];
          _speechRecognizer= [[SFSpeechRecognizer alloc]initWithLocale:cale];
           _speechRecognizer.delegate = self;
         }
     return _speechRecognizer;
}

#pragma mark--停止录音
- (void)endRecording{
     [self.audioEngine stop];
     if (_recognitionRequest) {
           [_recognitionRequest endAudio];
         }
    
     if (_recognitionTask) {
           [_recognitionTask cancel];
           _recognitionTask = nil;
         }
}
#pragma mark---
- (void)startRecording{
     if (self.recognitionTask) {
           [self.recognitionTask cancel];
           self.recognitionTask = nil;
         }
     AVAudioSession *audioSession = [AVAudioSession sharedInstance];
     NSError*error;
     bool audioBool = [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
     NSParameterAssert(!error);
     bool audioBool1= [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
      NSParameterAssert(!error);
     bool audioBool2= [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
      NSParameterAssert(!error);
     if(audioBool || audioBool1|| audioBool2) {
          NSLog(@"可以使用");
         }else{
          NSLog(@"有的功能不支持");
        }
     self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
     AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode,@"录入设备没有准备好");
    NSAssert(self.recognitionRequest, @"请求初始化失败");

     self.recognitionRequest.shouldReportPartialResults = true;
     __weak typeof(self) weakSelf = self;
     self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
           __strong typeof(weakSelf) strongSelf = weakSelf;
           bool isFinal =false;
           if(result) {
                 isFinal = [result isFinal];
                   if (self.speechCallBack) {
                       self.speechCallBack([[result bestTranscription] formattedString], 100);
                   }
               }
           if(error || isFinal) {
                 [strongSelf.audioEngine stop];
                 [inputNode removeTapOnBus:0];
                 strongSelf.recognitionRequest=nil;
                 strongSelf.recognitionTask=nil;
               if (self.speechCallBack) {
                   self.speechCallBack([[result bestTranscription] formattedString], 200);
               }
               }
         }];
     AVAudioFormat*recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
         [inputNode removeTapOnBus:0];
     [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer*_Nonnull buffer,AVAudioTime*_Nonnullwhen) {
         __strong typeof(weakSelf) strongSelf = weakSelf;
           if(strongSelf.recognitionRequest) {
                 [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
               }
        
         }];
     [self.audioEngine prepare];
     bool audioEngineBool = [self.audioEngine startAndReturnError:&error];
     NSParameterAssert(!error);
     NSLog(@"%d",audioEngineBool);
    
}

#pragma mark---创建录音引擎
- (AVAudioEngine*)audioEngine{
    
     if (!_audioEngine) {
           _audioEngine= [[AVAudioEngine alloc]init];
         }
     return _audioEngine;
}


@end
