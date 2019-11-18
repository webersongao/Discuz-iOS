//
//  DZResetPwdView.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/17.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZWeb2AuthCodeView.h"

@class DZLoginCustomView,DZAuthCodeView;

@interface DZResetPwdView : UIScrollView <UITextFieldDelegate>

@property (nonatomic, strong) DZLoginCustomView *passwordView;
@property (nonatomic, strong) DZLoginCustomView *repassView;
@property (nonatomic, strong) DZLoginCustomView *newpasswordView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;

@property (nonatomic, strong) UIButton *submitButton;
@end
