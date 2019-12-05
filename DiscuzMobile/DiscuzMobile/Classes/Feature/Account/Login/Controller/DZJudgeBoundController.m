//
//  TTBoundThirdController.m
//  DiscuzMobile
//
//  Created by HB on 16/9/18.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZJudgeBoundController.h"
#import "DZJudgeBoundView.h"

@interface DZJudgeBoundController ()

@property (nonatomic,strong) DZJudgeBoundView *judgeView;

@end

@implementation DZJudgeBoundController

- (void)loadView {
    [super loadView];
    _judgeView = [[DZJudgeBoundView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _judgeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dz_NavigationItem.title = @"关联登录";
    self.view.backgroundColor = mRGBColor(246, 246, 246);
    [self setAction];
}

- (void)setAction {
    
    NSMutableAttributedString *describe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"亲爱的用户：%@为了给您更好的服务，请关联一个掌上论坛账号",[DZShareCenter shareInstance].bloginModel.username]];
    NSRange dearRange = {0,5};
    NSInteger nameLength = [[NSString stringWithFormat:@"%@",[DZShareCenter shareInstance].bloginModel.username] length];
    NSRange nameRange = {6,nameLength};
    
    NSRange allRange = {0,[describe length]};
    [describe addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:allRange];
    [describe addAttribute:NSFontAttributeName value:[DZFontSize forumtimeFontSize14] range:allRange];
    
    [describe addAttribute:NSForegroundColorAttributeName value:K_Color_LightText range:dearRange];
    [describe addAttribute:NSFontAttributeName value:[DZFontSize HomecellTimeFontSize16] range:dearRange];
    
    [describe addAttribute:NSForegroundColorAttributeName value:K_Color_MainTitle range:nameRange];
    [describe addAttribute:NSFontAttributeName value:[DZFontSize HomecellTimeFontSize16] range:nameRange];
    
    _judgeView.desclabl.attributedText = describe;
    
     [_judgeView.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_judgeView.boundBtn addTarget:self action:@selector(boundBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registerBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToAccountRegisterController];
}

- (void)boundBtnClick {
    [self leftBarBtnClick];
}


@end
