//
//  DZRegisterView.h
//  DiscuzMobile
//
//  Created by HB on 17/1/11.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsertermsView.h"

@class DZLoginCustomView,DZAuthCodeView,DZWeb2AuthCodeView;

@interface DZRegisterView : UIScrollView <UITextFieldDelegate>
@property (nonatomic, strong) DZLoginCustomView *usernameView;
@property (nonatomic, strong) DZLoginCustomView *passwordView;
@property (nonatomic, strong) DZLoginCustomView *repassView;
@property (nonatomic, strong) DZLoginCustomView *emailView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;
@property (nonatomic, strong) UILabel *thridAuthTipLabl;

@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UsertermsView *usertermsView;

- (void)thirdPlatformAuth;

@end
