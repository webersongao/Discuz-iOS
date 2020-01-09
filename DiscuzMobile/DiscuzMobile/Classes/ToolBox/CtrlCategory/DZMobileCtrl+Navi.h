//
//  DZMobileCtrl+Navi.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"

@class PmTypeModel;
@class DZThreadModel;
@class DZBaseAuthModel;
@interface DZMobileCtrl (Navi)

- (void)PushToController:(UIViewController *)CtrlVC;

- (void)PresentViewController:(UIViewController *)CtrlVC;

- (void)PushToOtherUserController:(NSString *)userId;

/// 帖子详情页
- (void)PushToThreadDetailController:(NSString *)tid;

/// 论坛版块帖子列表
- (void)PushToForumListController:(NSString *)fid;
- (void)PushToForumListController:(NSString *)fid block:(backBoolBlock)block;

// 跳转 总版块 列表
-(void)PushToAllForumViewController;


- (void)PushToWebViewController:(NSString *)link;

// 跳转登录
- (void)PresentLoginController;
- (void)PushToSearchController;
- (void)PresentRegisterController;
- (void)PresentFastPostController;

/// 跳转 我的好友
-(void)PushToMyFriendListController;

/// 跳转 我的收藏
-(void)PushToMyCollectionViewController;


/// 跳转 我的提醒
-(void)PushToMyMessageViewController;


/// 跳转 我的帖子列表(帖子+回复)
-(void)PushToMyThreadListViewController;

/// 跳转 用户设置
-(void)PushToSettingViewController;


// 跳转 他的话题
-(void)PushToUserThreadController:(NSString *)Uid;
// 跳转 他的回复
-(void)PushToUserPostReplyController:(NSString *)Uid;

/// 账号绑定
- (void)PushToAccountBindController;

/// 浏览记录
- (void)PushToUserFootMarkController;

/// 发送消息
-(void)PushToMsgSendController:(NSString *)Uid;

/// 消息聊天界面
-(void)PushToMsgChatController:(NSString *)touid name:(NSString *)userName;

/// 重置密码
- (void)PushToResetPwdController;

/// appstore 评价APP
-(void)PushToAppStoreWebview;

/// 域名选择
-(void)PushToDomainSettingController;

/// app 介绍
-(void)PushToAppAboutViewController;

/// 用户 协议
-(void)PushToUsertermsController;

/// 分享 app
- (void)shareMyMobileAPPWithView:(UIView *)view;

/// 账号绑定状态
-(void)PushToJudgeBindController;

/// 我的帖子主题列表
- (void)PushToMyThreadViewController;

/// 查看参与投票人
-(void)PushToVisitVotersController:(NSString *)tidStr;

/// 参加活动
- (void)PushToPartInActivityController:(DZThreadModel *)threadModel;

/// 活动编辑
- (void)PushToActivityEditController:(DZThreadModel *)threadModel;

/// 我的子帖主题列表
- (void)PushToMyMsgSubListController:(NSString *)title Model:(PmTypeModel *)typeModel;

/// 投票项信息
- (void)PushToMyPollPotionController:(NSString *)pollid tid:(NSString *)tid index:(NSInteger)index;

/// 发布帖子
-(void)PushToThreadPostController:(NSString *)fid thread:(DZBaseAuthModel *)threadModel type:(PostType)type;

@end


