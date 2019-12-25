//
//  DZLoginBaseController.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/12.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZLoginBaseController.h"
#import "DZPushCenter.h"

@interface DZLoginBaseController ()

@end

@implementation DZLoginBaseController

#pragma mark - 请求成功操作
- (void)updateUserResInfo:(DZLoginResModel *)loginResModel {
    [DZLoginModule loginAnylyeData:loginResModel andView:self.view andHandle:^{ // 登录成功操作
        [[DZPushCenter shareInstance] configPush]; // 设置推送
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_LoginedRefreshInfo_Notify object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_REFRESHCENTER_Notify object:nil]; // 获取资料
        [[NSNotificationCenter defaultCenter] postNotificationName:COLLECTIONFORUMREFRESH object:nil]; // 板块列表刷新
        [self dismissViewControllerAnimated:YES completion:nil];
        
        UITabBarController *tabbBarVC = (UITabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        UINavigationController *navVC = tabbBarVC.childViewControllers[tabbBarVC.selectedIndex];
        if (navVC.childViewControllers.count == 1 && !self.isKeepTabbarSelected) {
            NSDictionary *userInfo = @{@"type":@"loginSuccess"};
            [[NSNotificationCenter defaultCenter] postNotificationName:DZ_configSelectedIndex_Notify object:nil userInfo:userInfo];
        }
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (DZSecVerifyView *)verifyView {
    if (!_verifyView) {
        _verifyView = [[DZSecVerifyView alloc] init];
    }
    return _verifyView;
}

@end
