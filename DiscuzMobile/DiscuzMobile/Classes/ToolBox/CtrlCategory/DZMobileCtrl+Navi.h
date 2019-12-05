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

// 跳转 总版块 列表
-(void)PushToAllForumViewController;


- (void)PushToWebViewController:(NSString *)link;
- (void)PresentLoginController:(UIViewController *)selfVC;

// 跳转登录
- (void)PresentLoginController:(UIViewController *)selfVC tabSelect:(BOOL)select;

- (void)PushToSearchController;

/// 跳转 我的好友
-(void)PushToMyFriendViewController;

/// 跳转 我的收藏
-(void)PushToMyCollectionViewController;


/// 跳转 我的提醒
-(void)PushToMyMessageViewController;


/// 跳转 我的帖子列表
-(void)PushToMyThreadListViewController;

/// 跳转 用户设置
-(void)PushToSettingViewController;


// 跳转 他的话题
-(void)PushToUserThreadController:(NSString *)Uid;
// 跳转 他的回复
-(void)PushToUserPostReplyController:(NSString *)Uid;

/// 账号绑定
- (void)ShowBindControllerFromVC:(UIViewController *)selfVC;

/// 重置密码
- (void)ShowResetPwdControllerFromVC:(UIViewController *)selfVC;

/// 浏览记录
- (void)ShowFootMarkControllerFromVC:(UIViewController *)selfVC;

/// 发送消息
-(void)PushToMsgSendController:(NSString *)Uid;

/// 消息聊天界面
-(void)PushToMsgChatController:(NSString *)touid name:(NSString *)userName;






@end


