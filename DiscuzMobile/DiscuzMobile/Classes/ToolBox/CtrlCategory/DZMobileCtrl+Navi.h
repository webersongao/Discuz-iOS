//
//  DZMobileCtrl+Navi.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"

@interface DZMobileCtrl (Navi)

- (void)PushToController:(UIViewController *)CtrlVC;

- (void)PushToOtherUserController:(NSString *)userId;

/// 帖子详情页
- (void)PushToThreadDetailController:(NSString *)tid;
- (void)ShowThreadDetailControllerFromVC:(UIViewController *)selfVC tid:(NSString *)tid;

/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid;
- (void)PushToForumListController:(NSString *)fid block:(backBoolBlock)block;

- (void)PushToWebViewController:(NSString *)link;
- (void)PresentLoginController:(UIViewController *)selfVC;

// 跳转登录
- (void)PresentLoginController:(UIViewController *)selfVC tabSelect:(BOOL)select;

- (void)PushToSearchController;

@end


