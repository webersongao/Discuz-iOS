//
//  DZLoginBaseController.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/12.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseViewController.h"
#import "DZShareCenter.h"
#import "DZSecVerifyView.h"

typedef void(^RefreshBlock)(void);

@interface DZLoginBaseController : DZBaseViewController<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isKeepTabbarSelected;     // tabbar页面的时候跳登录页面考虑这个属性
@property (nonatomic, strong) DZSecVerifyView *verifyView; // 验证码

- (void)updateUserResInfo:(DZLoginResModel *)loginResModel;

@end
