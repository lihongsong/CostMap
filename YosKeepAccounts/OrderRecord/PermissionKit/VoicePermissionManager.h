//
//  VoicePermissionManager.h
//  YosKeepAccounts
//
//  Created by shenz on 2019/4/16.
//  Copyright © 2019年 yoser. All rights reserved.
//
//  info.plist文件里添加了两个键值Privacy - Microphone Usage Description、Privacy - Speech Recognition Usage Description

#import<Speech/Speech.h>
#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>
typedef void(^SpeechCallBack)(NSString *voiceString,NSInteger code);

NS_ASSUME_NONNULL_BEGIN

@interface VoicePermissionManager : NSObject<SFSpeechRecognizerDelegate>
@property (nonatomic,copy) SpeechCallBack speechCallBack;
@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;//语音识别器
@property (nonatomic,strong,nullable) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;//语音识别请求
@property (nonatomic, strong, nullable) SFSpeechRecognitionTask *recognitionTask;//语音任务管理器
@property (nonatomic,strong) AVAudioEngine *audioEngine;//语音控制器

+ (instancetype)sharedInstance;

// 发送语音认证请求(首先要判断设备是否支持语音识别功能)
- (void)speechPermission;

// 停止录音
- (void)endRecording;

// 开始录音
- (void)startRecording;

@end

NS_ASSUME_NONNULL_END
