//
//  DZLoginView.h
//  DiscuzMobile
//
//  Created by HB on 17/1/10.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZLoginCustomView.h"
#import "DZWeb2AuthCodeView.h"
#import "ZHPickView.h"
@class DZLoginCustomView, DZWeb2AuthCodeView, ZHPickView;

@interface DZLoginView : UIScrollView

@property (nonatomic, strong) DZLoginCustomView *countView;
@property (nonatomic, strong) DZLoginCustomView *pwordView;
@property (nonatomic, strong) DZLoginCustomView *securityView;
@property (nonatomic, strong) DZLoginCustomView *answerView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UILabel *thridAuthTipLabl;
@property (nonatomic, strong) UIView *thirdView;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *qqBtn;

@property (nonatomic, strong) ZHPickView *pickView;

- (void)thirdPlatformAuth;

@end
