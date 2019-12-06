//
//  DZRegisterView.h
//  DiscuzMobile
//
//  Created by HB on 17/1/11.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsertermsView.h"
#import "DZWeb2AuthCodeView.h"

@class DZLoginTextField,DZAuthCodeView;

@interface DZRegisterView : UIScrollView <UITextFieldDelegate>
@property (nonatomic, strong) DZLoginTextField *usernameView;
@property (nonatomic, strong) DZLoginTextField *passwordView;
@property (nonatomic, strong) DZLoginTextField *repassView;
@property (nonatomic, strong) DZLoginTextField *emailView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;
@property (nonatomic, strong) UILabel *thridAuthTipLabl;

@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UsertermsView *usertermsView;

- (void)thirdPlatformAuth;

@end
