//
//  DZPostUIEditViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/14.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPostUIEditViewController.h"
#import <iflyMSC/iflyMSC.h>

@interface DZPostUIEditViewController ()<IFlyRecognizerViewDelegate>

@property (nonatomic, copy) NSString *contentString;  //!< <#属性注释#>
@property (nonatomic, assign) UIButton *inputUIButton;  //!< <#属性注释#>
@property (nonatomic, strong) UITextView *contentView;  //!< 属性注释
//不带界面的识别对象
@property (nonatomic, strong) IFlyRecognizerView *IFlySpeechView;

@end

@implementation DZPostUIEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.inputUIButton];
}


-(void)inputUIButtonAction:(UIButton *)button{
    //启动识别服务
    [self.IFlySpeechView start];
}


#pragma mark   /********************* IFlyRecognizerViewDelegate *************************/

//识别结果返回代理
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast{
    DLog(@"%@",[NSString stringWithFormat:@"返回结果: %@ __ 是否是最后：%@",resultArray,isLast ? @"是":@"不是"]);
}

//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    [self.IFlySpeechView cancel];
}

#pragma mark   /********************* 初始化SDK *************************/

-(IFlyRecognizerView *)IFlySpeechView{
    if (_IFlySpeechView == nil) {
        //创建语音识别对象
        _IFlySpeechView = [[IFlyRecognizerView alloc] initWithCenter:CGPointMake(KScreenWidth/2.f, KScreenHeight/2.f)];
        //设置识别参数
        //设置为听写模式
        _IFlySpeechView.delegate = self;
        [_IFlySpeechView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        [_IFlySpeechView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        [_IFlySpeechView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        [_IFlySpeechView setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        [_IFlySpeechView setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    }
    return _IFlySpeechView;
}

#pragma mark   /********************* 初始化UI *************************/

-(UITextView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UITextView alloc] initWithFrame:CGRectMake(15.f, 15.f, KScreenWidth- 30, KScreenHeight-280)];
        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}

-(UIButton *)inputUIButton{
    if (_inputUIButton == nil) {
        _inputUIButton = [UIButton ButtonTextWithFrame:CGRectMake(20, self.contentView.bottom+20.f, KScreenWidth-40, 40) titleStr:@"自定义UI-输入文字" titleColor:[UIColor orangeColor] titleTouColor:[UIColor orangeColor] font:KBoldFont(16.f) Radius:4.f Target:self action:@selector(inputUIButtonAction:)];
        _inputUIButton.backgroundColor = [UIColor redColor];
    }
    return _inputUIButton;
}


@end
