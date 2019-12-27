//
//  DZHomeTestViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeTestViewController.h"
#import "DZMessageListController.h"
#import "DZFastPostController.h"
#import "DZSearchController.h"
#import "DZLoginController.h"
#import "DZRegisterController.h"

#import "DZGaoPostViewController.h"
#import "DZPostSiriViewController.h"
#import "DZPostEditViewController.h"
#import "DZPostUIEditViewController.h"

@interface DZHomeTestViewController ()

@end

@implementation DZHomeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHomeTestViewController];
}

-(BOOL)DZ_hideTabBarWhenPushed{
    return NO;
}

-(void)configHomeTestViewController{
    
    
}


//搜索
- (IBAction)searchAction:(UIButton *)sender {
    DZSearchController *searchVC = [[DZSearchController alloc] init];
    [[DZMobileCtrl sharedCtrl] PushToController:searchVC];
}

// 注册
- (IBAction)registerAction:(UIButton *)sender {
    DZRegisterController *regisVC = [[DZRegisterController alloc] init];
    [[DZMobileCtrl sharedCtrl] PresentViewController:regisVC];
}
// 消息
- (IBAction)messageAction:(UIButton *)sender {
    DZMessageListController *msgVC = [[DZMessageListController alloc] init];
    [[DZMobileCtrl sharedCtrl] PushToController:msgVC];
}

// 发布
- (IBAction)postThreadAction:(UIButton *)sender {
    DZGaoPostViewController *fastVC = [[DZGaoPostViewController alloc] init];
//    DZFastPostController *fastVC = [[DZFastPostController alloc] init];
    [[DZMobileCtrl sharedCtrl] PresentViewController:fastVC];
}

// 登录
- (IBAction)userLoginAction:(UIButton *)sender {
    DZLoginController *loginVC = [[DZLoginController alloc] init];
    [[DZMobileCtrl sharedCtrl] PresentViewController:loginVC];
}

// Siri输入
- (IBAction)siriInputAction:(UIButton *)sender {
    DZPostSiriViewController *editSiriVC = [[DZPostSiriViewController alloc] init];
    [[DZMobileCtrl sharedCtrl] PushToController:editSiriVC];
    
}
// 默认输入
- (IBAction)defautInputAction:(UIButton *)sender {
    
    DZPostEditViewController *editVC = [[DZPostEditViewController alloc] init];
    [[DZMobileCtrl sharedCtrl] PushToController:editVC];
}

// UI 输入
- (IBAction)siriUIInputAction:(UIButton *)sender {
    DZPostUIEditViewController *editUIVC = [[DZPostUIEditViewController alloc] init];
    [[DZMobileCtrl sharedCtrl] PushToController:editUIVC];
}


// 阅读器
- (IBAction)readerAction:(UIButton *)sender {
    
}

// 书城
- (IBAction)bookStoreAction:(UIButton *)sender {
    
}

// 设置
- (IBAction)settingAction:(UIButton *)sender {
    
}

// 支付
- (IBAction)applePayAction:(UIButton *)sender {
    
}

// 广告
- (IBAction)appAdvertAction:(UIButton *)sender {
    
}

// 修改密码
- (IBAction)resetPasswordAction:(UIButton *)sender {
    
}

// 微信登录
- (IBAction)weixinLoginAction:(UIButton *)sender {
    
}

// 退出账号
- (IBAction)userLogOutAction:(UIButton *)sender {
    
}



@end










