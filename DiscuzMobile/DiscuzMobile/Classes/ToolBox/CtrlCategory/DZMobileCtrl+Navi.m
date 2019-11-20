//
//  DZMobileCtrl+Navi.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Navi.h"
#import "DZOtherUserController.h"
#import "DZForumThreadController.h"
#import "LianMixAllViewController.h"
#import "DZBaseUrlController.h"
#import "DZLoginController.h"
#import "DZSearchController.h"

@implementation DZMobileCtrl (Navi)

- (void)PushToController:(UIViewController *)CtrlVC{
    [self.mainNavi pushViewController:CtrlVC animated:YES];
}

- (void)PushToOtherUserController:(NSString *)userId{
    NSString *userIdStr = checkNull(userId);
    if (userIdStr.length) {
        DZOtherUserController * ovc = [[DZOtherUserController alloc] init];
        ovc.authorid = userIdStr;
        [self.mainNavi pushViewController:ovc animated:YES];
    }
}

/// 帖子详情页
- (void)PushToThreadDetailController:(NSString *)tid {
    DZForumThreadController * threadVC = [[DZForumThreadController alloc] init];
    threadVC.tid = tid;
    [self.mainNavi pushViewController:threadVC animated:YES];
}

/// 帖子详情页
- (void)ShowThreadDetailControllerFromVC:(UIViewController *)selfVC tid:(NSString *)tid{
    DZForumThreadController *threadVC = [[DZForumThreadController alloc] init];
    threadVC.tid = checkNull(tid);
    [selfVC showViewController:threadVC sender:nil];
}

/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid {
    [self PushToForumListController:fid block:nil];
}
- (void)PushToForumListController:(NSString *)fid block:(backBoolBlock)block{
    LianMixAllViewController *lianMixVc = [[LianMixAllViewController alloc] init];
    lianMixVc.forumFid = fid;
    lianMixVc.cForumBlock = block;
    [self.mainNavi pushViewController:lianMixVc animated:YES];
}

- (void)PushToWebViewController:(NSString *)link {
    DZBaseUrlController *urlCtrl = [[DZBaseUrlController alloc] init];
    urlCtrl.hidesBottomBarWhenPushed = YES;
    urlCtrl.urlString = link;
    [self.mainNavi pushViewController:urlCtrl animated:YES];
}


- (void)PresentLoginController:(UIViewController *)selfVC{
    
    [self PresentLoginController:selfVC tabSelect:NO];
}

- (void)PresentLoginController:(UIViewController *)selfVC tabSelect:(BOOL)select{

    DZLoginController *loginVC = [[DZLoginController alloc] init];
    loginVC.isKeepTabbarSelected = select;
    
    if (!selfVC) {
        [self.mainNavi presentViewController:loginVC animated:YES completion:nil];
    }else{
        UINavigationController * preVC = [[UINavigationController alloc] initWithRootViewController:loginVC];;
        [selfVC presentViewController:preVC animated:YES completion:nil];
    }
}



- (void)PushToSearchController{
    
    DZSearchController *searchVC = [[DZSearchController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.mainNavi pushViewController:searchVC animated:YES];
}






@end
