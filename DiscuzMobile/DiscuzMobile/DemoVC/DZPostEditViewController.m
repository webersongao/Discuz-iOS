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
        [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    }
    return _iFlySpeechRecognizer;
}

#pragma mark   /********************* 初始化UI *************************/

-(UITextView *)contentView{
    if (_contentView == nil) {
        [Environment sharedEnvironment].auth = @"sdgsdg";
        [Environment sharedEnvironment].member_uid = @"sdgsdg";
        _contentView = [[UITextView alloc] initWithFrame:CGRectMake(15.f, 15.f, KScreenWidth- 30, KScreenHeight-280)];
        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}

-(UIButton *)inputButton{
    if (_inputButton == nil) {
        _inputButton = [UIButton ButtonTextWithFrame:CGRectMake(20, self.contentView.bottom+20.f, KScreenWidth-40, 40) titleStr:@"默认-输入文字" titleColor:[UIColor orangeColor] titleTouColor:[UIColor orangeColor] font:KBoldFont(16.f) Radius:4.f Target:self action:@selector(inputButtonAction:)];
        _inputButton.backgroundColor = [UIColor redColor];
    }
    return _inputButton;
}


@end
