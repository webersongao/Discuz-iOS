//
//  DZPostEditViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/14.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPostEditViewController.h"
#import <iflyMSC/iflyMSC.h>
@interface DZPostEditViewController ()<IFlySpeechRecognizerDelegate>

@property (nonatomic, copy) NSString *contentString;  //!< <#属性注释#>
@property (nonatomic, assign) UIButton *inputButton;  //!< <#属性注释#>
@property (nonatomic, strong) UITextView *contentView;  //!< 属性注释
//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

@end

@implementation DZPostEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.inputButton];
}


-(void)inputButtonAction:(UIButton *)button{
    //启动识别服务
    [self.iFlySpeechRecognizer startListening];
}

#pragma mark   /********************* IFlySpeechRecognizerDelegate *************************/

//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    DLog(@"%@",[NSString stringWithFormat:@"返回结果: %@ __ 是否是最后：%@",results,isLast ? @"是":@"不是"]);
}

//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    
}

//停止录音回调
- (void) onEndOfSpeech{
    
}

//开始录音回调
- (void)onBeginOfSpeech{
    
}

//音量回调函数
- (void) onVolumeChanged: (int)volume{
    
}

//会话取消回调
- (void) onCancel{
    
}

#pragma mark   /********************* 初始化SDK *************************/

-(IFlySpeechRecognizer *)iFlySpeechRecognizer{
    if (_iFlySpeechRecognizer == nil) {
        //创建语音识别对象
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        //设置识别参数
        //设置为听写模式
        _iFlySpeechRecognizer.delegate = self;
        //扩展参数
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:@"1800" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:@"1800" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    return _iFlySpeechRecognizer;
}

#pragma mark   /********************* 初始化UI *************************/

-(UITextView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UITextView alloc] initWithFrame:CGRectMake(15.f, KNavi_ContainStatusBar_Height+kMargin10, KScreenWidth- 30, KScreenHeight-250)];
        _contentView.layer.borderColor = [UIColor orangeColor].CGColor;
        _contentView.layer.borderWidth = 1.f;
    }
    return _contentView;
}

-(UIButton *)inputButton{
    if (_inputButton == nil) {
        _inputButton = [UIButton ButtonTextWithFrame:CGRectMake(20, self.contentView.bottom+20.f, KScreenWidth-40, 40) titleStr:@"默认-输入文字" titleColor:[UIColor orangeColor] titleTouColor:[UIColor orangeColor] font:KBoldFont(16.f) Radius:4.f Target:self action:@selector(inputButtonAction:)];
        _inputButton.backgroundColor = [UIColor greenColor];
    }
    return _inputButton;
}


@end
