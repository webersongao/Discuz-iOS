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
NSString * const Msg_Succeed       = @"succeed";

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
    if ([self.messageval containsString:Msg_Succeed]) {
        return NO;
    }
    return YES;
}

// 是否绑定了第三方账号
-(BOOL)isBindThird{
    if ([self.messageval containsString:Msg_No_bind]) {
        return NO;
    }
    return YES;
}


@end


