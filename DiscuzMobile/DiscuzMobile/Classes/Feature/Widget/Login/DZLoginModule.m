//
//  DZLoginModule.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZLoginModule.h"
#import "DZPushCenter.h"
#import "DZShareCenter.h"
#import "DZUserNetTool.h"

NSString * const CookieValue = @"COOKIEVALU";

@implementation DZLoginModule

+ (void)loginAnylyeData:(DZLoginResModel *)resModel andView:(UIView *)view  andHandle:(void(^)(void))handle {
  
    if (resModel.Message && !resModel.Message.isSuccessed) {
        [MBProgressHUD showInfo:resModel.Message.messagestr];
        return;
    }
    
    if(!resModel.Variables.auth.length) {
        [MBProgressHUD showInfo:resModel.Message.messagestr];
        return;
    }
    
    if (!resModel.Variables.member_uid.length) {
        [MBProgressHUD showInfo:@"未能获取到您的用户id"];
        return;
    }
    
    // 普通登录或者登录成功
    [DZMobileCtrl sharedCtrl].User = resModel.Variables;
    [DZLoginModule saveLocalUserInfo:resModel.Variables];
    NSString *cookirStr = [DZMobileCtrl sharedCtrl].User.authKey;
    for (NSHTTPCookie * cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([[cookie name] isEqualToString:checkNull(cookirStr)]) {
            [DZLoginModule saveCookie:cookie];
        }
    }
    handle?handle():nil;
}

/*
 * 判断是否登录
 */
+ (BOOL)isLogged {
    NSString *uid = [DZMobileCtrl sharedCtrl].User.member_uid;
    NSString *auth = [DZMobileCtrl sharedCtrl].User.auth;
    if ([DataCheck isValidString:uid] && [DataCheck isValidString:auth]) {
        return YES;
    }
    return NO;
}


/*
 * 退出登录
 */
+ (void)signout {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:CookieValue];
    [[DZPushCenter shareInstance] configPush];
    for (NSHTTPCookie *cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    //  LoginFile
    [[DZLocalContext shared] removeLocalUser];
    [DZShareCenter shareInstance].bloginModel = nil;
    
}

/*
 * 设置自动登录状态
 */

+ (void)setAutoLogin {
   DZUserModel *user = [[DZLocalContext shared] GetLocalUserInfo];
    if (user.member_uid.length) {
        [self setHttpCookie:[self getCookie]];
    }
}

/*
 * 保存登录信息到本地
 */
+ (void)saveLocalUserInfo:(DZUserModel *)varinfo {
    [[DZLocalContext shared] updateLocalUser:varinfo];
}

// 获取当前登录的uid
+ (NSString *)getLoggedUid {
    NSString *uid = [DZMobileCtrl sharedCtrl].User.member_uid;
    if (![DataCheck isValidString:uid]) {
        uid = @"0";
    }
    return uid;
}

#pragma mark - cookie
// 检查cookie
+ (void)checkCookie {
    if ([self isLogged]) {
        [DZUserNetTool DZ_UserProfileFromServer:YES Uid:nil userBlock:^(DZUserVarModel *UserVarModel, NSString *errorStr) {
            if (errorStr.length) {
                [DZLoginModule signout];
                DLog(@"WBS Cookie 过期");
            }
        }];
    }
}

+ (void)setHttpCookie:(NSHTTPCookie *)cookie {
    if (cookie) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

// 保存cookie
+ (void)saveCookie:(NSHTTPCookie *)cookie {
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:cookie];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:CookieValue];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSHTTPCookie *)getCookie {
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:CookieValue];
    NSHTTPCookie * cookie_PD = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return cookie_PD;
}


@end

