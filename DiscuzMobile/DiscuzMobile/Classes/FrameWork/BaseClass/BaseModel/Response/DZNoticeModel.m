//
//  DZNoticeModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZNoticeModel.h"

NSString * const Msg_NoMedal        = @"nomedal";
NSString * const Msg_NoExistence    = @"nonexistence";
NSString * const Msg_NoPermission   = @"nopermission";

NSString * const Msg_BindSucc       = @"succeed";
NSString * const Msg_Succeed       = @"succeed"; // 举报成功 发布成功
NSString * const Msg_CancelSucc       = @"_success";  // 取消活动
NSString * const Msg_SendMsgSucc       = @"do_success"; // 私信发送成功
NSString * const Msg_MsgSucc       = @"success"; //私信状态
NSString * const Msg_ActiviMaSucc   = @"_completion"; // 活动管理批准
NSString * const Msg_ApplySucc       = @"activity_completion"; //报名参与活动



NSString * const Msg_No_bind        = @"no_bind";  //未绑定第三方在账号
NSString * const Msg_loginEmpty       = @"login_question_empty";  // 登录问题为空


@implementation DZNoticeModel

@end

@implementation DZBackMsgModel


// 是否已授权
-(BOOL)isAuthorized{
    if ([self.messageval containsString:Msg_NoMedal] || [self.messageval containsString:Msg_NoPermission] || [self.messageval containsString:Msg_NoExistence]) {
        return NO;
    }
    return YES;
}

// 是否绑定成功
-(BOOL)isBindSuccess{
    if ([self.messageval containsString:Msg_BindSucc]) {
        return YES;
    }
    return NO;
}

// 是否成功状态
-(BOOL)isSuccessed{
    if ([self.messageval containsString:Msg_Succeed] || [self.messageval containsString:Msg_CancelSucc] || [self.messageval containsString:Msg_SendMsgSucc] || [self.messageval containsString:Msg_MsgSucc] || [self.messageval containsString:Msg_ApplySucc] || [self.messageval containsString:Msg_ActiviMaSucc]) {
        return YES;
    }
    return NO;
}

// 是否绑定了第三方账号
-(BOOL)isBindThird{
    if ([self.messageval containsString:Msg_No_bind]) {
        return NO;
    }
    return YES;
}

// 是否 登录问题为空
-(BOOL)isLoginEmpty{
    if ([self.messageval isEqualToString:Msg_loginEmpty]) {
        return YES;
    }
    return NO;
}




@end


