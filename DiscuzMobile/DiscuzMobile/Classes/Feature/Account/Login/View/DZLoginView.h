//
//  DZLoginView.h
//  DiscuzMobile
//
//  Created by HB on 17/1/10.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZLoginTextField.h"
#import "DZWeb2AuthCodeView.h"
#import "ZHPickView.h"
@class DZLoginTextField, DZWeb2AuthCodeView, ZHPickView;

@interface DZLoginView : UIScrollView

@property (nonatomic, strong) DZLoginTextField *countView;
@property (nonatomic, strong) DZLoginTextField *pwordView;
@property (nonatomic, strong) DZLoginTextField *securityView;
@property (nonatomic, strong) DZLoginTextField *answerView;
@property (nonatomic, strong) DZWeb2AuthCodeView *authCodeView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, strong) UILabel *thridAuthTipLabl;
@property (nonatomic, strong) UIView *thirdView;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *qqBtn;

@property (nonatomic, strong) ZHPickView *pickView;

- (void)thirdPlatformAuth;

-(instancetype)initWithFrame:(CGRect)frame isQQ:(BOOL)isQQ isWx:(BOOL)isWx;

@end
