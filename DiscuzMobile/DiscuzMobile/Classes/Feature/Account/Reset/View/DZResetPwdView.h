//
//  DZResetPwdView.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/17.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZWeb2AuthCodeView.h"

@class DZLoginTextField,DZAuthCodeView;

@interface DZResetPwdView : UIScrollView <UITextFieldDelegate>

@property (nonatomic, strong) DZLoginTextField *passwordView;
@property (nonatomic, strong) DZLoginTextField *repassView;
@property (nonatomic, strong) DZLoginTextField *newpasswordView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;

@property (nonatomic, strong) UIButton *submitButton;
@end
