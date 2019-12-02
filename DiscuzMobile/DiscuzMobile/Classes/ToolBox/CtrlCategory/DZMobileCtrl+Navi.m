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
#import "DZForumThreadMixCtrl.h"
#import "DZBaseUrlController.h"
#import "DZLoginController.h"
#import "DZSearchController.h"
#import "DZForumController.h"
#import "CollectionRootController.h"
#import "MyFriendViewController.h"
#import "DZMessageListController.h"
#import "DZThreadRootController.h"
#import "DZSettingController.h"
#import "DZOtherUserThreadController.h"
#import "DZOtherUserPostReplyController.h"

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
/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid block:(backBoolBlock)block{
    DZForumThreadMixCtrl *lianMixVc = [[DZForumThreadMixCtrl alloc] init];
    lianMixVc.forumFid = fid;
    lianMixVc.cForumBlock = block;
    [self.mainNavi pushViewController:lianMixVc animated:YES];
}


// 跳转 总版块 列表
-(void)PushToAllForumViewController{
    DZForumController *forumVC = [[DZForumController alloc] init];
    [self.mainNavi pushViewController:forumVC animated:YES];
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
    [self.mainNavi pushViewController:searchVC animated:YES];
}


// 跳转 我的好友
-(void)PushToMyFriendViewController{
    MyFriendViewController *mfvc = [[MyFriendViewController alloc] init];
    [self.mainNavi pushViewController:mfvc animated:YES];
}

// 跳转 我的收藏
-(void)PushToMyCollectionViewController{
    CollectionRootController *mfvc = [[CollectionRootController alloc] init];
    [self.mainNavi pushViewController:mfvc animated:YES];
}


// 跳转 我的提醒
-(void)PushToMyMessageViewController{
    DZMessageListController *pmVC = [[DZMessageListController alloc] init];
    [self.mainNavi pushViewController:pmVC animated:YES];
}


/// 跳转 我的帖子列表
-(void)PushToMyThreadListViewController{
    DZThreadRootController *trVc = [[DZThreadRootController alloc] init];
    [self.mainNavi pushViewController:trVc animated:YES];
}

// 跳转 用户设置
-(void)PushToSettingViewController{
    DZSettingController * setVC = [[DZSettingController alloc] init];
    [self.mainNavi pushViewController:setVC animated:YES];
}


// 跳转 他的话题
-(void)PushToUserThreadController:(NSString *)Uid{
    DZOtherUserThreadController *otherUTVC = [[DZOtherUserThreadController alloc]init];
    otherUTVC.uidstr= checkNull(Uid);
    [self.mainNavi pushViewController:otherUTVC animated:YES];
}


// 跳转 他的回复
-(void)PushToUserPostReplyController:(NSString *)Uid{
    DZOtherUserPostReplyController *otherUPRVC = [[DZOtherUserPostReplyController alloc]init];
    otherUPRVC.uidstr = checkNull(Uid);
    [self.mainNavi pushViewController:otherUPRVC animated:YES];
}



@end
