//
//  DZLoginModule.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZLoginResModel.h"

extern NSString * const CookieValue;

@interface DZLoginModule : NSObject

// 分析登录信息
+(BOOL)loginAnylyeData:(DZLoginResModel *)resModel;

// 保存登录数据
+ (void)saveLoginData:(DZLoginResModel *)resModel andHandle:(void(^)(void))handle;

/*
 * 判断是否登录
 */
+ (BOOL)isLogged;

/*
 *  退出登录，清空用户信息
 */
+ (void)signout;

/*
 * 设置自动登录状态
 */
+ (void)setAutoLogin;

// 获取当前登录的uid
+ (NSString *)getLoggedUid;

// 检查cookie
+ (void)checkCookie;

// 设置cookie
+ (void)setHttpCookie:(NSHTTPCookie *)cookie;

// 保存cookie
+ (void)saveCookie:(NSHTTPCookie *)cookie;

// 获取cookie
+ (NSHTTPCookie *)getCookie;





@end
