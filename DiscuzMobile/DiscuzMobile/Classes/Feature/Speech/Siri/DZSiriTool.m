//
//  DZSiriTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/14.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZSiriTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>

@interface DZSiriTool ()

@property (nonatomic, assign) BOOL isAuthed;  //!< 是否已经成功授权语音权限

@property (nonatomic, strong) AVAudioSession *session;

@property (nonatomic, strong) AVAudioEngine *audioEngine;

@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;

@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *speechRequest;
@end

@implementation DZSiriTool

static DZSiriTool *instance = nil;

+(instancetype)sharedTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSiriSpeechRecognizer];
    }
    return self;
}

- (void)configSiriSpeechRecognizer
{
    // 请求语音识别权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        self.isAuthed = (status == SFSpeechRecognizerAuthorizationStatusAuthorized) ? YES : NO;
    }];
    _session = [AVAudioSession sharedInstance];
    // 3各参数分别是 设置录音, 并且减少系统提供信号对应用程序输入和/或输出音频信号的影响,
    [_session setCategory:AVAudioSessionCategoryRecord mode:AVAudioSessionModeMeasurement options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [_session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    // 初始化多媒体引擎
    [self launchSpeechAudioEngine];
}

- (void)launchSpeechAudioEngine
{
    if (!_speechRecognizer) {
        // 设置语言
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    }
    // 初始化引擎
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
}

- (void)stardSpeechRecognizer:(void (^)(void))StatusBlock endBlock:(void (^)(NSString * String,BOOL isFinal))endBlock
{
    if (!self.isAuthed) {
        [self configSiriSpeechRecognizer];
        return;
    }
    // 创建新的语音识别请求
    [self PrepareSpeechRequest:endBlock];
    __weak typeof(self) weakSelf = self;
    // 录音格式配置 -- 监听输出流 并拼接流文件
    AVAudioFormat *recordingFormat = [[_audioEngine inputNode] outputFormatForBus:0];
    // 创建一个Tap,(创建前要先删除旧的)
    // 文档注释: Create a "tap" to record/monitor/observe the output of the node.
    [[_audioEngine inputNode] installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 拼接流文件
        [strongSelf.speechRequest appendAudioPCMBuffer:buffer];
    }];
    
    // 准备并启动引擎
    [_audioEngine prepare];
    
    NSError *error = nil;
    // 启动引擎
    [_audioEngine startAndReturnError:&error];
    if (StatusBlock) {
        // 语音识别中...
        StatusBlock();
    }
}

//  创建语音识别请求
- (void)PrepareSpeechRequest:(void (^)(NSString * String,BOOL isFinal))endBlock
{
    if (_speechRequest) {
        [_speechRequest endAudio];
        _speechRequest = nil;
    }
    if (!endBlock) {
        return;
    }
    _speechRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    _speechRequest.shouldReportPartialResults = YES; // 实时翻译
    // 建立语音识别任务, 并启动.  block内为语音识别结果回调
    [_speechRecognizer recognitionTaskWithRequest:_speechRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            DLog(@"语音识别解析失败,%@",error);
            endBlock(nil,error);
        }else {
            // 识别的内容
            NSString *text = result.bestTranscription.formattedString;
            // 实时打印说话的内容
            DLog(@"is final: %d  result: %@", result.isFinal, result.bestTranscription.formattedString);
            if (result.isFinal) { // 结束时 显示内容
                endBlock(text,nil);
                [self releaseSpeechEngine];
            }
        }
    }];
}

- (void)cancelSpeechRecognizer:(void (^)(void))StatusBlock{
    [self releaseSpeechEngine];
    if (StatusBlock) {
        StatusBlock();
    }
}

- (void)releaseSpeechEngine
{
    // 销毁tap
    [[_audioEngine inputNode] removeTapOnBus:0];
    
    [_audioEngine stop];
    
    [_speechRequest endAudio];
    _speechRequest = nil;
}



@end
