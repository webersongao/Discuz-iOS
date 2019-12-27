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
#import "DZThreadDetailController.h"
#import "DZBaseUrlController.h"
#import "DZLoginController.h"
#import "DZSearchController.h"
#import "DZForumController.h"
#import "CollectionRootController.h"
#import "MyFriendViewController.h"
#import "DZMessageListController.h"
#import "DZThreadRootController.h"
#import "DZSettingController.h"
#import "DZMsgChatDetailController.h"
#import "DZOtherUserThreadController.h"
#import "DZOtherUserPostReplyController.h"
#import "DZBindManageController.h"
#import "DZFootMarkRootController.h"
#import "DZResetPwdController.h"
#import "DZSendMsgViewController.h"
#import "DZDomainListController.h"
#import "DZAboutController.h"
#import "DZUsertermsController.h"
#import "DZRegisterController.h"
#import "DZJudgeBoundController.h"
#import "DZPostNormalController.h"
#import "DZPostVoteController.h"
#import "DZFastPostController.h"
#import "DZPostDebateController.h"
#import "DZPostActivityController.h"

@implementation DZMobileCtrl (Navi)

- (void)PushToController:(UIViewController *)CtrlVC{
    if (CtrlVC) {
        [self.mainNavi pushViewController:CtrlVC animated:YES];
    }
}


- (void)PresentViewController:(UIViewController *)CtrlVC{
    if (CtrlVC) {
        CtrlVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.mainNavi.topViewController showViewController:CtrlVC sender:nil];
    }
}

- (void)PushToOtherUserController:(NSString *)userId{
    NSString *userIdStr = checkNull(userId);
    DZOtherUserController * ovc = [[DZOtherUserController alloc] initWithAuthor:userIdStr];
    [self.mainNavi pushViewController:ovc animated:YES];
}

/// 帖子详情页
- (void)PushToThreadDetailController:(NSString *)tid {
    DZThreadDetailController * threadVC = [[DZThreadDetailController alloc] init];
    threadVC.tid = tid;
    [self.mainNavi pushViewController:threadVC animated:YES];
}

/// 帖子详情页
- (void)ShowThreadDetailControllerFromVC:(UIViewController *)selfVC tid:(NSString *)tid{
    DZThreadDetailController *threadVC = [[DZThreadDetailController alloc] init];
    threadVC.tid = checkNull(tid);
    [selfVC showViewController:threadVC sender:nil];
}

/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid {
    [self PushToForumListController:fid block:nil];
}
/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid block:(backBoolBlock)block{
    DZForumThreadController *lianMixVc = [[DZForumThreadController alloc] init];
    lianMixVc.forumFid = fid;
    lianMixVc.cForumBlock = block;
    if (fid.length) {
        [self.mainNavi pushViewController:lianMixVc animated:YES];
    }else{
        DLog(@"没有fid 不可以跳转的");
    }
}


// 跳转 总版块 列表
-(void)PushToAllForumViewController{
    DZForumController *forumVC = [[DZForumController alloc] init];
    [self.mainNavi pushViewController:forumVC animated:YES];
}

- (void)PushToWebViewController:(NSString *)link {
    DZBaseUrlController *urlCtrl = [[DZBaseUrlController alloc] init];
    urlCtrl.urlString = link;
    [self.mainNavi pushViewController:urlCtrl animated:YES];
}


- (void)PresentLoginController{
    DZLoginController *loginVC = [[DZLoginController alloc] init];
    loginVC.isTabbarSelected = NO;
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.mainNavi.topViewController showViewController:loginVC sender:nil];
}

- (void)PresentRegisterController{
    DZRegisterController *registVC = [[DZRegisterController alloc] init];
    registVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.mainNavi.topViewController showViewController:registVC sender:nil];
}

- (void)PresentFastPostController{
    DZFastPostController *fastVC = [[DZFastPostController alloc] init];
    [[DZMobileCtrl sharedCtrl] PresentViewController:fastVC];
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


/// 账号绑定
- (void)ShowBindControllerFromVC:(UIViewController *)selfVC {
    DZBindManageController *boundVc = [[DZBindManageController alloc] init];
    [selfVC showViewController:boundVc sender:nil];
}

// 重置密码
- (void)ShowResetPwdControllerFromVC:(UIViewController *)selfVC {
    DZResetPwdController *restVc = [[DZResetPwdController alloc] init];
    [selfVC showViewController:restVc sender:nil];
}

// 浏览记录
- (void)ShowFootMarkControllerFromVC:(UIViewController *)selfVC {
    DZFootMarkRootController *footRvc = [[DZFootMarkRootController alloc] init];
    [selfVC showViewController:footRvc sender:nil];
}


// 发送消息
-(void)PushToMsgSendController:(NSString *)Uid{
    DZSendMsgViewController *sendVC = [[DZSendMsgViewController alloc] init];
    sendVC.uid = checkNull(Uid);
    [self.mainNavi pushViewController:sendVC animated:YES];
}


// 消息聊天界面
-(void)PushToMsgChatController:(NSString *)touid name:(NSString *)userName{
    DZMsgChatDetailController *mvc = [[DZMsgChatDetailController alloc] init];
    mvc.touid = touid;
    mvc.nametitle = userName;
    mvc.username = userName;
    
    [self.mainNavi pushViewController:mvc animated:YES];
}


/// 域名选择
-(void)PushToDomainSettingController {
    DZDomainListController *domainVC = [[DZDomainListController alloc] init];
    [self.mainNavi pushViewController:domainVC animated:YES];
}

/// app 介绍
-(void)PushToAppAboutViewController {
    DZAboutController *abVC = [[DZAboutController alloc] init];
    [self.mainNavi pushViewController:abVC animated:YES];
}

/// 用户 协议
-(void)PushToUsertermsController:(NSString *)bbsRulestxt {
    DZUsertermsController *termVC = [[DZUsertermsController alloc] init];
    termVC.bbrulestxt = bbsRulestxt;
    [self.mainNavi showViewController:termVC sender:nil];
}

/// appstore 评价APP
-(void)PushToAppStoreWebview {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppStorePath] options:@{} completionHandler:nil];
    } else {
        
    }
}

/// 分享 app
- (void)shareMyMobileAPPWithView:(UIView *)view {
    [[DZShareCenter shareInstance] createShare:@"Discuz客户端产品，提供方便简洁的发帖与阅读体验" andImages:@[[DZDevice getIconName]] andUrlstr:AppStorePath andTitle:DZ_APPNAME andView:view andHUD:nil];
}

/// 账号绑定状态
-(void)PushToJudgeBindController {
    DZJudgeBoundController * judegVC =[[DZJudgeBoundController alloc]init];
    [self.mainNavi pushViewController:judegVC animated:YES];
}

/// 发布帖子
-(void)PushToThreadPostController:(NSString *)fid thread:(DZBaseAuthModel *)threadModel type:(PostType)type{
    DZPostBaseController * postVC = nil;
    switch (type) {
        case post_normal:
            postVC = [[DZPostNormalController alloc] init];
            break;
        case post_vote:
            postVC = [[DZPostVoteController alloc] init];
            break;
        case post_activity:
            postVC = [[DZPostActivityController alloc] init];
            break;
        case post_debate:
            postVC = [[DZPostDebateController alloc] init];
            break;
        default:
            break;
    }
    postVC.authModel = threadModel;
    postVC.pushDetailBlock = ^(NSString *tid) {
        [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tid];
    };
    [[DZMobileCtrl sharedCtrl] PushToController:postVC];
}


@end







